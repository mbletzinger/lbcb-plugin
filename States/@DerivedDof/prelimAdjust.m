% generate a new LbcbStep based on the current step
function prelimAdjust(me,cstep)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
prelimAdjust = scfg.prelimAdjustTargetFunction;
if strcmp(prelimAdjust,'<NONE>')
    return;
end
prelimAdjust(me,cstep);
end
