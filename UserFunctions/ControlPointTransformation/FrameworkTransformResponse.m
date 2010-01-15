function mdlTgts = FrameworkTransformResponse(me,lbcbTgts)
mdlTgts = { Target Target }; % create a couple of model control points

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Sheng-Lin 01-15-2010

% Portable LBCB (LBCB2)

% Set Dx from LBCB 2
mdlTgts{1}.setDispDof(1,lbcbTgts{2}.disp(1));
% Set Dy from LBCB 2
mdlTgts{1}.setDispDof(2,-lbcbTgts{2}.disp(3));
% Set Dz from LBCB 2
%mdlTgts{1}.setDispDof(3,lbcbTgts{2}.disp(2));
% Set Rx from LBCB 2
%mdlTgts{1}.setDispDof(4,lbcbTgts{2}.disp(4));
% Set Ry from LBCB 2
%mdlTgts{1}.setDispDof(5,-lbcbTgts{2}.disp(6));
% Set Rz from LBCB 2
mdlTgts{1}.setDispDof(6,lbcbTgts{2}.disp(5));


end