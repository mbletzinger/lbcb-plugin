function needsCorrection = needsCorrection(me)
needsCorrection = false;
if isempty(me.dat.curStepData)
    return;
end
if me.dat.curStepData.needsCorrection == false
    return;
end
scfg = StepConfigDao(me.cdp.cfg);
if scfg.doEdCorrection == false;
    return;
end
wt1 = me.st{1}.withinTolerances(me.dat.correctionTarget.lbcbCps{1}.command,...
    me.dat.curStepData.lbcbCps{1}.response);
wt2 = 1;
if me.cdp.numLbcbs() == 2
    wt2 = me.st{2}.withinTolerances(me.dat.correctionTarget.lbcbCps{2}.command,...
        me.dat.curStepData.lbcbCps{2}.response);
end
needsCorrection = (wt1 && wt2) == false;
end
