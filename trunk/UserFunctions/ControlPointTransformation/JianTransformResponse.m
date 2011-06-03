function mdlTgts = JianTransformResponse(me,lbcbTgts)
mdlTgts = { Target Target }; % create a couple of model control points
                             % Target{1}: top of pier n8
                             % Target{2}: bottom of pier n9

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Jian Li 11-18-2010

% k_soil = 900000 * 0.2248 / 0.03937; % soil stiffness in lbf/in, 900000 M/mm
% Sk = (1/25^2)/(1/25); % scale factor for soil stiffness force/length
% k_soil_scaled = k_soil * Sk;

% Portable LBCB (LBCB2)
%% displacement measurement
% Set Dx from LBCB 2   n8 pier top
mdlTgts{1}.setDispDof(1,-lbcbTgts{1}.disp(2));
% Set Dy from LBCB 2
mdlTgts{1}.setDispDof(2,-lbcbTgts{1}.disp(3));
% Set Dz from LBCB 2
mdlTgts{1}.setDispDof(3,lbcbTgts{1}.disp(1) + me.modelCps{2}.command.disp(3)); % me.modelCps{2}: n9 Pier bottom
% Set Rx from LBCB 2
mdlTgts{1}.setDispDof(4,-lbcbTgts{1}.disp(5));
% Set Ry from LBCB 2
mdlTgts{1}.setDispDof(5,-lbcbTgts{1}.disp(6));
% Set Rz from LBCB 2
mdlTgts{1}.setDispDof(6,lbcbTgts{1}.disp(4));

% Set Dx from LBCB 2   n9 pier bottom
mdlTgts{2}.setDispDof(1,0);
% Set Dy from LBCB 2
mdlTgts{2}.setDispDof(2,0);
% Set Dz from LBCB 2
mdlTgts{2}.setDispDof(3,me.modelCps{2}.command.disp(3));
% Set Rx from LBCB 2
mdlTgts{2}.setDispDof(4,0);
% Set Ry from LBCB 2
mdlTgts{2}.setDispDof(5,0);
% Set Rz from LBCB 2
mdlTgts{2}.setDispDof(6,0);


%% force measurement
% Set Fx from LBCB 2   n8  pier top
mdlTgts{1}.setForceDof(1,-lbcbTgts{1}.force(2)); % not effective DOF
% Set Fy from LBCB 2
mdlTgts{1}.setForceDof(2,-lbcbTgts{1}.force(3)); % effective DOF
% Set Fz from LBCB 2
mdlTgts{1}.setForceDof(3,lbcbTgts{1}.force(1));  % effective DOF
% Set Mx from LBCB 2
mdlTgts{1}.setForceDof(4,-lbcbTgts{1}.force(5)); % effective DOF
% Set My from LBCB 2
mdlTgts{1}.setForceDof(5,-lbcbTgts{1}.force(6)); % not effective DOF
% Set Mz from LBCB 2
mdlTgts{1}.setForceDof(6,lbcbTgts{1}.force(4));  % not effective DOF

% Set Fx from LBCB 2   n9  pier bottom
mdlTgts{2}.setForceDof(1,lbcbTgts{1}.force(2));  % not effective DOF         x9 = -x8
% Set Fy from LBCB 2     
mdlTgts{2}.setForceDof(2,lbcbTgts{1}.force(3));  % not effective DOF         y9 = -y8
% Set Fz from LBCB 2
mdlTgts{2}.setForceDof(3,-lbcbTgts{1}.force(1)); % effective DOF            z9 = -z8
% Set Mx from LBCB 2
mdlTgts{2}.setForceDof(4,lbcbTgts{1}.force(5)-lbcbTgts{1}.force(1)*10.08);  % not effective DOF   rx9 = -rx8 - z8*h
% Set My from LBCB 2
mdlTgts{2}.setForceDof(5,lbcbTgts{1}.force(6));  % not effective DOF        ry9 = -ry8
% Set Mz from LBCB 2
mdlTgts{2}.setForceDof(6,-lbcbTgts{1}.force(4)-lbcbTgts{1}.force(2)*10.08);  % not effective DOF  rz9 = -rz8 + x8*h


size_factor=1;
%scale factor=[disp,rot,force,moment]
scale_factor=[size_factor 1 size_factor^2 size_factor^3];

[mdlTgts{1}.disp,mdlTgts{2}.disp,mdlTgts{1}.force,mdlTgts{2}.force] = scale_command_response(scale_factor,mdlTgts);


end