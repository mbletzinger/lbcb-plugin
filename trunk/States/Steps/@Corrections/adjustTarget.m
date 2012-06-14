function adjustTarget(me, ctarget, curStep,nextStep)
edCorrected = false;
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
funcs = ccfg.adjustTargetFunctions;
if me.ncorrections(1)
    for lbcb = 1:me.cdp.numLbcbs()
    ed = me.ed{lbcb};
    if strcmp(funcs{1},'Dx Only')
        ed = me.dxed{lbcb};
    end
        nextStep.lbcbCps{lbcb}.command.disp =...
            ed.adjustTarget(ctarget.lbcbCps{lbcb}.command.disp,...
            curStep.lbcbCps{lbcb}.response.disp,...
            curStep.lbcbCps{lbcb}.command.disp);
        edCorrected = true;
    end
end

for ddl = 2:length(me.ncorrections)
    if edCorrected && ddl > 2
        me.ed{1}.saveData(nextStep);
        return; % Only the first level can be done at the same time as ED
    end
    if me.ncorrections(ddl)
        me.dd{ddl - 1}.adjustTarget(nextStep);
        me.ed{1}.saveData(nextStep);
        return;
    end
end
me.ed{1}.saveData(nextStep);
end
