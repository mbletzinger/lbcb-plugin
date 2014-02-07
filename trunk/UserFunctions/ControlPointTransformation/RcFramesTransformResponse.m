function mdlTgts = RcFramesTransformResponse(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

%Coordinate Transformation from LBCB to Model
% Simcor is running as an element of OpenSees and so is hardcoded as a beam element.
% SimCor Dx = LBCB -Dy
% SimCor Dy = LBCB -Dz
% SimCor Dz = LBCB -Dx
numLbcbs = me.cdp.numLbcbs();
if me.existsCfg('FakeResponse')
    fake = me.getCfg('FakeResponse');
else
    fake = 0;
end
stiffnesses = zeros(6,1);
if fake
    stiffnesses(1) = me.getCfg('Stiffness.Dx');
    stiffnesses(2) = me.getCfg('Stiffness.Dy');
    stiffnesses(3) = me.getCfg('Stiffness.Dz');
    stiffnesses(4) = me.getCfg('Stiffness.Rx');
    stiffnesses(5) = me.getCfg('Stiffness.Ry');
    stiffnesses(6) = me.getCfg('Stiffness.Rz');
end

for lbcb = 1:numLbcbs
    disp = zeros(6,1);
    if fake
        disp(1) = me.getDat(sprintf('L%d.LCmd.Dx',lbcb));
        disp(2) = me.getDat(sprintf('L%d.LCmd.Dy',lbcb));
        disp(3) = me.getDat(sprintf('L%d.LCmd.Dz',lbcb));
        disp(4) = me.getDat(sprintf('L%d.LCmd.Rx',lbcb));
        disp(5) = me.getDat(sprintf('L%d.LCmd.Ry',lbcb));
        disp(6) = me.getDat(sprintf('L%d.LCmd.Rz',lbcb));
    else
        disp = lbcbTgts{lbcb}.disp;
    end
    % Set Dx
    mdlTgts{lbcb}.setDispDof(1,-disp(2));
    % Set Dy
    mdlTgts{lbcb}.setDispDof(2,-disp(3));
    % Set Dz
    mdlTgts{lbcb}.setDispDof(3,-disp(1));
    % Set Rx
    mdlTgts{lbcb}.setDispDof(4,-disp(5));
    % Set Ry
    mdlTgts{lbcb}.setDispDof(5,-disp(6));
    % Set Rz
    mdlTgts{lbcb}.setDispDof(6,-disp(4));
    forces = lbcbTgts{lbcb}.force;
    % Set Fx
    mdlTgts{lbcb}.setForceDof(1,-forces(2));
    % Set Fy
    mdlTgts{lbcb}.setForceDof(2,-forces(3));
    % Set Fz
    mdlTgts{lbcb}.setForceDof(3,-forces(1));
    % Set Mx
    mdlTgts{lbcb}.setForceDof(4,-forces(5));
    % Set My
    mdlTgts{lbcb}.setForceDof(5,-forces(6));
    % Set Mz
    mdlTgts{lbcb}.setForceDof(6,-forces(4));
end


if me.existsCfg('Displacement.Scale')
    % scale factor=[disp,rot,force,moment]
    scale_factor = zeros(4,1);
    scale_factor(1) = me.getCfg('Displacement.Scale');
    scale_factor(2) = me.getCfg('Rotation.Scale');
    scale_factor(3) = me.getCfg('Force.Scale');
    scale_factor(4) = me.getCfg('Moment.Scale');
    for lbcb = 1:numLbcbs
	  	[mdlTgts{lbcb}.disp] = scaleValues(scale_factor(1:2),mdlTgts{lbcb}.disp,true);
	  	[mdlTgts{lbcb}.force] = scaleValues(scale_factor(3:4),mdlTgts{lbcb}.force,false);
    end
end
if fake
    for lbcb = 1:numLbcbs
        cmd = zeros(6,1);
        cmd(1) = me.getDat(sprintf('L%d.Cmd.Dx',lbcb));
        cmd(2) = me.getDat(sprintf('L%d.Cmd.Dy',lbcb));
        cmd(3) = me.getDat(sprintf('L%d.Cmd.Dz',lbcb));
        cmd(4) = me.getDat(sprintf('L%d.Cmd.Rx',lbcb));
        cmd(5) = me.getDat(sprintf('L%d.Cmd.Ry',lbcb));
        cmd(6) = me.getDat(sprintf('L%d.Cmd.Rz',lbcb));
        forces = cmd .* stiffnesses;
        mdlTgts{lbcb}.setForceDof(1,forces(1));
        mdlTgts{lbcb}.setForceDof(2,-forces(3));
        mdlTgts{lbcb}.setForceDof(3,forces(2));
        mdlTgts{lbcb}.setForceDof(4,forces(4));
        mdlTgts{lbcb}.setForceDof(5,-forces(6));
        mdlTgts{lbcb}.setForceDof(6,forces(5));
        %    mdlTgts{lbcb}.setDispDof(1:6,cmd);
    end
    
end


end
