% generate a new LbcbStep based on the current step
function calculate(me,cstep)
scfg = StepConfigDao(me.cdp.cfg);
ddCalc = str2func(scfg.ddCalculationFunction);
ddCalc(me,cstep);
end
