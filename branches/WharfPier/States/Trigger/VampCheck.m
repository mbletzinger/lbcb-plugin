classdef VampCheck < BroadcasterState
    properties
        closeIt = 0;
        log = Logger('VampCheck');
        vampStatus = StateEnum({'VAMPING','STOPPED'});
    end
    methods
        function me = VampCheck()
            me = me@BroadcasterState();
            me.currentAction = StateEnum({...
                'CHECKING',...
                'STOPPING',...
                });
            me.currentAction.setState('STOPPING');
            me.vampStatus.setState('STOPPED');
        end
        function aborted = start(me, closeIt)
            me.closeIt = closeIt;
            aborted = false;
            if closeIt && me.vampStatus.isState('STOPPED')
                me.log.error(dbstack,'Vamp Check already stopped');
                aborted = true; %#ok<UNRCH>
                return;
            end
            if closeIt == 0 && me.vampStatus.isState('VAMPING')
                me.log.error(dbstack,'Vamp Check already started');
                aborted = true; %#ok<UNRCH>
                return;
            end
            if me.closeIt
                if me.vampStatus.isState('VAMPING')  % There are no errors
                    me.mdlBroadcast.startStopVamp(1,[]);
                    me.currentAction.setState('STOPPING');
                end
            else
                sn = [];
                if isempty(me.dat.curStepData) == false
                    sn = me.dat.curStepData.stepNum;
                end
                me.mdlBroadcast.startStopVamp(0,sn);
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