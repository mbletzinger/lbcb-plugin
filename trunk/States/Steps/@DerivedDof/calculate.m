% generate a new LbcbStep based on the current step
function calculate(me,cstep)
me.loadCfg();
scfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = scfg.calculationFunctions;
if isempty(funcs)
    return;
end
fname = funcs{2 + me.level};
if strcmp(fname,'Test')
    me.calculateTest(cstep);
    return;
end
ddCalc = str2func(fname);
ddCalc(me,cstep);
end
