function execute(obj, event,me)
if me.running == 0  % in a hold state
    return;
end
a = me.currentAction.getState();
me.log.debug(dbstack,sprintf('Executing action %s',a));
switch a
    case  { 'OPEN CONNECTION', 'CLOSE CONNECTION' }
        done = me.oc.isDone();
        if done
            me.currentAction.setState('READY');
            stop(me.simTimer);
        end
    case'NEXT TARGET'
        done = me.nxtTgt.isDone();
        if done % Next target is ready
            if me.nxtTgt.simCompleted  %  No more targets
                me.setRunHoldButton(0); % Pause the simulation
                me.currentAction.setState('READY');
            else % Execute next step
                if me.fakeOm == 0
                    me.peOm.step = me.nxtTgt.nextStep;
                end
                me.currentAction.setState('CHECK LIMITS');
            end
        end
    case 'OM PROPOSE EXECUTE'
        if me.fakeOm == 0
            done = me.peOm.isDone();
            if done % execute response has been received from OM
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
        done = me.nxtTgt.withinLimits();
        if done
                me.currentAction.setState('OM PROPOSE EXECUTE');
        else
            me.setRunHoldButton(0); % Pause the simulation
        end
    case 'READY'
        me.log.error(dbstack,'Someone forgot to stop the simulation timer');
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
end