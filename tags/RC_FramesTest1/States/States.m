classdef States < handle
    properties
        status
        erroredAction
        prevAction
        currentAction
        slog = Logger('States')
    end
    methods
        function me = States()
            me.status = StateEnum({...
                'READY',...
                'BUSY',...
                'ERRORS EXIST',...
                });
            me.erroredAction = -1;
            me.prevAction = 0;
        end
        function statusReady(me)
            me.status.setState('READY');
        end
        function recover(me)
            if me.erroredAction < 0
                return;
            end
            me.status.setState('BUSY');
            me.currentAction.idx = me.erroredAction;
            me.erroredAction = -1;
        end
        function statusBusy(me)
            me.status.setState('BUSY');
        end
        function statusErrored(me)
            me.status.setState('ERRORS EXIST');
            me.erroredAction = me.currentAction.idx;
        end
        function yes = isReady(me)
            yes = me.status.isState('READY');
        end
        function yes = hasErrors(me)
            yes = me.status.isState('ERRORS EXIST');
        end
        function setStatus(me, status)
            me.status.setState(status.getState());
        end
        function yes = stateChanged(me)
            yes = false;
            if me.currentAction.idx ~= me.prevAction
                me.slog.debug(dbstack,sprintf('Executing action %s',me.currentAction.getState()));
                me.prevAction = me.currentAction.idx;
                yes = true;
            end
        end
    end
end
