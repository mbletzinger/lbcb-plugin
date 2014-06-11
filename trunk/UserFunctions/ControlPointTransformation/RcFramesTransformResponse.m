function mdlTgts = RcFramesTransformResponse(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

%Coordinate Transformation from LBCB to Model
% Simcor is running as an element of OpenSees and so is hardcoded as a beam element.
% SimCor Dx = LBCB -Dz
% SimCor Dy = LBCB -Dy
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
scaling = false;
scale_factor = zeros(8,1);

if me.existsCfg('DisplacementX.Scale')
    % scale factor=[dispx, dispy, dispz, rot, forcex, forcey, forcez, moment]
    scale_factor(1) = me.getCfg('DisplacementX.Scale');
    scale_factor(2) = me.getCfg('DisplacementY.Scale');
    scale_factor(3) = me.getCfg('DisplacementZ.Scale');
    scale_factor(4) = me.getCfg('Rotation.Scale');
    scale_factor(5) = me.getCfg('ForceX.Scale');
    scale_factor(6) = me.getCfg('ForceY.Scale');
    scale_factor(7) = me.getCfg('ForceZ.Scale');
    scale_factor(8) = me.getCfg('Moment.Scale');
    scaling = true;
end

for lbcb = 1:numLbcbs

    if scaling
	  	disp = scaleValues(scale_factor(1:4),lbcbTgts{lbcb}.disp,false);
	  	forces= scaleValues(scale_factor(5:8),lbcbTgts{lbcb}.force,false);
    else
 	  	disp = lbcbTgts{lbcb}.disp;
	  	forces= lbcbTgts{lbcb}.force;       
    end

    % Set Dx
    mdlTgts{lbcb}.setDispDof(1,-disp(3));
    % Set Dy
    mdlTgts{lbcb}.setDispDof(2,disp(2));
    % Set Dz
    mdlTgts{lbcb}.setDispDof(3,disp(1));
    % Set Rx
    mdlTgts{lbcb}.setDispDof(4,-disp(6));
    % Set Ry
    mdlTgts{lbcb}.setDispDof(5,disp(5));
    % Set Rz
    mdlTgts{lbcb}.setDispDof(6,disp(4));
    % Set Fx
    mdlTgts{lbcb}.setForceDof(1,-forces(3));
    % Set Fy
    mdlTgts{lbcb}.setForceDof(2,forces(2));
    % Set Fz
    mdlTgts{lbcb}.setForceDof(3,forces(1));
    % Set Mx
    mdlTgts{lbcb}.setForceDof(4,-forces(6));
    % Set My
    mdlTgts{lbcb}.setForceDof(5,forces(5));
    % Set Mz
    mdlTgts{lbcb}.setForceDof(6,forces(4));
     me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{lbcb}.toString(),lbcbTgts{lbcb}.toString()));
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
        mdlTgts{lbcb}.setForceDof(2,forces(2));
        mdlTgts{lbcb}.setForceDof(3,forces(3));
        mdlTgts{lbcb}.setForceDof(4,forces(4));
        mdlTgts{lbcb}.setForceDof(5,forces(5));
        mdlTgts{lbcb}.setForceDof(6,forces(6));
        %    mdlTgts{lbcb}.setDispDof(1:6,cmd);
    end
    
end


end
