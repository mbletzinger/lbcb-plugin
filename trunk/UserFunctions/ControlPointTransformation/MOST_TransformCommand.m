function lbcbTgts = MOST_TransformCommand(me,mdlTgts)
numLbcbs = me.cdp.numLbcbs();
lbcbTgts = { Target };
if numLbcbs > 1
    lbcbTgts = { lbcbTgts{1}, Target};
end


for lbcb = 1:numLbcbs
    % Set Displacement
    lbcbTgts{lbcb}.setDispDof(1:6,mdlTgts{lbcb}.disp(1:6));
end
% scale factor=[disp,rot,force,moment]
scale_factor = [1 1 1 1]';
for lbcb = 1:numLbcbs
    [lbcbTgts{lbcb}.disp] = scaleValues(scale_factor,lbcbTgts{lbcb}.disp,true);
    me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{lbcb}.toString(),lbcbTgts{lbcb}.toString()));
end
end
