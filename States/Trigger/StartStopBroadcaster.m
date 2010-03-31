classdef StartStopBroadcaster < BroadcasterState
    properties
        simCorActions = StateEnum({...
            'STARTING',...
            'STOPPING',...
            'DONE',...
            });
         connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        log = Logger('StartStopBroadcastTrigger');
        prevAction
   end
    methods
        function me = StartStopBroadcaster()
            me.connectionStatus.setState('DISCONNECTED');
        end
        function start(me, closeIt)
            me.closeIt = closeIt;
            if closeIt && me.connectionStatus.isState('DISCONNECTED')
                me.log.error(dbstack,'Trigger Broadcaster already stopped');
                return;
            end
            if closeIt == 0 && me.connectionStatus.isState('CONNECTED')
                me.log.error(dbstack,'Trigger Broadcaster already started');
                return;
            end
            if me.closeIt
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    me.mdlBroadcast.shutdown();
                    me.simCorActions.setState('STOPPING');
                end
            else
                me.mdlBroadcast.startup();
                me.simCorActions.setState('STARTING');
                me.connectionStatus.setState('CONNECTED');
            end
        end
        function done = isDone(me)
            done = 0;
            mlDone = me.mdlBroadcast.isDone();
            if mlDone == 0
                return;
            end

            if me.mdlBroadcast.state.isState('ERRORS EXIST')
                done = 1;
                me.connectionError();
                return;
            end
            a = me.simCorActions.getState();
            if me.simCorActions.idx ~= me.prevAction
                me.log.debug(dbstack,sprintf('Executing action %s',a));
                me.prevAction = me.simCorActions.idx;
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
            me.gui.colorRunButton('BROKEN'); % Pause the simulation
            me.gui.colorButton('TRIGGER','BROKEN');
                        me.simCorActions.setState('DONE');            
            me.log.error(dbstack,...
                sprintf('Trigger Broadcaster has been shut down due to errors')); 
        end
    end
    methods (Access=private)
        function startBroadcaster(me)
            me.gui.colorButton('TRIGGER','ON');
            me.connectionStatus.setState('CONNECTED');
            me.simCorActions.setState('DONE');
        end
        function stopBroadcaster(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.gui.colorButton('TRIGGER','OFF');
            me.simCorActions.setState('DONE');            
        end
    end
end