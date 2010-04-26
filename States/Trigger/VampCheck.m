classdef VampCheck < BroadcasterState
    properties
        vampActions = StateEnum({...
            'CHECKING',...
            'STOPPING',...
            });
        closeIt = 0;
        log = Logger('VampCheck');
        prevAction
          vampStatus = StateEnum({'VAMPING','STOPPED'});
  end
    methods
        function me = VampCheck()
            me.vampActions.setState('STOPPING');
            me.vampStatus.setState('STOPPED');
        end
        function aborted = start(me, closeIt)
            me.closeIt = closeIt;
                aborted = false;
            if closeIt && me.vampStatus.isState('STOPPED')
                me.log.error(dbstack,'Vamp Check already stopped');
                aborted = true;
                return;
            end
            if closeIt == 0 && me.vampStatus.isState('VAMPING')
                me.log.error(dbstack,'Vamp Check already started');
                aborted = true;
                return;
            end
            if me.closeIt
                if me.vampStatus.isState('VAMPING')  % There are no errors
                    me.mdlBroadcast.startStopVamp(1);
                    me.vampActions.setState('STOPPING');
                end
            else
                me.mdlBroadcast.startStopVamp(0);
                me.vampStatus.setState('VAMPING');
                me.gui.colorButton('VAMPING','ON');
            end
        end
        function done = isDone(me)
            done = me.mdlBroadcast.isDone();
            if done
                me.vampStatus.setState('STOPPED');
                me.gui.colorButton('VAMPING','OFF');
            end
        end
    end
end