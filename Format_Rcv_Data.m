function [TransID, TDisp, handles] = Format_Rcv_Data(handles, recv_str)
% Convert 9 DOF (3 nodes) data from UI-SimCor to 12 DOF (2 nodes) data for LBCB1 (column top) and LBCB2 (beam end)



% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = {};

% recv_str = 'propose	trans20080206155057.44	handles.MDL-00-01	x	displacement	1.0000000000e-003	y	displacement	2.0000000000e-003	z	rotation	3.0000000000e-003	handles.MDL-00-02	x	displacement	4.0000000000e-003	y	displacement	5.0000000000e-003	z	rotation	6.0000000000e-003	handles.MDL-00-03	x	displacement	7.0000000000e-003	y	displacement	8.0000000000e-003	z	rotation	9.0000000000e-003  ';

% ___________________________________________________________________________________________________
%
% Parsing
% ___________________________________________________________________________________________________

delimeter = sprintf(' \t');
while length(recv_str)>0
    ind_i = ind_i+1;
    [token, recv_str] = strtok(recv_str,delimeter);
    recv{ind_i} = token;
end

TransID = recv{2};
recv = recv(3:end);		% remove transaction ID and propose command

TDisp1 = [str2num(recv{4})   str2num(recv{7})   str2num(recv{10})];  	% 1st node (beam)
TDisp2 = [str2num(recv{14})  str2num(recv{17})  str2num(recv{20})];  	% 2nd node (column bottom)
TDisp3 = [str2num(recv{24})  str2num(recv{27})  str2num(recv{30})];  	% 3rd node (column top)



% ___________________________________________________________________________________________________
%
% Convert absolute displacement to relative displacement 
% ___________________________________________________________________________________________________

% Load configuration file
SimCor_Config;
disp ('Hussam');

% Relative displacement of beam column connection (1st story, right-most connection) 
n1 = TDisp2;						% node on column bottom (at connection)          ||(n3)    
n2 = TDisp1;						% node on beam                            (n2)===||      
n3 = TDisp3;						% node on column top (at connection)             ||(n1)  



% n1 = [1 0 0]; 
% n2 = [0 0 0];
% n3 = [0 0 0];

handles.MDL.n1 = n1;

r2 = zeros(size(n2));
r3 = zeros(size(n3));

% (1) rigid body rotation
r2(3) = n2(3) - n1(3);
r3(3) = n3(3) - n1(3);

% Relative movement. (2) rigid body rotation
Node1Cord = coord_n1' + n1(1:2)';			% new configuration after deformation (coordinate of each nodes)
Node2Cord = coord_n2' + n2(1:2)';			% new configuration after deformation
Node3Cord = coord_n3' + n3(1:2)';			% new configuration after deformation

Rel2Cord = Node2Cord - Node1Cord;			% relative position after deformation
Rel3Cord = Node3Cord - Node1Cord;			% relative position after deformation

T = [cos(-n1(3)) -sin(-n1(3)); sin(-n1(3)) cos(-n1(3))];	% rotation matrix
tmp_r2 = T*Rel2Cord;
tmp_r3 = T*Rel3Cord;

r2(1:2) = (tmp_r2 - (coord_n2-coord_n1)');			%'% increment of deformed configuration from undeformed configuration
r3(1:2) = (tmp_r3 - (coord_n3-coord_n1)');                      %'% increment of deformed configuration from undeformed configuration

r2 = [r2(1) 0  r2(2)  0  r2(3)  0]';			%'% convert to 6 DOF. Use zeros for out of plane direction. Model coordinate system.
r3 = [r3(1) 0  r3(2)  0  r3(3)  0]';			%'% convert to 6 DOF. Use zeros for out of plane direction. Model coordinate system.


% ___________________________________________________________________________________________________
%
% Apply transformation matrix and scale factors for LBCB1 (column top) and LBCB2 (beam)
% ___________________________________________________________________________________________________


SF = [ScaleF ScaleF ScaleF 1 1 1]';		%'% scale factor
zer = zeros(3,3);

R2 = [T2 zer; zer T2r]*(SF.*r2);	% command to LBCB2 
R3 = [T1 zer; zer T1r]*(SF.*r3);	% command to LBCB1



TDisp = [R3; R2];		% 1st 6 row: LBCB1, 2nd 6 row: LBCB2



% ___________________________________________________________________________________________________
%
% Update monitoring pannel.
% ___________________________________________________________________________________________________

set(handles.TXT_Disp_T_Model,   'string', sprintf('n1x %+8.3f\nn1y %+8.3f\nn1r %+8.4f\nn2x %+8.3f\nn2y %+8.3f\nn2r %+8.4f\nn3x %+8.3f\nn3y %+8.3f\nn3r %+8.4f\n', [n1 n2 n3]));
set(handles.TXT_Model_Tgt_Step, 'string', sprintf('Step #: %d', handles.MDL.curStep));
