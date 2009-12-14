classdef ConnectStates < SimStates
    properties
        currentAction = StateEnum({...
            'OPEN OM CONNECTION',...
            'CLOSE OM CONNECTION',...
            'OPEN SIMCOR CONNECTION',...
            'CLOSE SIMCOR CONNECTION'...
            });
        ocSimCor
        log = Logger('ConnectStates');
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
            me.statusBusy();
            me.currentAction.setState(action);
        end
        function done = isDone(me)
            switch me.currentAction.getState()
                case { 'OPEN OM CONNECTION' 'CLOSE OM CONNECTION'}
                    done = me.ocOm.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                    end
                case { 'OPEN SIMCOR CONNECTION' 'CLOSE SIMCOR CONNECTION' }
                    done = me.ocSimCor.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                    end
                otherwise
                    me.log(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
end