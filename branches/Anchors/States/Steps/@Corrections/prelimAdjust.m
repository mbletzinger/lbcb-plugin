function prelimAdjust(me,curStep, nextStep)
scfg = StepCorrectionConfigDao(me.cdp.cfg);
func = scfg.prelimAdjustTargetFunctions;
if isempty(func)
    return;
end

if strcmp(func{2},'<NONE>') == false
    me.dd{1}.loadCfg;
    me.dd{1}.prelimAdjust(nextStep,func{2}); % use only one function for all levels
end

if strcmp(func{1},'<NONE>')
    me.ed{1}.saveData(nextStep);
    return;
end

for lbcb = 1:me.cdp.numLbcbs()
    ed = me.ed{lbcb};
    if strcmp(func{1},'Dx Only')
        ed = me.dxed{lbcb};
    end
    ed.prelimAdjust(curStep, nextStep);
end
me.ed{1}.saveData(nextStep);
end

