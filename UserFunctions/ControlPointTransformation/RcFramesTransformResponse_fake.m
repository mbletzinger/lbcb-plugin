function mdlTgts = RcFramesTransformResponse_fake(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

%------------------
% generate fake responses
%------------------
global cmd_rcframe

doforder=[3 2 1 6 5 4];
sign_dof = [-1 1 1 -1 1 1]; 
%==
T = zeros(6,6);
for i = 1:6
    T(i,doforder(i)) = sign_dof(i);
end
%==

K1 = [  6.7901892e+003  3.0076785e+001  1.3657268e+001  9.2417019e+002  1.7663646e+002 -3.1126418e+002;
 -3.0327802e+002  1.0830396e+002  1.0402147e+000 -1.6149702e+002 -6.0711680e+001 -4.4593468e+003;
 -1.0522491e+002  2.4793712e+000  1.7402690e+002 -4.8920537e+001  9.6196814e+003  3.4168256e+002;
  5.3018900e+002 -2.4545820e+001 -2.6080354e+002  2.4042282e+005  1.6586118e+004 -2.1949565e+003;
  6.9985930e+003 -7.9196248e+002  6.9510833e+003  6.6255154e+004  1.0994615e+006  1.6908869e+004;
  1.3727228e+004 -3.8964953e+003  1.2960760e+002  4.5188972e+003  2.0040168e+004  5.4934119e+005];% stiffness matrix of column-LBCB1
% K1 = T'*K1*T;

K2 = [  5.8578162e+003  2.5781058e+001  1.3733619e+001 -3.6857821e+002 -4.3466794e+002 -2.7146503e+002;
 -1.1383660e+002  1.1053215e+002 -9.0598365e+000  2.6690444e+002  7.3456961e+002 -4.9127745e+003;
 -3.4631672e+001  2.1791289e+000  1.8189957e+002 -8.4892734e+000  8.6612547e+003 -6.0569463e+002;
 -1.5110514e+003  1.9549236e+002  8.0551219e+001  2.3557742e+005  6.8753097e+003 -6.5571267e+003;
 -1.2895482e+004 -4.9789822e+002  6.8201296e+003 -3.6984804e+003  9.8960258e+005 -8.0675186e+004;
  6.8312868e+003 -3.7914316e+003  8.1603979e+002 -2.9820187e+004 -7.9776919e+004  5.3803349e+005];% stiffness matrix of column-LBCB2
% K2 = T'*K2*T;

%==
K = blkdiag(K1,K2);
%==
temp = who('cmd_rcframe','global');
if isempty(temp)
    disp = [0.001*ones(1,3),0.0001*ones(1,3),0.001*ones(1,3),0.0001*ones(1,3)];
    forces = K*disp';
    fprintf(1,'NOT SEND THE TRUE RESPONSES TO SIMCOR\n');
else
    disp = cmd_rcframe;
    forces = K*(disp+((-1+2*rand(1,12)*1.0).*[0.004 0.004 0.002 0.00005 0.00005 0.00005 0.004 0.004 0.002 0.00005 0.00005 0.00005]))';% being modified by adding noise
    fprintf(1,'send cmd: %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f \n',cmd_rcframe);
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

%     if scaling
% 	  	disp = scaleValues(scale_factor(1:4),lbcbTgts{lbcb}.disp,false);
% 	  	forces= scaleValues(scale_factor(5:8),lbcbTgts{lbcb}.force,false);
%     else
        
%  	  	disp = lbcbTgts{lbcb}.disp; % modified
% % 	  	forces= lbcbTgts{lbcb}.force; % modified       
%     end

    % Set Dx
    mdlTgts{lbcb}.setDispDof(1,disp(1+6*(lbcb-1)));
    % Set Dy
    mdlTgts{lbcb}.setDispDof(2,disp(2+6*(lbcb-1)));
    % Set Dz
    mdlTgts{lbcb}.setDispDof(3,disp(3+6*(lbcb-1)));
    % Set Rx
    mdlTgts{lbcb}.setDispDof(4,disp(4+6*(lbcb-1)));
    % Set Ry
    mdlTgts{lbcb}.setDispDof(5,disp(5+6*(lbcb-1)));
    % Set Rz
    mdlTgts{lbcb}.setDispDof(6,disp(6+6*(lbcb-1)));
    % Set Fx
    mdlTgts{lbcb}.setForceDof(1,forces(1+6*(lbcb-1)));
    % Set Fy
    mdlTgts{lbcb}.setForceDof(2,forces(2+6*(lbcb-1)));
    % Set Fz
    mdlTgts{lbcb}.setForceDof(3,forces(3+6*(lbcb-1)));
    % Set Mx
    mdlTgts{lbcb}.setForceDof(4,forces(4+6*(lbcb-1)));
    % Set My
    mdlTgts{lbcb}.setForceDof(5,forces(5+6*(lbcb-1)));
    % Set Mz
    mdlTgts{lbcb}.setForceDof(6,forces(6+6*(lbcb-1)));
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
