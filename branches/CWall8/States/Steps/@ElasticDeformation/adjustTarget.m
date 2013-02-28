% generate a new LbcbStep based on the current step
% function adjustTarget(me,lbcbCps)
% original code
% me.loadCfg();
% scfg = StepCorrectionConfigDao(me.cdp.cfg);
% funcs = scfg.adjustTargetFunctions;
% if isempty(funcs)
%     return;
% end
% if strcmp(funcs{1},'<NONE>')
%     return;
% end
% edAdjust = str2func(funcs{1});
% edAdjust(me,lbcbCps);

function curCommandOut = adjustTarget(me,correctionTarget,curResponse,prevCommand)
me.loadCfg();

correction = correctionTarget - curResponse;

curCommandOut = prevCommand;
if me.existsCfg('EdCorrectionFactor')
    cf = me.getCfg('EdCorrectionFactor');
else
    cf = 1;
end

if me.existsCfg('ToleranceFilter')
    useSt = me.getCfg('ToleranceFilter');
else
    useSt = false;
end

[cdofs1 cdofs2] = me.cdp.getControlDofs();
cdofs = cdofs2;
if me.isLbcb1
    cdofs = cdofs1;
end

for dof = 1:6
    if useSt
        if (me.st.within(dof) == false)
            curCommandOut(dof) = prevCommand(dof) + correction(dof) * cf;
            me.adjusted(dof) = true;
        end
    else
        if cdofs(dof)
            curCommandOut(dof) = prevCommand(dof) + correction(dof) * cf;
            me.adjusted(dof) = true;
        end
    end
end
%me.archiveCorrections('ed',correction);
end