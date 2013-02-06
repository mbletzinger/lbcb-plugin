function lbcbTgts = JianTransformCommand2(me,mdlTgts)  
lbcbTgts = { Target Target }; % create one Target for each LBCB

%Coordinate Transformation from Model to LBCB
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Jian Li 11-18-2010

% Kz = 1.8316e6; % lb/in  Sheng-Lin's Column
Kz = 1.8316e6; % lb/in  Dummy concrete pier

% Portable LBCB (LBCB 2)

% Set Dx on LBCB 2
lbcbTgts{1}.setDispDof(1,mdlTgts{1}.disp(3) - mdlTgts{2}.disp(3)); % Dx = n8Z - n9Z
% Set Dy on LBCB 2
%lbcbTgts{1}.setDispDof(2,mdlTgts{1}.disp(3));
% Set Dz on LBCB 2
% lbcbTgts{1}.setDispDof(3,-mdlTgts{1}.disp(2));
lbcbTgts{1}.setForceDof(3, -mdlTgts{1}.disp(2)*Kz);
% Set Rx on LBCB 2
%lbcbTgts{2}.setDispDof(4,mdlTgts{1}.disp(4));
% Set Ry on LBCB 2
lbcbTgts{1}.setDispDof(5,-mdlTgts{1}.disp(4));
% Set Rz on LBCB 2
%lbcbTgts{2}.setDispDof(6,-mdlTgts{1}.disp(5));
%me.log.debug(dbstack, sprintf('M1 and L2 %s and %s', mdlTgts{1}.toString(),lbcbTgts{2}.toString()));

size_factor=1;
scale_factor=[size_factor 1 size_factor^2 size_factor^3];

[lbcbTgts{1}.disp,lbcbTgts{2}.disp] = scale_command(scale_factor,lbcbTgts);


end