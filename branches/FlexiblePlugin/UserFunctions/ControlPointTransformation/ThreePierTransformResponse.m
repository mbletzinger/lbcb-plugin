function mdlTgts = ThreePierTransformResponse(me,lbcbTgts)  %#ok<INUSL>
mdlTgts = { Target Target }; % create a couple of model control points

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out

% Control Point 1

% Set Dx from LBCB 2
mdlTgts{1}.setDispDof(1,lbcbTgts{2}.disp(1));
% Set Dy from LBCB 2
mdlTgts{1}.setDispDof(2,-lbcbTgts{2}.disp(3));
% Set Dz from LBCB 2
mdlTgts{1}.setDispDof(3,lbcbTgts{2}.disp(2));
% Set Rx from LBCB 2
mdlTgts{1}.setDispDof(4,lbcbTgts{2}.disp(4));
% Set Ry from LBCB 2
mdlTgts{1}.setDispDof(5,-lbcbTgts{2}.disp(6));
% Set Rz from LBCB 2
mdlTgts{1}.setDispDof(6,lbcbTgts{2}.disp(5));

% Set Dx from LBCB 2
mdlTgts{1}.setForceDof(1,lbcbTgts{2}.force(1));
% Set Dy from LBCB 2
mdlTgts{1}.setForceDof(2,-lbcbTgts{2}.force(3));
% Set Dz from LBCB 2
mdlTgts{1}.setForceDof(3,lbcbTgts{2}.force(2));
% Set Rx from LBCB 2
mdlTgts{1}.setForceDof(4,lbcbTgts{2}.force(4));
% Set Ry from LBCB 2
mdlTgts{1}.setForceDof(5,-lbcbTgts{2}.force(6));
% Set Rz from LBCB 2
mdlTgts{1}.setForceDof(6,lbcbTgts{2}.force(5));


% Control Point 2

% Set Dx from LBCB 1
mdlTgts{2}.setDispDof(1,-lbcbTgts{1}.disp(1));
% Set Dy from LBCB 1
mdlTgts{2}.setDispDof(2,-lbcbTgts{1}.disp(3));
% Set Dz from LBCB 1
mdlTgts{2}.setDispDof(3,lbcbTgts{1}.disp(2));
% Set Rx from LBCB 1
mdlTgts{2}.setDispDof(4,lbcbTgts{1}.disp(4));
% Set Ry from LBCB 1
mdlTgts{2}.setDispDof(5,lbcbTgts{1}.disp(6));
% Set Rz from LBCB 1
mdlTgts{2}.setDispDof(6,-lbcbTgts{1}.disp(5));

% Set Dx from LBCB 1
mdlTgts{2}.setForceDof(1,-lbcbTgts{1}.force(1));
% Set Dy from LBCB 1
mdlTgts{2}.setForceDof(2,-lbcbTgts{1}.force(3));
% Set Dz from LBCB 1
mdlTgts{2}.setForceDof(3,lbcbTgts{1}.force(2));
% Set Rx from LBCB 1
mdlTgts{2}.setForceDof(4,lbcbTgts{1}.force(4));
% Set Ry from LBCB 1
mdlTgts{2}.setForceDof(5,lbcbTgts{1}.force(6));
% Set Rz from LBCB 1
mdlTgts{2}.setForceDof(6,-lbcbTgts{1}.force(5));

end