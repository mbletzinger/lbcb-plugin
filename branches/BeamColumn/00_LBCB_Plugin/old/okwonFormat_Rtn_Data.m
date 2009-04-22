function [handles send_str] = Format_Rtn_Data(handles)
% Convert 12 DOF LBCB data (2 nodes) to 9 DOF UI-SimCor data (3 nodes)


% ______________________________________________________________________________________________
%
% Conversion displacement from LBCB space to Model space
% ______________________________________________________________________________________________
% Load configuration file
Test_Config;


SF   = [ScaleF ScaleF ScaleF 1 1 1]';			%'% scale factor, displacement + rotation
SF_f = [ScaleF^2 ScaleF^2 ScaleF^2 ScaleF^3 ScaleF^3 ScaleF^3]';	%'% scale factor, force + moment

zer = zeros(3,3);

%% debugging ----------------
%handles.MDL.M_Disp = TDisp;
%handles.MDL.M_Forc = [1 0 3 0 4 0    2 0 6 0 8 0 ]';%'
%% debugging ----------------


MD2 = handles.MDL.M_Disp(7:12);		% measured displacement at beam node
MD3 = handles.MDL.M_Disp(1:6);		% measured displacement at column top

MF2 = handles.MDL.M_Forc(7:12)/1000;		% measured force at beam node, conversion from lb to kip
MF3 = handles.MDL.M_Forc(1:6)/1000;		% measured force at column top, conversion from lb to kip


MD2 = (1./SF).*(inv([T2 zer; zer T2r])*MD2);	 
MD3 = (1./SF).*(inv([T1 zer; zer T1r])*MD3);	

MF2 = (1./SF_f).*(inv([T2 zer; zer T2r])*MF2);	 
MF3 = (1./SF_f).*(inv([T1 zer; zer T1r])*MF3);	


MD2 = MD2([1 2 6]);		% model space
MD3 = MD3([1 2 6]);		% model space

MF2      = MF2([1 2 6]);		% model space
MF3      = MF3([1 2 6]);		% model space
MF1      = zeros(size(MF2));		% support reaction from equilibrium
MF1(1:2) = -(MF2(1:2)+MF3(1:2));
MF1(3)   = -(MF2(3)+MF3(3)) + MF3(1)*(coord_n3(2) - coord_n1(2)) + MF2(1)*(coord_n2(2) - coord_n1(2)) + MF2(2)*(coord_n1(1) - coord_n2(1));


MD2(3) = MD2(3) + handles.MDL.n1(3);
MD3(3) = MD3(3) + handles.MDL.n1(3);


% It is assumed that command and measurement are same at column base
% Relative movement. (2) rigid body rotation
Node1Cord = coord_n1';				%'% new configuration after deformation (coordinate of each nodes)
%Node2Cord = coord_n2' + MD2(1:2);		%'% new configuration after deformation
%Node3Cord = coord_n3' + MD3(1:2);		%'% new configuration after deformation
Node2Cord = coord_n2';		%'% new configuration after deformation
Node3Cord = coord_n3';		%'% new configuration after deformation

Rel2Cord = Node2Cord - Node1Cord;			% relative position after deformation
Rel3Cord = Node3Cord - Node1Cord;			% relative position after deformation

T = [cos(handles.MDL.n1(3)) -sin(handles.MDL.n1(3)); sin(handles.MDL.n1(3)) cos(handles.MDL.n1(3))];	% rotation matrix
tmp_r2 = T*Rel2Cord;
tmp_r3 = T*Rel3Cord;

MD2(1:2) = (tmp_r2 - (coord_n2' - coord_n1') + handles.MDL.n1(1:2)')'+ MD2(1:2)';			%'% increment of deformed configuration from undeformed configuration
MD3(1:2) = (tmp_r3 - (coord_n3' - coord_n1') + handles.MDL.n1(1:2)')'+ MD3(1:2)';			%'% increment of deformed configuration from undeformed configuration


% ======================================================================================================
send_str = sprintf('OK\t0\tdummy\t');

send_str = [send_str sprintf('MDL-%02d-%02d\t',0,1)];
send_str = [send_str sprintf('x\tdisplacement\t%.10e\t',MD2(1))];
send_str = [send_str sprintf('y\tdisplacement\t%.10e\t',MD2(2))];
send_str = [send_str sprintf('z\trotation\t%.10e\t',    MD2(3))];

send_str = [send_str sprintf('x\tforce\t%.10e\t',       MF2(1))];
send_str = [send_str sprintf('y\tforce\t%.10e\t',       MF2(2))]; 
send_str = [send_str sprintf('z\tmoment\t%.10e\t',      MF2(3))];


send_str = [send_str sprintf('MDL-%02d-%02d\t',0,2)];
send_str = [send_str sprintf('x\tdisplacement\t%.10e\t',handles.MDL.n1(1))];
send_str = [send_str sprintf('y\tdisplacement\t%.10e\t',handles.MDL.n1(2))];
send_str = [send_str sprintf('z\trotation\t%.10e\t',    handles.MDL.n1(3))];

send_str = [send_str sprintf('x\tforce\t%.10e\t',       MF1(1))];
send_str = [send_str sprintf('y\tforce\t%.10e\t',       MF1(2))];
send_str = [send_str sprintf('z\tmoment\t%.10e\t',      MF1(3))];


send_str = [send_str sprintf('MDL-%02d-%02d\t',0,3)];
send_str = [send_str sprintf('x\tdisplacement\t%.10e\t',MD3(1))];
send_str = [send_str sprintf('y\tdisplacement\t%.10e\t',MD3(2))];
send_str = [send_str sprintf('z\trotation\t%.10e\t',    MD3(3))];

send_str = [send_str sprintf('x\tforce\t%.10e\t',       MF3(1))];
send_str = [send_str sprintf('y\tforce\t%.10e\t',       MF3(2))];
send_str = [send_str sprintf('z\tmoment\t%.10e\t',      MF3(3))];

% ___________________________________________________________________________________________________
%
% Update monitoring pannel.
% ___________________________________________________________________________________________________

set(handles.TXT_Disp_M_Model, 'string', sprintf('n1x %+8.3f\nn1y %+8.3f\nn1r %+8.4f\nn2x %+8.3f\nn2y %+8.3f\nn2r %+8.4f\nn3x %+8.3f\nn3y %+8.3f\nn3r %+8.4f\n', ...
                                                [handles.MDL.n1(1) handles.MDL.n1(2) handles.MDL.n1(3) MD2(1) MD2(2) MD2(3) MD2(1) MD3(2) MD3(3)]));
set(handles.TXT_Forc_M_Model, 'string', sprintf('n1x %+8.0f\nn1y %+8.0f\nn1r %+8.0f\nn2x %+8.0f\nn2y %+8.0f\nn2r %+8.0f\nn3x %+8.0f\nn3y %+8.0f\nn3r %+8.0f\n', ...
                                                [MF1(1) MF1(2) MF1(3) MF2(1) MF2(2) MF2(3) MF3(1) MF3(2) MF3(3)]));
set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d', handles.MDL.curStep));