% generate a new LbcbStep based on the current step
function calculate(me,ccps, pcps, tcps)
me.loadCfg();
me.loadConfig();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.calculationFunctions;
if isempty(funcs)
    return;
end
if strcmp(funcs{1},'<NONE>')
    return;
end
edCalc = str2func(funcs{1});
edCalc(me,ccps, pcps, tcps);
end
