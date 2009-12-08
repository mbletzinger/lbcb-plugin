classdef ConnectStates < SimStates
    properties
        currentAction = StateEnum({...
            'OPEN OM CONNECTION',...
            'CLOSE OM CONNECTION',...
            'OPEN SIMCOR CONNECTION',...
            'CLOSE SIMCOR CONNECTION'...
            });
        ocSimCor
    end
    methods
        function start(me,action)
            switch action
                case 'OPEN OM CONNECTION'
                    me.ocOm.start(0);
                case 'CLOSE OM CONNECTION'
                    me.ocOm.start(1);
                case 'OPEN SIMCOR CONNECTION'
                    me.ocSimCor.start(0);
                case 'CLOSE SIMCOR CONNECTION'
                    me.ocSimCor.start(1);
                otherwise
                    me.log(dbstack,sprintf('%s action not recognized',action));
            end
            me.currentAction.setState(action);
        end
        function done = isDone(me)
            switch me.currentAction.getState()
                case { 'OPEN OM CONNECTION' 'CLOSE OM CONNECTION'}
                    done = me.ocOm.isDone();
                    if done
                        if me.ocOm.state.isState('ERRORS EXIST') == 0
                            me.state.setState('ERRORS EXIST');
                        end
                        me.state.setState('COMPLETED');
                    end
                case { 'OPEN SIMCOR CONNECTION' 'CLOSE SIMCOR CONNECTION' }
                    done = me.ocSimCor.isDone();
                    if done
                        if me.ocSimCor.state.isState('ERRORS EXIST') == 0
                            me.state.setState('ERRORS EXIST');
                        end
                        me.state.setState('COMPLETED');
                    end
                otherwise
                    me.log(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
end