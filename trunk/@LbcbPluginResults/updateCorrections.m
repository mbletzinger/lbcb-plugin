function updateCorrections(me, isCorrection)
if isCorrection == false
    me.bcor.setState(true,0,0);
    return;
end

corrections = me.hfact.corrections.ncorrections;
nc = sum(corrections) > 0;
ed = corrections(1);
dd = 0;
for c = 2:length(corrections)
    if corrections(c)
        dd = c - 2;
        break;
    end
end
me.bcor.setState(nc,ed,dd);
end