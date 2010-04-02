classdef BroadcastResponses < BroadcasterState
    properties
        action = StateEnum({ ...
            'DONE'...
            'BROADCASTING', ...
            });
        id = {}
        target
        log = Logger('BroadcastResponses');
        abort
    end
    methods
        function me = BroadcastResponses()
            me.abort = false;
        end
        function start(me)
            me.mdlBroadcast.start(me.dat.curStepData.stepNum);
            me.statusBusy();
            me.action.setState('BROADCASTING');
        end
        function done = isDone(me)
            done = 0;
            if me.mdlBroadcast.isDone() == 0
                return;
            end
            if me.mdlBroadcast.state.isState('ERRORS EXIST')
                me.statusErrored();
                done = 1;
                return;
            end
            a = me.action.getState();
            me.log.debug(dbstack,sprintf('action is %s',a));
            switch a
                case 'DONE'
                    done = 1;
                    me.statusReady();
                case {'BROADCASTING'}
                    me.action.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end