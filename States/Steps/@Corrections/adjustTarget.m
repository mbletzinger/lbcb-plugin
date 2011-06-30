function adjustTarget(me, ctarget, curStep,nextStep)
edCorrected = false;
for lbcb = 1:me.cdb.numLbcbs()
    if me.ncorrections(lbcb)
        me.ed{lbcb}.adjustTarget(ctarget.lbcbCps{1}.command,...
            curStep.lbcbCps{lbcb}.response.disp,...
            nextStep.lbcbCps{lbcb}.command);
        edCorrected = true;
    end
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
