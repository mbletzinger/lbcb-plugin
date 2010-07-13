function done = isDone(me)
done = 1;
me.statusReady();
if me.steps.started == false
    me.dat.nextStepData = me.steps.next();
    me.dat.correctionTarget = me.dat.nextStepData;
    return;
end
if me.needsCorrection()
    me.dat.nextCorrectionStep();
    me.edAdjust();
    me.derivedDofAdjust();
    me.log.info(dbstack,'Generating correction step');
else
    % get next input step
    stp = me.steps.next();
    me.stepsCompleted = me.steps.endOfFile;
    if me.stepsCompleted
        return;
    else
        me.dat.nextStepData = stp;
        me.prelimAdjust();
        me.dat.correctionTarget = stp;
    end
end
me.log.debug(dbstack,sprintf('Next Step is %s',me.dat.nextStepData.toString()));

end
