function execute(obj, event,me)
% if me.running == 0  % in a hold state
%     return;
% end
a = me.currentAction.getState();

% me.log.debug(dbstack,sprintf('Executing action %s',a));

if me.previousAction.isState(a) == 0
    me.log.debug(dbstack,sprintf('Executing action %s',a));
    me.previousAction.setState(a);
end
switch a
    case 'OPEN CONNECTION'
        done = me.ocOm.isDone();
%         oc = me.ocOm
%         state = me.ocOm.getState()
        if done
            if me.ocOm.state.isState('ERRORS EXIST') == 0
                me.log.debug(dbstack,'Open connection is done');
                me.colorConnectionButton(me.ocOm.connectionType.getState());
            end
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.ocOm.connectionType.getState());
            stop(me.simTimer);
        end
    case 'CLOSE CONNECTION'
%        ocOm = me.ocOm
        done = me.ocOm.isDone();
        if done
%            currentAction = me.currentAction
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.ocOm.connectionType.getState());
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
                    me.peOm.step = me.nxtTgt.nextStepData;
                end
                me.updateSteps();
                me.currentAction.setState('CHECK LIMITS');
            end
        end
    case 'OM PROPOSE EXECUTE'
        if me.fakeOm == 0
            done = me.peOm.isDone();
            if done % execute response has been received from OM
                if me.peOm.state.isState('ERRORS EXIST')
                    me.setRunButton(0); % Pause the simulation
                    me.ocOm.connectionStatus.setState('ERRORED');
                    me.colorConnectionButton('OperationsManager');
                    stop(me.simTimer);
                end
                me.gcpOm.step = me.peOm.step;
                me.gcpOm.start();
                me.currentAction.setState('OM GET CONTROL POINTS');
            end
        else
            me.currentAction.setState('OM GET CONTROL POINTS');
        end
    case 'OM GET CONTROL POINTS'
        if me.fakeOm
            me.fakeGcp.generateControlPoints(me.nxtTgt.nextStepData);
            me.nxtTgt.curStepData = me.nxtTgt.nextStepData;
            me.currentAction.setState('NEXT TARGET');
            me.arch.archive(me.nxtTgt.curStepData);
            me.dd.update(me.nxtTgt.curStepData);
        else
            done = me.gcpOm.isDone();
            if done
                if me.peOm.state.isState('ERRORS EXIST')
                    me.setRunButton(0); % Pause the simulation
                    me.ocOm.connectionStatus.setState('ERRORED');
                    me.colorConnectionButton('OperationsManager');
                stop(me.simTimer);
                end
                me.nxtTgt.curStepData = me.gcpOm.step;
                me.currentAction.setState('NEXT TARGET');
                me.arch.archive(me.gcpOm.step);
                me.dd.update(me.gcpOm.step);
            end
        end
    case 'CHECK LIMITS'
        %        me.nxtTgt
        done = me.nxtTgt.withinLimits();
        me.updateCommandLimits();
        me.updateStepTolerances();
        if done
            me.currentAction.setState('OM PROPOSE EXECUTE');
            if me.fakeOm == 0
                me.peOm.step = me.nxtTgt.nextStepData;
                me.peOm.start();
            end
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
% me.log.debug(dbstack,'execute is done');
end