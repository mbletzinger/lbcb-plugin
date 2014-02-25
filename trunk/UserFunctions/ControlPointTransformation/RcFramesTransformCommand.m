function lbcbTgts = RcFramesTransformCommand(me,mdlTgts)
numLbcbs = me.cdp.numLbcbs();
lbcbTgts = { Target };
if numLbcbs > 1
    lbcbTgts = { lbcbTgts{1}, Target};
end

%Coordinate Transformation from LBCB to Model
% Simcor is running as an element of OpenSees and so is hardcoded as a beam element.
% LBCB Dx = SimCor -Dz
% LBCB Dy = SimCor -Dy
% LBCB Dz = SimCor -Dx

for lbcb = 1:numLbcbs
    me.putDat(sprintf('L%d.Cmd.Dx',lbcb), mdlTgts{lbcb}.disp(1));
    me.putDat(sprintf('L%d.Cmd.Dy',lbcb), mdlTgts{lbcb}.disp(2));
    me.putDat(sprintf('L%d.Cmd.Dz',lbcb), mdlTgts{lbcb}.disp(3));
    me.putDat(sprintf('L%d.Cmd.Rx',lbcb), mdlTgts{lbcb}.disp(4));
    me.putDat(sprintf('L%d.Cmd.Ry',lbcb), mdlTgts{lbcb}.disp(5));
    me.putDat(sprintf('L%d.Cmd.Rz',lbcb), mdlTgts{lbcb}.disp(6));
    % Set Dx
    lbcbTgts{lbcb}.setDispDof(1,-mdlTgts{lbcb}.disp(3));
    % Set Dy
    lbcbTgts{lbcb}.setDispDof(2,-mdlTgts{lbcb}.disp(2));
    % Set Dz
    lbcbTgts{lbcb}.setDispDof(3,-mdlTgts{lbcb}.disp(1));
    % Set Rx
    lbcbTgts{lbcb}.setDispDof(4,-mdlTgts{lbcb}.disp(6));
    % Set Ry
    lbcbTgts{lbcb}.setDispDof(5,-mdlTgts{lbcb}.disp(5));
    % Set Rz
    lbcbTgts{lbcb}.setDispDof(6,-mdlTgts{lbcb}.disp(4));
end
% scale factor=[disp,rot,force,moment]
scale_factor = zeros(4,1);
scale_factor(1) = me.getCfg('DisplacementX.Scale');
scale_factor(2) = me.getCfg('DisplacementY.Scale');
scale_factor(3) = me.getCfg('DisplacementZ.Scale');
scale_factor(4) = me.getCfg('Rotation.Scale');
for lbcb = 1:numLbcbs
    [lbcbTgts{lbcb}.disp] = scaleValues(scale_factor,lbcbTgts{lbcb}.disp,true);
    
    me.putDat(sprintf('L%d.LCmd.Dx',lbcb), lbcbTgts{lbcb}.disp(1));
    me.putDat(sprintf('L%d.LCmd.Dy',lbcb), lbcbTgts{lbcb}.disp(2));
    me.putDat(sprintf('L%d.LCmd.Dz',lbcb), lbcbTgts{lbcb}.disp(3));
    me.putDat(sprintf('L%d.LCmd.Rx',lbcb), lbcbTgts{lbcb}.disp(4));
    me.putDat(sprintf('L%d.LCmd.Ry',lbcb), lbcbTgts{lbcb}.disp(5));
    me.putDat(sprintf('L%d.LCmd.Rz',lbcb), lbcbTgts{lbcb}.disp(6));
    me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{lbcb}.toString(),lbcbTgts{lbcb}.toString()));
end
end
