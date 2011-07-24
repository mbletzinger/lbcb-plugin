function adjustTarget(me, ctarget, curStep,nextStep)
edCorrected = false;
if me.ncorrections(1)
    for lbcb = 1:me.cdp.numLbcbs()
        nextStep.lbcbCps{lbcb}.command.disp =...
            me.ed{lbcb}.adjustTarget(ctarget.lbcbCps{1}.command.disp,...
            curStep.lbcbCps{lbcb}.response.disp,...
            curStep.lbcbCps{lbcb}.command.disp);
        edCorrected = true;
    end
end

for ddl = 2:length(me.ncorrections)
    if edCorrected && ddl > 2
        return; % Only the first level can be done at the same time as ED
    end
    if me.ncorrections(ddl)
        me.dd{ddl - 1}.adjustTarget(nextStep);
        return;
    end
end
end
