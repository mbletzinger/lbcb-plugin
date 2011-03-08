function shouldBeCorrected = shouldBeCorrected(me)
step = me.dat.curStepData;
scfg = StepTimingConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
corStep = step.stepNum.correctionStep;
cess =  scfg.correctEverySubstep;
if corStep > 0
    shouldBeCorrected = true;
    return;
end
if  substep == 0
    shouldBeCorrected = true;
    return;
end

if  cess == 0
    shouldBeCorrected = false;
    return;
end

if rem(substep,cess) == 0
    shouldBeCorrected = true;
    return;
end
shouldBeCorrected = false;
end