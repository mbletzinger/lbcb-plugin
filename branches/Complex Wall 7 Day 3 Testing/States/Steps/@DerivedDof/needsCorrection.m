% generate a new LbcbStep based on the current step
function yes = needsCorrection(me)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
if scfg.doCorrections(2+ me.level) == false
    return;
end
funcs = scfg.needsCorrectionFunctions;
if isempty(funcs)
    return;
end
fname = funcs{2 + me.level};
if strcmp(fname,'Test')
    yes = me.needsCorrectionTest();
    return;
end
ddCorrect = str2func(fname);
yes = ddCorrect(me);
end
