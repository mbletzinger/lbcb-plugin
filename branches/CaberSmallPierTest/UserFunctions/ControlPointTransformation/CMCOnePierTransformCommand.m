function lbcbTgts = CMCRubberTransformCommand(me,mdlTgts)  
lbcbTgts = { Target }; % create one Target for each LBCB

% axialforce=textread('C:\Documents and Settings\All Users\Desktop\LbcbPlugin\InputFiles\c5_ECC_5p_F2_2475_axialforce.txt');
% stepnum=me.stepNum.step;

%Coordinate Transformation from Model to LBCB
%Model is x_hor-pos_right, y_vert-pos_up, z_out_of_plane-pos_out
% Sheng-Lin 03-05-2010

% Portable LBCB (LBCB 2)

command = [mdlTgts{1}.disp(1),mdlTgts{1}.disp(2),mdlTgts{1}.disp(3),mdlTgts{1}.disp(4),mdlTgts{1}.disp(5),mdlTgts{1}.disp(6)];
fprintf(1,'\n %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f \n',command);

% Set Dx on LBCB 2
lbcbTgts{1}.setDispDof(1,mdlTgts{1}.disp(1));
% Set Dy on LBCB 2
lbcbTgts{1}.setDispDof(2,mdlTgts{1}.disp(3));
% Set Dz on LBCB 2
lbcbTgts{1}.setDispDof(3,-mdlTgts{1}.disp(2));
% lbcbTgts{1}.setForceDof(3,axialforce(stepnum));
% Set Rx on LBCB 2
lbcbTgts{1}.setDispDof(4,mdlTgts{1}.disp(4));
% Set Ry on LBCB 2
lbcbTgts{1}.setDispDof(5,mdlTgts{1}.disp(6));
% Set Rz on LBCB 2
lbcbTgts{1}.setDispDof(6,-mdlTgts{1}.disp(5));
%me.log.debug(dbstack, sprintf('M1 and L2 %s and %s', mdlTgts{1}.toString(),lbcbTgts{2}.toString()));

% size_factor=1;
% scale_factor=[size_factor 1 size_factor^2 size_factor^3];
% 
% [lbcbTgts{1}.disp,lbcbTgts{2}.disp] = scale_command(scale_factor,lbcbTgts);


end