classdef ProposeExecuteOm < SimulationState
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
            ml = SimulationState.getMdlLbcb();
            if ml.isDone() == 0
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
            jmsg = me.step.generateProposeMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            ml = SimulationState.getMdlLbcb();
            ml.start(jmsg,me.step.simstep,1);
            me.state.setState('BUSY');
            me.action.setState('PROPOSE');
        end
        function startExecute(me)
            ml = SimulationState.getMdlLbcb();
            address = StepData.getAddress();
            jmsg = ml.createCommand('execute',address,[],[]);
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            ml.start(jmsg,me.step.simstep,0);
            me.state.setState('BUSY');
            me.action.setState('DONE');
        end
    end
end