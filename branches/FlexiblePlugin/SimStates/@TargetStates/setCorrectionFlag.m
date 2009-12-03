function setCorrectionFlag(me,step)
scfg = StepConfigDao(me.cdp.cfg);
correctStep = scfg.doEdCorrection | scfg.doDdofCorrection;
substep = step.stepNum.subStep;
cess =  scfg.correctEverySubstep;
if correctStep == false
    step.needsCorrection = false;
    return;
end

if  substep == 0
    step.needsCorrection = true;
    return;
end

if  cess == 0
    step.needsCorrection = false;
    return;
end

if rem(substep,cess) == 0
    step.needsCorrection = true;
    return;
end
step.needsCorrection = false;

end