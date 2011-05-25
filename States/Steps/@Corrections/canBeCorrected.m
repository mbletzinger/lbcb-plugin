function canBeCorrected = canBeCorrected(me,step)
scfg = StepTimingConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
corStep = step.stepNum.correctionStep;
cess =  scfg.correctEverySubstep;
if corStep > 0
    canBeCorrected = true;
    return;
end
if  substep == 0
    canBeCorrected = true;
    return;
end

if  cess == 0
    canBeCorrected = false;
    return;
end

if rem(substep,cess) == 0
    canBeCorrected = true;
    return;
end
canBeCorrected = false;
end