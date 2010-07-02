function genStepConfigSettings(me,requireCorrection,doStepSplitting)
scfg = StepConfigDao(me.cfg);
scfg.doEdCalculations = requireCorrection;
scfg.doEdCorrection = requireCorrection;
scfg.doDdofCalculations = requireCorrection;
scfg.doDdofCorrection = requireCorrection;
scfg.doStepSplitting = doStepSplitting;
scfg.correctEverySubstep = doStepSplitting * 3;
inc = Target;
if doStepSplitting
    for d = 1 : 6
        m = me.getMultiplier(d);
        inc.setDispDof(d,m * 0.2);
    end
end
scfg.substepIncL1 = inc;
scfg.substepIncL2 = inc;
scfg.edCalculationFunction = 'noEdCalculate';
scfg.ddCalculationFunction = 'noDdCalculate';
scfg.ddCorrectionFunction = 'noDdAdjustTarget';
end