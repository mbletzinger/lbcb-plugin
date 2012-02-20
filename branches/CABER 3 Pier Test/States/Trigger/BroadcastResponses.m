classdef BroadcastResponses < BroadcasterState
    properties
        id = {}
        target
        log = Logger('BroadcastResponses');
        abort
    end
    methods
        function me = BroadcastResponses()
            me = me@BroadcasterState();
            me.abort = false;
        me.currentAction = StateEnum({ ...
            'DONE'...
            'BROADCASTING', ...
            });
        end
        function start(me)
            if me.mdlBroadcast.state.isState('NOT LISTENING')
                return;
            end
            me.mdlBroadcast.start(me.dat.curStepData.stepNum);
            me.statusBusy();
            me.currentAction.setState('BROADCASTING');
        end
        function done = isDone(me)
            if me.mdlBroadcast.state.isState('NOT LISTENING')
                done = 1;
                return;
            end
            done = 0;
            me.stateChanged();
            if me.mdlBroadcast.isDone() == 0
                return;
            end
            if me.mdlBroadcast.state.isState('ERRORS EXIST')
                me.statusErrored();
                done = 1;
                return;
            end
            a = me.currentAction.getState();
            me.log.debug(dbstack,sprintf('action is %s',a));
            switch a
                case 'DONE'
                    done = 1;
                    me.statusReady();
                case {'BROADCASTING'}
                    me.currentAction.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end