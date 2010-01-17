classdef ProposeExecuteOm < OmState
    properties
        action = StateEnum({ ...
            'DONE'...
            'PROPOSE', ...
            'WAIT FOR EXECUTE ACK'
            });
        prevAction
        id = {}
        log = Logger('ProposeExecuteOm');
    end
    methods
        function me = ProposeExecuteOm()
            me.prevAction = 0;
        end
        function start(me)
            me.startPropose();
            me.statusBusy();
        end
        function done = isDone(me)
            a = me.action.getState();
            if me.action.idx ~= me.prevAction
                me.log.debug(dbstack,sprintf('Executing action %s',a));
                me.prevAction = me.action.idx;
            end
            done = 0;
            if me.mdlLbcb.isDone() == 0
                return;
            end
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                me.statusErrored();
                me.log.error(dbstack,'OM Link has errored out');
                me.action.setState('DONE');
                done = 1;
                return;
            end
            switch a
                case 'DONE'
                    me.statusReady();
                    done = 1;
                case 'PROPOSE'
                    me.startExecute();
                case 'WAIT FOR EXECUTE ACK'
                    me.action.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
    methods (Access=private)
        function startPropose(me)
            stepNum = me.dat.nextStepData.stepNum;
            jmsg = me.dat.nextStepData.generateOmProposeMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlLbcb.start(jmsg,stepNum,1);
            me.action.setState('PROPOSE');
        end
        function startExecute(me)
            address = me.cdp.getAddress();
            stepNum = me.dat.nextStepData.stepNum;
            jmsg = me.mdlLbcb.createCommand('execute',address,[],[]);
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlLbcb.start(jmsg,stepNum,0);
            me.action.setState('WAIT FOR EXECUTE ACK');
        end
    end
end