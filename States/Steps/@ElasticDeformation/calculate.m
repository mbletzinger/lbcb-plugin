% generate a new LbcbStep based on the current step
function calculate(me,cstep)
me.loadCfg();
me.load.Config();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
if scfg.doCalculations{1} == false
    return;
end
funcs = scfg.ddCalculationFunctions;
if strcmp(funcs{2 + level},'<NONE>')
    return;
end
ddCalc = str2func(funcs{2 + level});
ddCalc(me,cstep);
end
