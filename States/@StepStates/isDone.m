function done = isDone(me)
done = 0;
a = me.currentAction.getState();
if me.stateChanged()
    me.gui.updateStepState(me.currentAction.idx)
end
switch a
    case'NEXT STEP'
        odone = me.nxtStep.isDone();
        if odone % Next target is ready
            me.isNextStep()
        end
    case'ACCEPT STEP'
        odone = me.acceptStp.isDone();
        me.setStatus(me.acceptStp.status);
        if me.hasErrors()
            me.statusErrored();
            done = 1;
            return;
        end
        if odone % Step is accepted
            me.currentAction.setState('OM PROPOSE EXECUTE');
            me.peOm.start()
        end
    case 'OM PROPOSE EXECUTE'
        odone = me.peOm.isDone();
        if odone % execute response has been received from OM
            if me.peOm.hasErrors()
                if me.peOm.connectionError;
                    me.ocOm.connectionError();
                else
                    me.gui.alerts.setDeclineAlert();
                end
                me.statusErrored();
                done = 1;
                return;
            end
            me.dat.stepShift();
            me.gcpOm.start();
            me.currentAction.setState('OM GET CONTROL POINTS');
        end
    case 'OM GET CONTROL POINTS'
        odone = me.gcpOm.isDone();
        if odone
            if me.gcpOm.hasErrors()
                me.ocOm.connectionError();
                me.statusErrored();
                done = 1;
                return;
            end
            me.pResp.start();
            me.currentAction.setState('PROCESS OM RESPONSE');
        end
        
    case 'PROCESS OM RESPONSE'
        me.pResp.isDone();
        me.arch.archive(me.dat.curStepData);
        me.gui.ddisp.updateAll(me.dat.curStepData);
        me.gui.updateStepState(me.currentAction.idx)
        me.gui.updateStepTolerances(me.st);
        me.gui.updateTimer(); %BG
        me.log.debug(dbstack,sprintf('Current Response: %s', ...
            me.dat.curStepData.toString()));
        me.corrections.calculateCorrections(me.dat.correctionTarget, ...
            me.dat.curStepData);
        if me.gettingInitialPosition
            me.dat.initialPosition2Target();
            me.currentAction.setState('DONE');
        elseif (me.corrections.needsCorrection(me.dat.curStepData) == false)...
                && me.needsTriggering()
            me.brdcstRsp.start();
            me.currentAction.setState('BROADCAST TRIGGER');
        else
            me.nxtStep.start(me.shouldBeCorrected());
            me.currentAction.setState('NEXT STEP');
        end
        
    case 'BROADCAST TRIGGER'
        bdone = me.brdcstRsp.isDone();
        if bdone
            config = CorrectionsSettingsDao(me.cdp.cfg);
            %            pause(config.cfgValues(17));
            me.nxtStep.start(me.shouldBeCorrected());
            me.currentAction.setState('NEXT STEP');
        end
    case 'DONE'
        me.statusReady();
        done = 1;
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
end
end
