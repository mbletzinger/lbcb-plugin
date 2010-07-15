function yes = needsCorrection(me,lbcbCps,targetCps)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.needsCorrectionFunctions;
if strcmp(funcs{2 + level},'<NONE>')
    return;
end
ddCorrect = str2func(funcs{2 + level});
yes = ddCorrect(me,lbcbCps,targetCps);
end
