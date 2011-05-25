function derivedDofAdjust(me)
scfg = StepConfigDao(me.cdp.cfg);
if scfg.doDdofCorrection
    me.dd.adjustTarget(me.dat.nextStepData);
else
end

end
