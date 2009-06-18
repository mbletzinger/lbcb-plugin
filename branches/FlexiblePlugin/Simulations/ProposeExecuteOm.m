classdef ProposeExecuteOm < SimulationState
    properties
        action = StateEnum({ ...
            'DONE'...
            'PROPOSE', ...
            'EXECUTE', ...
            });
    end
    methods
        function start(me)
            me.startPropose();
        end
        function done = isDone(me)
            done = 0;
            if getMdlLbcb().isDone() == 0
                return;
            end
            a = me.action.getState();
            switch a
                case 'DONE'
                    done = 1;
                case 'PROPOSE'
                    me.startExecute();
                case 'EXECUTE'
                    me.startGetControlPoint();
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
    methods (Access=private)
        function startPropose(me)
            jmsg = me.step.generateProposeMsg();
            getMdlLbcb().start(jmsg,me.steps.simstep);
            me.state.setState('BUSY');
            me.action.setState('PROPOSE');
        end
        function startExecute(me)
            jmsg = getMdlLbcb().createCommand('execute',me.targets(1).node,[],[]);
            getMdlLbcb().start(jmsg,me.steps.simstep);
            me.state.setState('BUSY');
            me.action.setState('EXECUTE');
        end
    end
end