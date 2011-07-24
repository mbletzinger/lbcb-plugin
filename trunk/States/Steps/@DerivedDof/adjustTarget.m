% generate a new LbcbStep based on the current step
function adjustTarget(me,step)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.adjustTargetFunctions;
if isempty(funcs)
    return;
end
fname = funcs{2 + me.level};
if strcmp(fname,'Test')
    me.adjustTargetTest(step);
    return;
end
ddAdjust = str2func(fname);
ddAdjust(me,step);
end
