function cbc = canBeCorrected(me,step)
scfg = StepTimingConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
corStep = step.stepNum.correctionStep;
cess =  scfg.correctEverySubstep;
if corStep > 0
    cbc = true;
    return;
end
if step.stepNum.isLastSubstep
    cbc = true;
    return;
end
if  substep == 0 && cess ~= 1
    cbc = false;
    return;
end

if  cess == 0
    cbc = false;
    return;
end

if rem(substep,cess) == 0
    cbc = true;
    return;
end
cbc = false;
end