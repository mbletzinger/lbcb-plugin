function mdlTgts = RcFramesTransformResponse(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

%Coordinate Transformation from LBCB to Model
%Model Coordinates
% Model Dx = LBCB Dy
% Model Dy = LBCB Dx
% Model Dz = LBCB -Dz
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
    % Set Dx
    mdlTgts{lbcb}.setDispDof(1,lbcbTgts{lbcb}.disp(2));
    % Set Dy
    mdlTgts{lbcb}.setDispDof(2,lbcbTgts{lbcb}.disp(1));
    % Set Dz
    mdlTgts{lbcb}.setDispDof(3,-lbcbTgts{lbcb}.disp(3));
    % Set Rx
    mdlTgts{lbcb}.setDispDof(4,lbcbTgts{lbcb}.disp(5));
    % Set Ry
    mdlTgts{lbcb}.setDispDof(5,lbcbTgts{lbcb}.disp(4));
    % Set Rz
    mdlTgts{lbcb}.setDispDof(6,-lbcbTgts{lbcb}.disp(6));
    forces = lbcbTgts{lbcb}.force;    
    % Set Dx from LBCB 2
    mdlTgts{lbcb}.setForceDof(1,forces(1));
    % Set Dy from LBCB 2
    mdlTgts{lbcb}.setForceDof(2,-forces(3));
    % Set Dz from LBCB 2
    mdlTgts{lbcb}.setForceDof(3,forces(2));
    % Set Rx from LBCB 2
    mdlTgts{lbcb}.setForceDof(4,forces(4));
    % Set Ry from LBCB 2
    mdlTgts{lbcb}.setForceDof(5,-forces(6));
    % Set Rz from LBCB 2
    mdlTgts{lbcb}.setForceDof(6,forces(5));
end


if me.existsCfg('Displacement.Scale')
    % scale factor=[disp,rot,force,moment]
    scale_factor = zeros(4,1);
    scale_factor(1) = me.getCfg('Displacement.Scale');
    scale_factor(2) = me.getCfg('Rotation.Scale');
    scale_factor(3) = me.getCfg('Force.Scale');
    scale_factor(4) = me.getCfg('Moment.Scale');
	for lbcb = 1:numLbcbs
		[mdlTgts{lbcb}.disp,mdlTgts{lbcb}.force] = scale_response(scale_factor,mdlTgts{lbcb});
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
end


end
