function prelimAdjust(me)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
func = scfg.prelimAdjustTargetFunctions;
if isempty(func)
    return;
end
pAdjust = str2func(func{2});
pAdjust(me);
end
