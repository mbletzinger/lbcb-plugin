% generate a new LbcbStep based on the current step
function calculate(me,cstep)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.calculationFunctions;
if isempty(funcs)
    return;
end
if strcmp(funcs{2 + me.level},'<NONE>')
    return;
end
ddCalc = str2func(funcs{2 + me.level});
ddCalc(me,cstep);
end
