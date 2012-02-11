function mdlTgts = BoraTransformResponse(me,lbcbTgts)
mdlTgts = { Target Target }; % create a couple of model control points

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Sheng-Lin 03-05-2010

% Portable LBCB (LBCB2)

% Set Dx from LBCB 2
mdlTgts{1}.setDispDof(1,lbcbTgts{1}.disp(1));
% Set Dy from LBCB 2
mdlTgts{1}.setDispDof(2,-lbcbTgts{1}.disp(3));
% Set Dz from LBCB 2
mdlTgts{1}.setDispDof(3,lbcbTgts{1}.disp(2));
% Set Rx from LBCB 2
mdlTgts{1}.setDispDof(4,lbcbTgts{1}.disp(4));
% Set Ry from LBCB 2
mdlTgts{1}.setDispDof(5,-lbcbTgts{1}.disp(6));
% Set Rz from LBCB 2
mdlTgts{1}.setDispDof(6,lbcbTgts{1}.disp(5));

% Set Fx from LBCB 2
mdlTgts{1}.setForceDof(1,lbcbTgts{1}.force(1));
% Set Fy from LBCB 2
mdlTgts{1}.setForceDof(2,-lbcbTgts{1}.force(3));
% Set Fz from LBCB 2
mdlTgts{1}.setForceDof(3,lbcbTgts{1}.force(2));
% Set Mx from LBCB 2
mdlTgts{1}.setForceDof(4,lbcbTgts{1}.force(4));
% Set My from LBCB 2
mdlTgts{1}.setForceDof(5,-lbcbTgts{1}.force(6));
% Set Mz from LBCB 2
mdlTgts{1}.setForceDof(6,lbcbTgts{1}.force(5));


size_factor=1;
%scale factor=[disp,rot,force,moment]
scale_factor=[size_factor 1 size_factor^2 size_factor^3];

[mdlTgts{1}.disp,mdlTgts{2}.disp,mdlTgts{1}.force,mdlTgts{2}.force] = scale_command_response(scale_factor,mdlTgts);


end