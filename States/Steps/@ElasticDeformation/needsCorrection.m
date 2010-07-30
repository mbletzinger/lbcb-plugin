function yes = needsCorrection(me,lbcbCps,targetCps)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.needsCorrectionFunctions;
if scfg.doCorrections(1) == false
    return;
end
if strcmp(funcs{1},'<NONE>')
    yes = false;
    return;
end
ddCorrect = str2func(funcs{1});
yes = ddCorrect(me,lbcbCps,targetCps);
end
