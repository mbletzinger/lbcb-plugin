function mdlTgts = RcFramesTransformResponse(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

% This file was created on 8/9/2014, edited to add noise to the response if
% the analysis is being faked, and to add in I-modification to the
% experimental measurements (JAM)

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

% Allow turning on/off of iMod
if me.existsCfg('iMod')
    iMod = me.getCfg('iMod');
else
    iMod = 0;
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
        %         Measured Disps and Forces in Lab/LBCB coordinate space (JAM)
        disp = lbcbTgts{lbcb}.disp;
        forces= lbcbTgts{lbcb}.force;
    end
    
    %     Load original command displacements (JAM)
    Cdisp = zeros(6,1);
    Cdisp(1) = me.getDat(sprintf('L%d.Cmd.Dx',lbcb));
    Cdisp(2) = me.getDat(sprintf('L%d.Cmd.Dy',lbcb));
    Cdisp(3) = me.getDat(sprintf('L%d.Cmd.Dz',lbcb));
    Cdisp(4) = me.getDat(sprintf('L%d.Cmd.Rx',lbcb));
    Cdisp(5) = me.getDat(sprintf('L%d.Cmd.Ry',lbcb));
    Cdisp(6) = me.getDat(sprintf('L%d.Cmd.Rz',lbcb));
    
    %     Load stiffness matrix for each LBCB (JAM)
    switch lbcb
        case 1
            K=[6.79018920e+003  0.00000000e+000  0.00000000e+000  0.00000000e+000  0.00000000e+000  0.00000000e+000;
                0.00000000e+000  8.18968487e+001  0.00000000e+000  0.00000000e+000  0.00000000e+000 -3.64983736e+003;
                0.00000000e+000  0.00000000e+000  1.00604511e+002  0.00000000e+000  8.14120520e+003  0.00000000e+000;
                0.00000000e+000  0.00000000e+000  0.00000000e+000  2.15629827e+005  0.00000000e+000  0.00000000e+000;
                0.00000000e+000  0.00000000e+000  8.14120520e+003  0.00000000e+000  9.65404375e+005  0.00000000e+000;
                0.00000000e+000 -3.64983736e+003  0.00000000e+000  0.00000000e+000  0.00000000e+000  4.02428336e+005];
        case 2
            K=[5.85781620e+003  0.00000000e+000  0.00000000e+000  0.00000000e+000  0.00000000e+000  0.00000000e+000;
                0.00000000e+000  7.38291567e+001  0.00000000e+000  0.00000000e+000  0.00000000e+000 -3.68126916e+003;
                0.00000000e+000  0.00000000e+000  1.47478145e+002  0.00000000e+000  1.02466273e+004  0.00000000e+000;
                0.00000000e+000  0.00000000e+000  0.00000000e+000  1.58474095e+005  0.00000000e+000  0.00000000e+000;
                0.00000000e+000  0.00000000e+000  1.02466273e+004  0.00000000e+000  1.06243570e+006  0.00000000e+000;
                0.00000000e+000 -3.68126916e+003  0.00000000e+000  0.00000000e+000  0.00000000e+000  5.01345837e+005];
            
    end
    
    %     If response is faked, add noise to command displacements, else
    %     convert the displacements and forces back to SimCor/Element
    %     coordinates (JAM)
    if fake
        Mdisp=Cdisp+(-1+2*rand(6,1)).*[0.002 0.004 0.004 0.00005 0.00005 0.00005]';
        Mforces=K*Mdisp;
    else
        Mdisp=[-disp(3) disp(2) disp(1) -disp(6) disp(5) disp(4)]';
        Mforces=[-forces(3) forces(2) forces(1) -forces(6) forces(5) forces(4)]';
    end
    
    %     If iMod is on, correct the forces, else print a message in debug
    %     (JAM)
    if iMod == 1
        Mforces=Mforces-K*(Mdisp-Cdisp);
        me.log.debug(dbstack, 'iMod is ON');
    else
        me.log.debug(dbstack, 'iMod is OFF');
    end
    
    %     No conversion necessary for disp and forces as they have already been
    %     converted to SimCor space (JAM)
    % Set Dx
    mdlTgts{lbcb}.setDispDof(1,Mdisp(1));
    % Set Dy
    mdlTgts{lbcb}.setDispDof(2,Mdisp(2));
    % Set Dz
    mdlTgts{lbcb}.setDispDof(3,Mdisp(3));
    % Set Rx
    mdlTgts{lbcb}.setDispDof(4,Mdisp(4));
    % Set Ry
    mdlTgts{lbcb}.setDispDof(5,Mdisp(5));
    % Set Rz
    mdlTgts{lbcb}.setDispDof(6,Mdisp(6));
    
    % Set Fx
    mdlTgts{lbcb}.setForceDof(1,Mforces(1));
    % Set Fy
    mdlTgts{lbcb}.setForceDof(2,Mforces(2));
    % Set Fz
    mdlTgts{lbcb}.setForceDof(3,Mforces(3));
    % Set Mx
    mdlTgts{lbcb}.setForceDof(4,Mforces(4));
    % Set My
    mdlTgts{lbcb}.setForceDof(5,Mforces(5));
    % Set Mz
    mdlTgts{lbcb}.setForceDof(6,Mforces(6));
    me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{lbcb}.toString(),lbcbTgts{lbcb}.toString()));
end


% if fake
%     for lbcb = 1:numLbcbs
%         cmd = zeros(6,1);
%         cmd(1) = me.getDat(sprintf('L%d.Cmd.Dx',lbcb));
%         cmd(2) = me.getDat(sprintf('L%d.Cmd.Dy',lbcb));
%         cmd(3) = me.getDat(sprintf('L%d.Cmd.Dz',lbcb));
%         cmd(4) = me.getDat(sprintf('L%d.Cmd.Rx',lbcb));
%         cmd(5) = me.getDat(sprintf('L%d.Cmd.Ry',lbcb));
%         cmd(6) = me.getDat(sprintf('L%d.Cmd.Rz',lbcb));
%         forces = cmd .* stiffnesses;
%         mdlTgts{lbcb}.setForceDof(1,forces(1));
%         mdlTgts{lbcb}.setForceDof(2,forces(2));
%         mdlTgts{lbcb}.setForceDof(3,forces(3));
%         mdlTgts{lbcb}.setForceDof(4,forces(4));
%         mdlTgts{lbcb}.setForceDof(5,forces(5));
%         mdlTgts{lbcb}.setForceDof(6,forces(6));
%         %    mdlTgts{lbcb}.setDispDof(1:6,cmd);
%     end
%
% end


end
