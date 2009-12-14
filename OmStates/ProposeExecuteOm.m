classdef ProposeExecuteOm < OmState
    properties
        action = StateEnum({ ...
            'DONE'...
            'PROPOSE', ...
            });
        id = {}
        log = Logger('ProposeExecuteOm');
    end
    methods
        function start(me)
            me.startPropose();
            me.statusBusy();
        end
        function done = isDone(me)
            done = 0;
            if me.mdlLbcb.isDone() == 0
                return;
            end
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                me.statusErrored();
                done = 1;
                return;
            end
            a = me.action.getState();
            switch a
                case 'DONE'
                    me.statusReady();
                    done = 1;
                case 'PROPOSE'
                    me.startExecute();
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
            me.action.setState('DONE');
        end
    end
end