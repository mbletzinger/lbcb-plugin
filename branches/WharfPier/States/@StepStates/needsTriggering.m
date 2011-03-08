function needsTriggering = needsTriggering(me)
needsTriggering = false;
if isempty(me.dat.curStepData)
    return;
end
step = me.dat.curStepData;
scfg = StepTimingConfigDao(me.cdp.cfg);
substep = step.stepNum.subStep;
cess =  scfg.triggerEverySubstep;
if  substep == 0
     needsTriggering = true;
    return;
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
