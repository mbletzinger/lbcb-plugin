
function yes = needsCorrection(me,curResponse, correctionTarget)

%------------------
% norm values between the current response and the target
% description: tranlsations and rotations are separated
%------------------
% norm_1 = norm(curresponse(1:3)-correctiontarget(1:3));
% norm_2 = norm(curresponse(4:6)-correctiontarget(4:6));
yes = (me.st.withinTolerances(correctionTarget,curResponse)) == false;
end