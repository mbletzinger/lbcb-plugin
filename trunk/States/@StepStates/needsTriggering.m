function needsTriggering = needsTriggering(me)
needsTriggering = false;
if isempty(me.dat.curStepData)
    return;
end
step = me.dat.curStepData;
scfg = StepTimingConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
cess =  scfg.triggerEverySubstep;
ces =  scfg.triggerEveryStep;
if  step.isLastSubstep
    if rem(step,ces) == 0
        needsTriggering = true;
        return;
    end
end

if  cess == 0
    needsTriggering = false;
    return;
end

if rem(substep,cess) == 0
    needsTriggering = true;
    return;
end
end
