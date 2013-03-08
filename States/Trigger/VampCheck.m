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
                stp = me.dat.curStepData;
                if isempty(stp)                    
                    if me.cdp.numLbcbs() == 2
                        tgts = { Target Target };
                    else
                        tgts = { Target };
                    end
                    stp = me.sdf.target2StepData(tgts,9999,0);
                    stp.lbcbCps{1}.response.lbcb.disp = (1.0:6.0);
                    stp.lbcbCps{1}.response.ed.disp = (1.0:6.0);
                    if me.cdp.numLbcbs() == 2
                    stp.lbcbCps{1}.response.ed.disp = (1.0:6.0);
                    stp.lbcbCps{1}.response.ed.disp = (1.0:6.0);
                    end
                end
                if isempty(stp.stepNum)
                    stp.stepNum= StepNumber(9999,0,0);
                end
                
                me.mdlBroadcast.startStopVamp(0,stp);
                me.vampStatus.setState('VAMPING');
                me.gui.menuCheck('VAMP',true);
            end
        end
        function done = isDone(me)
            done = me.mdlBroadcast.isDone();
            if done
                me.vampStatus.setState('STOPPED');
                me.gui.menuCheck('VAMP',false);
            end
        end
    end
end