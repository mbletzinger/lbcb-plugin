function done = isDone(me)
done = 1;
me.statusReady();
if me.steps.started == false
    me.dat.substepTgtShift(me.steps.next());
    me.prelimAdjust();
    me.gui.updateCorrections(true,false,false);
    return;
end
if me.needsCorrection(me.shouldBeCorrected)
    ddl = me.ddlevel - 1; % DD level 1 is done with ED
    if ddl < 0
        ddl = 0;
    end
    me.dat.nextCorrectionStep(2 + ddl);
    me.adjustTarget(me.dat.nextStepData,me.dat.correctionTarget);
    me.log.info(dbstack,'Generating correction step');
    me.gui.updateCorrections(false,me.edCorrect,ddl);
else
    % get next input step
    stp = me.steps.next();
    me.stepsCompleted = me.steps.endOfFile;
    me.gui.updateCorrections(true,false,false);
    if me.stepsCompleted
        return;
    else
        me.dat.substepTgtShift(stp);
        me.prelimAdjust();
    end
end
me.log.debug(dbstack,sprintf('Correction Target L1 is %s',me.dat.correctionTarget.lbcbCps{1}.command.toString()));
if me.cdp.numLbcbs() > 1
    me.log.debug(dbstack,sprintf('Correction Target L2 is %s',me.dat.correctionTarget.lbcbCps{2}.command.toString()));
end
me.log.debug(dbstack,sprintf('Next Step L1 is %s',me.dat.nextStepData.lbcbCps{1}.command.toString()));
if me.cdp.numLbcbs() > 1
    me.log.debug(dbstack,sprintf('Next Step L2 is %s',me.dat.nextStepData.lbcbCps{2}.command.toString()));
end
end
