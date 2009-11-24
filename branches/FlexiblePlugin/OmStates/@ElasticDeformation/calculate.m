function calculate(me, curLbcbCP,prevLbcbCP)
me.loadConfig();
scfg = StepConfigDao(me.cdp.cfg);
edCalc = str2func(scfg.edCalculationFunction);
edCalc(me,curLbcbCP,prevLbcbCP);
end
