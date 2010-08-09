function genStepConfigSettings(me,requireCorrection,doStepSplitting)
stcfg = StepTimingConfigDao(me.cfg);
stcfg.doStepSplitting = doStepSplitting;
stcfg.correctEverySubstep = doStepSplitting * 3;
inc = Target;
if doStepSplitting
    for d = 1 : 6
        m = me.getMultiplier(d);
        inc.setDispDof(d,m * 0.2);
    end
end
stcfg.substepIncL1 = inc;
stcfg.substepIncL2 = inc;
sccfg = StepCorrectionConfigDao(me.cfg);
sccfg.doCalculations = [requireCorrection, requireCorrection,0,0,0,0];
sccfg.doCorrections = [0,0,0,0,0,0];
sccfg.calculationFunctions = {'noEdCalculate','noDdCalculate','<NONE>','<NONE>','<NONE>','<NONE>'};
sccfg.needsCorrectionFunctions = {'<NONE>','<NONE>','<NONE>','<NONE>','<NONE>','<NONE>'};
sccfg.adjustTargetFunctions = {'<NONE>','<NONE>','<NONE>','<NONE>','<NONE>','<NONE>'};
sccfg.prelimAdjustTargetFunctions = {'<NONE>','<NONE>'};
end