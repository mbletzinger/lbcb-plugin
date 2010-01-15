function lbcbTgts = FrameworkTransformCommand(me,mdlTgts)  
lbcbTgts = { Target Target }; % create one Target for each LBCB

%Coordinate Transformation from Model to LBCB
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Sheng-Lin 01-15-2010

% Portable LBCB (LBCB 2)

% Set Dx on LBCB 2
lbcbTgts{2}.setDispDof(1,mdlTgts{1}.disp(1));
% Set Dy on LBCB 2
%lbcbTgts{2}.setDispDof(2,mdlTgts{1}.disp(3));
% Set Dz on LBCB 2
lbcbTgts{2}.setDispDof(3,-mdlTgts{1}.disp(2));
% Set Rx on LBCB 2
%lbcbTgts{2}.setDispDof(4,mdlTgts{1}.disp(4));
% Set Ry on LBCB 2
lbcbTgts{2}.setDispDof(5,mdlTgts{1}.disp(6));
% Set Rz on LBCB 2
%lbcbTgts{2}.setDispDof(6,-mdlTgts{1}.disp(5));


end