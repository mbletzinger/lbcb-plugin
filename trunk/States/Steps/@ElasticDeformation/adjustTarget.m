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
correction = correctionTarget - curResponse;
curCommandOut = prevCommand + correction;
me.archiveCorrections('ed',correction);
end