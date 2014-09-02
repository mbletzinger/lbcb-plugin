function updateCorrections(me)
isCorrection = me.hfact.corrections.needsCorrection();
if isCorrection == false
    me.bcor.setState(true,0,0);
    return;
end

corrections = me.hfact.corrections.ncorrections;
nc = (sum(corrections)  > 0) == false;
ed = corrections(1);
ddl = 0;
dd = false;
for c = 2:length(corrections)
    if corrections(c)
        ddl = c - 2;
        dd = true;
        break;
    end
end
me.bcor.setState(nc,ed,dd,ddl);
end