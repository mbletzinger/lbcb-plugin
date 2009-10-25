function genStepConfigSettings(me)
scfg = StepConfigDao(me.cfg);
scfg.doEdCalculations = 0;
scfg.doEdCorrection = 0;
scfg.doDdofCalculations = 0;
scfg.doDdofCorrection = 0;
scfg.doStepSplitting = 0;
scfg.correctEverySubstep = 0;
scfg.substepIncL1 = 0;
scfg.substepIncL2 = 0;
end