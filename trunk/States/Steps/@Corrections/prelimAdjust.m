function prelimAdjust(me,curStep, nextStep)
scfg = StepCorrectionConfigDao(me.cdp.cfg);
func = scfg.prelimAdjustTargetFunctions;
if isempty(func)
    return;
end

if strcmp(func{2},'<NONE>') == false
me.dd{1}.prelimAdjust(curStep,func{2}); % use only one function for all levels
end

if strcmp(func{1},'<NONE>') 
    return;
end


for l = 1:me.cdp.numLbcbs()
    me.ed{l}.prelimAdjust(curStep, nextStep);
end
end
