function execute(me)
if running == 0  % in a hold state
    return;
end
a = me.currentAction.getState();
switch a
    case  { 'OPEN CONNECTION', 'CLOSE CONNECTION' }
        done = me.oc.isDone();
        if done
            me.currentAction.setState('READY');
        end
    case'NEXT TARGET'
        done = me.nxtTgt.isDone();
        if done
            if usefakeOm == 0
                me.peOm.step = nxtTgt.nextStep;
            end
            me.currentAction.setState('CHECK LIMITS');
        end
    case 'OM PROPOSE EXECUTE'
        if me.fakeOm == 0
            done = me.peOm.isDone();
            if done
                me.gcpOm.step = me.peOm.step;
                me.gcpOm.start();
                me.currentAction.setState('OM GET CONTROL POINTS');
            end
        else
                me.currentAction.setState('OM GET CONTROL POINTS');
        end
    case 'OM GET CONTROL POINTS'
        if me.fakeOm
            me.nxtTgt.curStep = me.fakeGcp.generateControlPoints(me.nxtTgt.nextStep);
            me.currentAction.setState('NEXT TARGET');
        else
            done = me.gcpOm.isDone();
            if done
                me.nxtTgt.curStep = me.gcpOm.step;
                me.currentAction.setState('NEXT TARGET');
            end
        end
    case 'CHECK LIMITS'
        done = nxtTgt.withinLimits();
        if done
                me.currentAction.setState('OM PROPOSE EXECUTE');
        else
            me.running = 0; % Pause the simulation
        end
    case 'READY'
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
end