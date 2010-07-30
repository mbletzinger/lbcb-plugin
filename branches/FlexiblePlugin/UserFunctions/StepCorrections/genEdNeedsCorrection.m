function needsCorrection = genEdNeedsCorrection(me,lbcbCps, target)
needsCorrection = false;
if isempty(lbcbCps)
    return;
end
st = me.st{2};
if me.isLbcb1
    st = me.st{1};
end
needsCorrection = (st.withinTolerances(target.command,lbcbCps.response)) == false;
end
