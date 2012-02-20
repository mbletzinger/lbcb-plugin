function mdlTgts = CMC3PierFake2BOXTransformResponse(me,lbcbTgts)  %#ok<INUSL>
mdlTgts = { Target Target }; % create a couple of model control points

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
global cmd_fake_test_3pier

K = [+5.094484e+003 -1.399501e+004 +3.872905e+002 -6.044952e+003 -3.814246e+003 +4.747935e+004 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
-1.399501e+004 +4.312413e+005 +8.364466e+003 -1.334021e+005 +1.779317e+004 +1.832760e+004 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
+3.872905e+002 +8.364466e+003 +7.380881e+003 -6.010272e+004 +7.767119e+002 +7.471313e+003 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
-6.044952e+003 -1.334021e+005 -6.010272e+004 +1.222842e+006 +2.649562e+004 +8.857411e+002 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
-3.814246e+003 +1.779317e+004 +7.767119e+002 +2.649562e+004 +2.979333e+005 -4.390833e+003 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
+4.747935e+004 +1.832760e+004 +7.471313e+003 +8.857411e+002 -4.390833e+003 +1.381235e+006 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +1.035350e+004 -2.245421e+004 +7.870891e+002 -1.228513e+004 -6.119745e+003 +9.649210e+004 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 -2.245421e+004 +5.462390e+005 +1.342032e+004 -2.140363e+005 +2.253802e+004 +2.940562e+004 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +7.870891e+002 +1.342032e+004 +1.500014e+004 -1.221465e+005 +1.246191e+003 +1.518392e+004 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 -1.228513e+004 -2.140363e+005 -1.221465e+005 +2.485177e+006 +4.251075e+004 +1.800088e+003 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 -6.119745e+003 +2.253802e+004 +1.246191e+003 +4.251075e+004 +3.773822e+005 -7.044848e+003 
+0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +0.000000e+000 +9.649210e+004 +2.940562e+004 +1.518392e+004 +1.800088e+003 -7.044848e+003 +2.807078e+006  ];



temp = who('cmd_fake_test_3pier','global');
if isempty(temp)
    disp = [0.001*ones(1,3),0.0001*ones(1,3),0.001*ones(1,3),0.0001*ones(1,3)];
    force = K*disp';
    fprintf(1,'NOT SEND THE TRUE RESPONSES TO SIMCOR\n');
else
    disp = cmd_fake_test_3pier;
    force = K*disp';
    fprintf(1,'send cmd: %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f %7.5f \n',cmd_fake_test_3pier);
end
% Control Point 1

% Set Dx from LBCB 2
% mdlTgts{1}.setDispDof(1,lbcbTgts{2}.disp(1));
mdlTgts{1}.setDispDof(1,disp(1));
% Set Dy from LBCB 2
% mdlTgts{1}.setDispDof(2,-lbcbTgts{2}.disp(3));
mdlTgts{1}.setDispDof(2,disp(2));
% Set Dz from LBCB 2
% mdlTgts{1}.setDispDof(3,lbcbTgts{2}.disp(2));
mdlTgts{1}.setDispDof(3,disp(3));
% Set Rx from LBCB 2
% mdlTgts{1}.setDispDof(4,lbcbTgts{2}.disp(4));
mdlTgts{1}.setDispDof(4,disp(4));
% Set Ry from LBCB 2
% mdlTgts{1}.setDispDof(5,-lbcbTgts{2}.disp(6));
mdlTgts{1}.setDispDof(5,disp(5));
% Set Rz from LBCB 2
% mdlTgts{1}.setDispDof(6,lbcbTgts{2}.disp(5));
mdlTgts{1}.setDispDof(6,disp(6));

% Set Dx from LBCB 2
% mdlTgts{1}.setForceDof(1,lbcbTgts{2}.force(1));
mdlTgts{1}.setForceDof(1,force(1));
% Set Dy from LBCB 2
% mdlTgts{1}.setForceDof(2,-lbcbTgts{2}.force(3));
mdlTgts{1}.setForceDof(2,force(2));
% Set Dz from LBCB 2
% mdlTgts{1}.setForceDof(3,lbcbTgts{2}.force(2));
mdlTgts{1}.setForceDof(3,force(3));
% Set Rx from LBCB 2
% mdlTgts{1}.setForceDof(4,lbcbTgts{2}.force(4));
mdlTgts{1}.setForceDof(4,force(4));
% Set Ry from LBCB 2
% mdlTgts{1}.setForceDof(5,-lbcbTgts{2}.force(6));
mdlTgts{1}.setForceDof(5,force(5));
% Set Rz from LBCB 2
% mdlTgts{1}.setForceDof(6,lbcbTgts{2}.force(5));
mdlTgts{1}.setForceDof(6,force(6));


% Control Point 2

% Set Dx from LBCB 1
% mdlTgts{2}.setDispDof(1,lbcbTgts{1}.disp(1));
mdlTgts{2}.setDispDof(1,disp(7));
% Set Dy from LBCB 1
% mdlTgts{2}.setDispDof(2,-lbcbTgts{1}.disp(3));
mdlTgts{2}.setDispDof(2,disp(8));
% Set Dz from LBCB 1
% mdlTgts{2}.setDispDof(3,lbcbTgts{1}.disp(2));
mdlTgts{2}.setDispDof(3,disp(9));
% Set Rx from LBCB 1
% mdlTgts{2}.setDispDof(4,lbcbTgts{1}.disp(4));
mdlTgts{2}.setDispDof(4,disp(10));
% Set Ry from LBCB 1
% mdlTgts{2}.setDispDof(5,-lbcbTgts{1}.disp(6));
mdlTgts{2}.setDispDof(5,disp(11));
% Set Rz from LBCB 1
% mdlTgts{2}.setDispDof(6,lbcbTgts{1}.disp(5));
mdlTgts{2}.setDispDof(6,disp(12));

% Set Dx from LBCB 1
% mdlTgts{2}.setForceDof(1,lbcbTgts{1}.force(1));
mdlTgts{2}.setForceDof(1,force(7));
% Set Dy from LBCB 1
% mdlTgts{2}.setForceDof(2,-lbcbTgts{1}.force(3));
mdlTgts{2}.setForceDof(2,force(8));
% Set Dz from LBCB 1
% mdlTgts{2}.setForceDof(3,lbcbTgts{1}.force(2));
mdlTgts{2}.setForceDof(3,force(9));
% Set Rx from LBCB 1
% mdlTgts{2}.setForceDof(4,lbcbTgts{1}.force(4));
mdlTgts{2}.setForceDof(4,force(10));
% Set Ry from LBCB 1
% mdlTgts{2}.setForceDof(5,-lbcbTgts{1}.force(6));
mdlTgts{2}.setForceDof(5,force(11));
% Set Rz from LBCB 1
% mdlTgts{2}.setForceDof(6,lbcbTgts{1}.force(5));
mdlTgts{2}.setForceDof(6,force(12));


% size_factor=1/24;
%scale factor=[disp,rot,force,moment]
% scale_factor=[size_factor 1 1000*size_factor^2 1000*size_factor^3];
% 
% [mdlTgts{1}.disp,mdlTgts{2}.disp,mdlTgts{1}.force,mdlTgts{2}.force] = scale_command_response(scale_factor,mdlTgts);



end