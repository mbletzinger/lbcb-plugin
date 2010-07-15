% generate a new LbcbStep based on the current step
function adjustTarget(me,lbcbCps)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.adjustTargetFunctions;
if strcmp(funcs{1},'<NONE>')
    return;
end
edAdjust = str2func(funcs{1});
edAdjust(me,lbcbCps);
end
