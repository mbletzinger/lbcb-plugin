classdef StepExecute < handle
    properties
        ocOm = [];
        currentStepAction = StateEnum({...
            'NEXT STEP',...
            'CHECK LIMITS'...
            'OM PROPOSE EXECUTE',...
            'OM GET CONTROL POINTS',...
            'PROCESS OM RESPONSE',...
            'BROADCAST TRIGGER',...
            'DONE'
            });
        state = StateEnum({...
            'BUSY',...
            'COMPLETED',...
            'ERRORS EXIST'...
            });
        log = Logger;
    end
    methods
        function start(me,action)
            switch action
                case 'OPEN OM CONNECTION'
                    me.ocOm.start(0);
                    start(me.simTimer);
                case 'CLOSE OM CONNECTION'
                    me.ocOm.start(1);
                    start(me.simTimer);
                case 'OPEN SIMCOR CONNECTION'
                case 'CLOSE SIMCOR CONNECTION'
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
            me.currentAction.setState(action);
        end
        function done = isDone(me)
            switch me.currentAction.getState()
                case { 'OPEN OM CONNECTION' 'CLOSE OM CONNECTION'}
                    done = me.ocOm.isDone();
                    if done
                        if me.ocOm.state.isState('ERRORS EXIST') == 0
                            me.log.debug(dbstack,'Open connection has errors');
                            me.state.setState('ERRORS EXIST');
                        end
                        me.state.setState('COMPLETED');
                    end
                case 'OPEN SIMCOR CONNECTION'
                case 'CLOSE SIMCOR CONNECTION'
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
end