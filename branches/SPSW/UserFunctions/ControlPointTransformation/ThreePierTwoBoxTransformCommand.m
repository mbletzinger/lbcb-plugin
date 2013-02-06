function lbcbTgts = ThreePierTwoBoxTransformCommand(me,mdlTgts)  %#ok<INUSL>
lbcbTgts = { Target Target }; % create one Target for each LBCB

%Coordinate Transformation from Model to LBCB
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out

% LBCB 1

% Set Dx on LBCB 2
lbcbTgts{1}.setDispDof(1,mdlTgts{1}.disp(1));
% Set Dy on LBCB 2
lbcbTgts{1}.setDispDof(2,mdlTgts{1}.disp(3));
% Set Dz on LBCB 2
lbcbTgts{1}.setDispDof(3,-mdlTgts{1}.disp(2));
% Set Rx on LBCB 2
lbcbTgts{1}.setDispDof(4,mdlTgts{1}.disp(4));
% Set Ry on LBCB 2
lbcbTgts{1}.setDispDof(5,mdlTgts{1}.disp(6));
% Set Rz on LBCB 2
lbcbTgts{1}.setDispDof(6,-mdlTgts{1}.disp(5));
% me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{2}.toString(),lbcbTgts{1}.toString()));

% LBCB 2

% Set Dx on LBCB 2
lbcbTgts{2}.setDispDof(1,mdlTgts{2}.disp(1));
% Set Dy on LBCB 2
lbcbTgts{2}.setDispDof(2,mdlTgts{2}.disp(3));
% Set Dz on LBCB 2
lbcbTgts{2}.setDispDof(3,-mdlTgts{2}.disp(2));
% Set Rx on LBCB 2
lbcbTgts{2}.setDispDof(4,mdlTgts{2}.disp(4));
% Set Ry on LBCB 2
lbcbTgts{2}.setDispDof(5,mdlTgts{2}.disp(6));
% Set Rz on LBCB 2
lbcbTgts{2}.setDispDof(6,-mdlTgts{2}.disp(5));
% me.log.debug(dbstack, sprintf('M1 and L2 %s and %s', mdlTgts{1}.toString(),lbcbTgts{2}.toString()));

% size_factor=1/24;
% %scale factor=[disp,rot,force,moment]
% scale_factor=[size_factor 1 1000*size_factor^2 1000*size_factor^3];
% 
% [lbcbTgts{1}.disp,lbcbTgts{2}.disp] = scale_command(scale_factor,lbcbTgts);

end