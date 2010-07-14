function edAdjust(me)
scfg = StepConfigDao(me.cdp.cfg);
if scfg.doEdCorrection
    for l = 1: me.cdp.numLbcbs()
        me.ed{l}.deltaDiff(me.dat.correctionTarget.lbcbCps{l}.command,...
            me.dat.curStepData.lbcbCps{l}.response);
        me.ed{l}.adjustTarget(me.dat.nextStepData.lbcbCps{l});
    end
end
end
