% generate a new LbcbStep based on the current step
function adjustTarget(me,step)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.adjustTargetFunctions;
if strcmp(funcs{2 + me.level},'<NONE>')
    return;
end
ddAdjust = str2func(funcs{2 + me.level});
ddAdjust(me,step);
end
