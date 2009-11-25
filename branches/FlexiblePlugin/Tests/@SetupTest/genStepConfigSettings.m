function genStepConfigSettings(me,requireCorrection)
scfg = StepConfigDao(me.cfg);
scfg.doEdCalculations = requireCorrection;
scfg.doEdCorrection = requireCorrection;
scfg.doDdofCalculations = requireCorrection;
scfg.doDdofCorrection = requireCorrection;
scfg.doStepSplitting = 0;
scfg.correctEverySubstep = 0;
scfg.substepIncL1 = Target;
scfg.substepIncL2 = Target;
scfg.edCalculationFunction = 'noEdCalculate';
scfg.ddCalculationFunction = 'noDdCalculate'; 
scfg.ddCorrectionFunction = 'noDdAdjustTarget'; 
end