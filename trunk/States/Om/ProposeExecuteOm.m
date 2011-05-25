classdef ProposeExecuteOm < OmState
    properties
        id = {}
        log = Logger('ProposeExecuteOm');
        connectionError;
    end
    methods
        function me = ProposeExecuteOm()
            me = me@OmState();
            me.currentAction = StateEnum({ ...
                'DONE'...
                'PROPOSE', ...
                'WAIT FOR EXECUTE ACK'
                });
            me.connectionError = 0;
        end
        function start(me)
            me.connectionError = 0;
            me.startPropose();
            me.statusBusy();
        end
        function done = isDone(me)
            a = me.currentAction.getState();
            me.stateChanged();
            done = 0;
            if me.mdlLbcb.isDone() == 0
                return;
            end
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                me.connectionError = 1;
                me.statusErrored();
                me.log.error(dbstack,'OM Link has errored out');
                me.currentAction.setState('DONE');
                done = 1;
                return;
            end
            response = me.mdlLbcb.response;
            if response.isOk() == false
                me.connectionError = 0; % should be redundent
                me.statusErrored();
                me.log.error(dbstack,'OM has declined a proposed command');
                me.currentAction.setState('DONE');
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
                    me.currentAction.setState('DONE');
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
            me.currentAction.setState('PROPOSE');
        end
        function startExecute(me)
            address = me.cdp.getAddress();
            stepNum = me.dat.nextStepData.stepNum;
            jmsg = me.mdlLbcb.createCommand('execute',address,[],[]);
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlLbcb.start(jmsg,stepNum,0);
            me.currentAction.setState('WAIT FOR EXECUTE ACK');
        end
    end
end