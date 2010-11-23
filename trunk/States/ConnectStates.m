classdef ConnectStates < SimStates
    properties
        prevAction
        ocSimCor
        log = Logger('ConnectStates');
    end
    methods
        function me = ConnectStates()
            me = me@SimStates();
            me.currentAction = StateEnum({...
                'OPEN OM CONNECTION',...
                'CLOSE OM CONNECTION',...
                'OPEN SIMCOR CONNECTION',...
                'CLOSE SIMCOR CONNECTION'...
                });
        end
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
            a = me.currentAction.getState();
            me.stateChanged()
            switch a
                case 'OPEN OM CONNECTION'
                    done = me.ocOm.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                        if me.isReady()
                            me.log.info(dbstack,'Operation Manager is connected');
                        end
                    end
                case 'CLOSE OM CONNECTION'
                    done = me.ocOm.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                    end
                    if me.isReady()
                        me.log.info(dbstack,'Operation Manager is no longer connected');
                    end
                case 'OPEN SIMCOR CONNECTION'
                    done = me.ocSimCor.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                    end
                    if me.isReady()
                        me.log.info(dbstack,'UI-SimCor is connected');
                    end
                case 'CLOSE SIMCOR CONNECTION'
                    done = me.ocSimCor.isDone();
                    if done
                        me.setStatus(me.ocOm.status);
                    end
                    if me.isReady()
                        me.log.info(dbstack,'UI-SimCor is no longer connected');
                    end
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
end