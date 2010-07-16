function needsCorrection = genEdNeedsCorrection(me,lbcbCps, target)
needsCorrection = false;
if isempty(me.dat.curStepData)
    return;
end
needsCorrection = me.st{1}.withinTolerances(target.command,lbcbCps.response);
end
