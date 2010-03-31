classdef States < handle
    properties
        status
    end
    methods
        function me = States()
            me.status = StateEnum({...
                'READY',...
                'BUSY',...
                'ERRORS EXIST',...
                });
        end
        function statusReady(me)
            me.status.setState('READY');
        end
        function statusBusy(me)
            me.status.setState('BUSY');
        end
        function statusErrored(me)
            me.status.setState('ERRORS EXIST');
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
    end
end
