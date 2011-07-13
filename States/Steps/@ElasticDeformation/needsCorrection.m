% function yes = needsCorrection(me)
% yes = all(me.within) == false;
% end

function yes = needsCorrection(me,curResponse, correctionTarget)

%------------------
% norm values between the current response and the target
% description: tranlsations and rotations are separated
%------------------
ind_tran = [];
ind_rot = [];
for i = 1:3
    if me.st.used(i)
        ind_tran = [ind_tran,i];
    end
    if me.st.used(i+3)
        ind_rot = [ind_rot,i+3];
    end
end
%==
norm_1 = 0;
norm_2 = 0;
if ~isempty(ind_tran)
    norm_1 = norm(correctionTarget(ind_tran) - curResponse(ind_tran));
end
if ~isempty(ind_rot)
    norm_2 = norm(correctionTarget(ind_rot) - curResponse(ind_rot));
end
%==
% norm_1 = norm(curResponse(1:3)-correctionTarget(1:3));
% norm_2 = norm(curResponse(4:6)-correctionTarget(4:6));

%------------------
% two criteria 
% description: the current response (command) should satisfy both criteria
%------------------
if (norm_1<=me.within(1)) && (norm_2<=me.within(2))
    yes = 0;
else
    yes = 1;
end

end