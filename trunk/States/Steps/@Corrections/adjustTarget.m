function adjustTarget(me, target)
edCorrected = false;
if me.ncorrections(1)
    me.ed{1}.adjustTarget(target.lbcbCps{1});
    if me.cdp.numLbcbs() == 2
        me.ed{2}.adjustTarget(target.lbcbCps{2});
    end
    edCorrected = true;
end

for ddl = 2:length(me.Correction)
    if edCorrected && ddl > 2
        return; % Only the first level can be done at the same time as ED
    end
    if me.ncorrections(ddl)
        me.dd{ddl}.adjustTarget(target);
        return;
    end
end
end
 