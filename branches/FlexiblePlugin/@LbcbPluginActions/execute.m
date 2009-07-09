function execute(obj, event,me)
% if me.running == 0  % in a hold state
%     return;
% end
a = me.currentAction.getState();
me.log.debug(dbstack,sprintf('Executing action %s',a));
switch a
    case 'OPEN CONNECTION'
        done = me.oc.isDone();
        if done
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.oc.connectionType.getState());
            stop(me.simTimer);
        end
    case 'CLOSE CONNECTION'
        done = me.oc.isDone();
        if done
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.oc.connectionType.getState());
            stop(me.simTimer);
        end
    case'NEXT TARGET'
        done = me.nxtTgt.isDone();
        if done % Next target is ready
            if me.nxtTgt.simCompleted  %  No more targets
                me.setRunButton(0); % Pause the simulation
                me.log.info(dbstack,'Simulation is Over');
                me.currentAction.setState('READY');
            else % Execute next step
                if me.fakeOm == 0
                    me.peOm.step = me.nxtTgt.nextStep;
                end
                me.updateSteps();
                me.currentAction.setState('CHECK LIMITS');
            end
        end
    case 'OM PROPOSE EXECUTE'
        if me.fakeOm == 0
            done = me.peOm.isDone();
            if done % execute response has been received from OM
                me.colorConnectionButton('OperationsManager');
                me.gcpOm.step = me.peOm.step;
                me.gcpOm.start();
                me.currentAction.setState('OM GET CONTROL POINTS');
            end
        else
                me.currentAction.setState('OM GET CONTROL POINTS');
        end
    case 'OM GET CONTROL POINTS'
        if me.fakeOm
            me.fakeGcp.generateControlPoints(me.nxtTgt.nextStep);
            me.nxtTgt.curStep = me.nxtTgt.nextStep;
            me.currentAction.setState('NEXT TARGET');
        else
            done = me.gcpOm.isDone();
            if done
                me.colorConnectionButton('OperationsManager');
                me.nxtTgt.curStep = me.gcpOm.step;
                me.currentAction.setState('NEXT TARGET');
            end
        end
    case 'CHECK LIMITS'
%        me.nxtTgt
        done = me.nxtTgt.withinLimits();
        me.updateCommandLimits();
        me.updateStepTolerances();
        if done
                me.currentAction.setState('OM PROPOSE EXECUTE')
        else
            me.setRunButton(0); % Pause the simulation
            stop(me.simTimer);
        end
    case 'READY'
        me.log.error(dbstack,'Someone forgot to stop the simulation timer');
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
LbcbPluginActions.updateGui(me);
end