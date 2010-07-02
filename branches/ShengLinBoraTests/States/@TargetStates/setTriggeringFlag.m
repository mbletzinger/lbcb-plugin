function setTriggeringFlag(me,step)
scfg = StepConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
cess =  scfg.triggerEverySubstep;

if  substep == 0
    step.needsTriggering = true;
    return;
end

if  cess == 0
    step.needsTriggering = false;
    return;
end

if rem(substep,cess) == 0
    step.needsTriggering = true;
    return;
end
step.needsTriggering = false;

end