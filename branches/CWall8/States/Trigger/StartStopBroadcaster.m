classdef StartStopBroadcaster < BroadcasterState
    properties
        connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        log = Logger('StartStopBroadcastTrigger');
    end
    methods
        function me = StartStopBroadcaster()
            me = me@BroadcasterState();
            me.connectionStatus.setState('DISCONNECTED');
            me.currentAction = StateEnum({...
                'STARTING',...
                'STOPPING',...
                'DONE',...
                });
        end
        function aborted = start(me, closeIt)
            me.closeIt = closeIt;
            aborted = false;
            if closeIt && me.connectionStatus.isState('DISCONNECTED')
                me.log.error(dbstack,'Trigger Broadcaster already stopped');
                aborted = true;
                return;
            end
            if closeIt == 0 && me.connectionStatus.isState('CONNECTED')
                me.log.error(dbstack,'Trigger Broadcaster already started');
                aborted = true;
                return;
            end
            if me.closeIt
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    me.mdlBroadcast.shutdown();
                    me.currentAction.setState('STOPPING');
                end
            else
                me.mdlBroadcast.startup();
                me.currentAction.setState('STARTING');
                me.connectionStatus.setState('CONNECTED');
            end
        end
        function done = isDone(me)
            done = 0;
            me.stateChanged();
            mlDone = me.mdlBroadcast.isDone();
            if mlDone == 0
                return;
            end
            
            if me.mdlBroadcast.state.isState('ERRORS EXIST')
                done = 1;
                me.connectionError();
                return;
            end
            a = me.currentAction.getState();
            if me.currentAction.idx ~= me.prevAction
                me.log.debug(dbstack,sprintf('Executing action %s',a));
                me.prevAction = me.currentAction.idx;
            end
            
            switch a
                case 'STARTING'
                    me.startBroadcaster();
                case 'STOPPING'
                    me.stopBroadcaster();
                case 'DONE'
                    me.sdf.resetTgtNumber();
                    done = 1;
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',a));
            end
        end
        function connectionError(me)
            me.connectionStatus.setState('ERRORED');
            me.statusErrored();
            me.gui.colorRunButton('BROKEN'); % Pause the simulation
            me.gui.menuCheck('TRIGGER',false);
            me.currentAction.setState('DONE');
            me.log.error(dbstack,...
                sprintf('Trigger Broadcaster has been shut down due to errors'));
        end
    end
    methods (Access=private)
        function startBroadcaster(me)
            me.gui.menuCheck('TRIGGER',true);
            me.connectionStatus.setState('CONNECTED');
            me.currentAction.setState('DONE');
        end
        function stopBroadcaster(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.gui.menuCheck('TRIGGER',false);
            me.currentAction.setState('DONE');
        end
    end
end