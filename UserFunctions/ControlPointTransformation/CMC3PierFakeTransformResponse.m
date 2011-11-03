function mdlTgts = CMC3PierFakeTransformResponse(me,lbcbTgts)
mdlTgts = { Target }; % create a couple of model control points

%Coordinate Transformation from LBCB to Model
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Sheng-Lin 03-05-2010
global cmd_fake_3pier

K = [2236.35641942170,-8083.51679548224,170.011250814933,-2653.58862646182,-2203.10820957597,20842.2942210592;-8083.51679548224,327743.408149777,4831.31557791656,-77053.0796588298,13522.8102476946,10586.0231733143;170.011250814933,4831.31557791656,3240.02946347078,-26383.6523373394,448.628788594089,3279.72689075630;-2653.58862646182,-77053.0796588298,-26383.6523373394,536798.225881523,15303.8688270141,388.819079343672;-2203.10820957597,13522.8102476946,448.628788594089,15303.8688270141,226429.298163572,-2536.14539684758;20842.2942210592,10586.0231733143,3279.72689075630,388.819079343672,-2536.14539684758,606328.891372527;];
% targ = [lbcbTgts{1}.disp(1),-lbcbTgts{1}.disp(3),lbcbTgts{1}.disp(2),lbcbTgts{1}.disp(4),-lbcbTgts{1}.disp(6),lbcbTgts{1}.disp(5)];

% Portable LBCB (LBCB2)

temp = who('cmd_fake_3pier','global');
if isempty(temp)
    fprintf(1,'%%%%GET NOTHING\n');
    targ = [0.001*ones(1,3),0.0001*ones(1,3)];
%     targ = [lbcbTgts{1}.disp(1),-lbcbTgts{1}.disp(3),lbcbTgts{1}.disp(2),lbcbTgts{1}.disp(4),-lbcbTgts{1}.disp(6),lbcbTgts{1}.disp(5)];
else
    fprintf(1,'send cmd:    %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f\n',cmd_fake_3pier);
    targ = cmd_fake_3pier;
end
    
force = K*targ';

% Set Dx from LBCB 2
% mdlTgts{1}.setDispDof(1,lbcbTgts{1}.disp(1));
mdlTgts{1}.setDispDof(1,targ(1));
% Set Dy from LBCB 2
% mdlTgts{1}.setDispDof(2,-lbcbTgts{1}.disp(3));
mdlTgts{1}.setDispDof(2,targ(2));
% Set Dz from LBCB 2
% mdlTgts{1}.setDispDof(3,lbcbTgts{1}.disp(2));
mdlTgts{1}.setDispDof(3,targ(3));
% Set Rx from LBCB 2
% mdlTgts{1}.setDispDof(4,lbcbTgts{1}.disp(4));
mdlTgts{1}.setDispDof(4,targ(4));
% Set Ry from LBCB 2
% mdlTgts{1}.setDispDof(5,-lbcbTgts{1}.disp(6));
mdlTgts{1}.setDispDof(5,targ(5));
% Set Rz from LBCB 2
% mdlTgts{1}.setDispDof(6,lbcbTgts{1}.disp(5));
mdlTgts{1}.setDispDof(6,targ(6));

% % Set Fx from LBCB 2
% mdlTgts{1}.setForceDof(1,lbcbTgts{1}.force(1));
% % Set Fy from LBCB 2
% mdlTgts{1}.setForceDof(2,-lbcbTgts{1}.force(3));
% % Set Fz from LBCB 2
% mdlTgts{1}.setForceDof(3,lbcbTgts{1}.force(2));
% % Set Mx from LBCB 2
% mdlTgts{1}.setForceDof(4,lbcbTgts{1}.force(4));
% % Set My from LBCB 2
% mdlTgts{1}.setForceDof(5,-lbcbTgts{1}.force(6));
% % Set Mz from LBCB 2
% mdlTgts{1}.setForceDof(6,lbcbTgts{1}.force(5));

% Set Fx from LBCB 2
mdlTgts{1}.setForceDof(1,force(1)); 
% Set Fy from LBCB 2
mdlTgts{1}.setForceDof(2,force(2));
% Set Fz from LBCB 2
mdlTgts{1}.setForceDof(3,force(3)); 
% Set Mx from LBCB 2
mdlTgts{1}.setForceDof(4,force(4));
% Set My from LBCB 2
mdlTgts{1}.setForceDof(5,force(5));
% Set Mz from LBCB 2
mdlTgts{1}.setForceDof(6,force(6));

% size_factor=1;
% %scale factor=[disp,rot,force,moment]
% scale_factor=[size_factor 1 size_factor^2 size_factor^3];
% 
% [mdlTgts{1}.disp,mdlTgts{2}.disp,mdlTgts{1}.force,mdlTgts{2}.force] = scale_command_response(scale_factor,mdlTgts);


end