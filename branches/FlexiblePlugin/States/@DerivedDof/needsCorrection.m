% generate a new LbcbStep based on the current step
function yes = needsCorrection(me,step)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.needsCorrectionFunctions;
if strcmp(funcs{2 + level},'<NONE>')
    return;
end
ddCorrect = str2func(funcs{2 + level});
yes = ddCorrect(me,step);
end
