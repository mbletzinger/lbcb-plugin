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
temp = prevCommand + (correctionTarget - curResponse ); 

%------------------
% Check
% description: if the modified command is too large, this step will enforce
% the command equal to the previous step
% (this step can be discussed)
%------------------
ind_t = []; % index for traslations
ind_r = []; % index for rotations
for i = 1:3
    if me.st.used(i)
       ind_t = [ind_t,i];
    end
    if me.st.used(i+3)
        ind_r = [ind_r,i+3];
    end
end
%==
norm_tran_cal = 0;
norm_tran_true = 0;
if ~isempty(ind_t)
    norm_tran_cal = norm(temp(ind_t)-correctionTarget(ind_t));
    norm_tran_true = norm(prevCommand(ind_t) - correctionTarget(ind_t));
end
norm_rot_cal = 0;
norm_rot_true = 0;
if ~isempty(ind_r)
    norm_rot_cal = norm(temp(ind_r)-correctionTarget(ind_r));
    norm_rot_true = norm(prevCommand(ind_r) - correctionTarget(ind_r));
end
%==
limit_ratio = 4;
%==
if (norm_tran_cal<=limit_ratio*norm_tran_true) && (norm_rot_cal<=limit_ratio*norm_rot_true)
    curCommandOut = temp;
else
    curCommandOut = prevCommand; % this one can be modified
end
%==
%{
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
%}

%------------------
% end
%------------------
end