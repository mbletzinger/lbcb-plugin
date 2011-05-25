function needsCorrection = needsCorrection(me,shouldBeCorrected)
needsCorrection = false;
me.ddlevel = 0;
if isempty(me.dat.curStepData)
    return;
end
if shouldBeCorrected == false
    return;
end
scfg = StepCorrectionConfigDao(me.cdp.cfg);
doCorrections = scfg.doCorrections;
if isempty(doCorrections)
    return;
end

stepN = me.dat.curStepData.stepNum;
if isempty(me.checkedStepNumber)
    same = false;
else
    same = stepN.step == me.checkedStepNumber.step && ...
        stepN.subStep == me.checkedStepNumber.subStep && ...
        stepN.correctionStep == me.checkedStepNumber.correctionStep;
end
if same
    needsCorrection = me.needsCorrectionFlag;
    return;
end

me.checkedStepNumber = stepN;

if lv == 2 && me.edCorrect % Only do first level DD with ED
    me.needsCorrectionFlag = needsCorrection;
    return;
end