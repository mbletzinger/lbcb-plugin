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
            if me.isFake() == false
                me.peOm.start()
            end
        end
    case 'OM PROPOSE EXECUTE'
        if me.isFake()
            me.dat.stepShift();
            me.currentAction.setState('OM GET CONTROL POINTS');
        else
            odone = me.peOm.isDone();
            if odone % execute response has been received from OM
                if me.peOm.hasErrors()
                    me.ocOm.connectionError();
                    me.statusErrored();
                    done = 1;
                    return;
                end
                me.dat.stepShift();
                me.gcpOm.start();
                me.currentAction.setState('OM GET CONTROL POINTS');
            end
        end
    case 'OM GET CONTROL POINTS'
        
        if me.isFake()
            me.fakeGcp.generateControlPoints();
            me.pResp.start();
            me.currentAction.setState('PROCESS OM RESPONSE');
        else
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
        end
        
    case 'PROCESS OM RESPONSE'
        me.pResp.isDone();
        me.arch.archive(me.dat.curStepData);
        me.gui.ddisp.updateAll(me.dat.curStepData);
        if me.gettingInitialPosition
            me.dat.initialPosition2Target();
            me.currentAction.setState('DONE');
        elseif me.needsTriggering()
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
        me.gui.updateStepState(me.currentAction.idx)
        me.gui.updateStepTolerances(me.st);
        done = 1;
        me.gui.updateTimer(); %BG
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
end
end
