% generate a new LbcbStep based on the current step
function calculate(me,cstep)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
if scfg.doCalculations{2+ level} == false
    return;
end
funcs = scfg.ddCalculationFunctions;
if strcmp(funcs{2 + level},'<NONE>')
    return;
end
ddCalc = str2func(funcs{2 + level});
ddCalc(me,cstep);
end
