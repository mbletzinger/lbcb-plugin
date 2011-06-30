% function yes = needsCorrection(me)
% yes = all(me.within) == false;
% end

function yes = needsCorrection(me,curResponse, correctionTarget)

%------------------
% norm values between the current response and the target
% description: tranlsations and rotations are separated
%------------------
norm_1 = norm(curResponse(1:3)-correctionTarget(1:3));
norm_2 = norm(curResponse(4:6)-correctionTarget(4:6));

%------------------
% two criteria 
% description: the current response (command) should satisfy both criteria
%------------------
if (norm_1<=me.within(1)) && (norm_2<=me.within(2))
    yes = 'false';
else
    yes = 'true';
end

end