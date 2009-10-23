classdef ProposeExecuteOm < SimState
    properties
        action = StateEnum({ ...
            'DONE'...
            'PROPOSE', ...
            });
        id = {}
    end
    methods
        function start(me)
            me.startPropose();
        end
        function done = isDone(me)
            done = 0;
            me.mlLbcb = SimState.getMdlLbcb();
            if me.mlLbcb.isDone() == 0
                return;
            end
            me.state.setState(me.mlLbcb.state.getState);
            if me.state.isState('ERRORS EXIST')
                done = 1;
                return;
            end
            a = me.action.getState();
            switch a
                case 'DONE'
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
            jmsg = me.dat.nextStep.generateProposeMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mlLbcb.start(jmsg,me.step.simstep,1);
            me.state.setState('BUSY');
            me.action.setState('PROPOSE');
        end
        function startExecute(me)
            address = me.getAddress();
            jmsg = me.mlLbcb.createCommand('execute',address,[],[]);
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mlLbcb.start(jmsg,me.step.simstep,0);
            me.state.setState('BUSY');
            me.action.setState('DONE');
        end
    end
end