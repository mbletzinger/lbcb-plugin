function needsCorrection = wharfPierEdNeedsCorrection(me,lbcbCps, target)
needsCorrection = false;
if isempty(lbcbCps)
    return;
end
st = me.st{1};

needsCorrection = (st.withinTolerances(target.command,lbcbCps.response)) == false;
end
