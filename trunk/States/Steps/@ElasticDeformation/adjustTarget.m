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

%------------------
% obtain the modified command
% description: iteration steps for elastic deformation
%------------------
temp = prevCommand - (curResponse - correctionTarget); 

%------------------
% Check
% description: if the modified command is too large, this step will enforce
% the command equal to the previous step
% (this step can be discussed)
%------------------
norm_tran_cal = norm(temp(1:3)-correctionTarget(1:3));
norm_tran_true = norm(prevCommand(1:3) - correctionTarget(1:3));
%==
norm_rot_cal = norm(temp(4:6)-correctionTarget(4:6));
norm_rot_true = norm(prevCommand(4:6) - correctionTarget(4:6));
%==
limit_ratio = 4;
%==
if (norm_tran_cal<=limit_ratio*norm_tran_true) && (norm_rot_cal<=limit_ratio*norm_rot_true)
    curCommandOut = temp;
else
    curCommandOut = prevCommand; % this one can be modified
end

%------------------
% end
%------------------
end