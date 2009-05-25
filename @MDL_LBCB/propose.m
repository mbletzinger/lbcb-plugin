function obj = propose(obj)

%%% debugging code =================================================================================================================================

SimCor_Config;
obj.T_Disp = obj.T_Disp * cmd_scale_rubber;
%%% ========================================================================================================================================== %%%


obj.curStep = obj.curStep +1;         % increase current step number

obj.TransID  = sprintf('trans%4d%02d%02d%02d%02d%4.2f',clock);       % Create transaction ID

%send_str = sprintf('propose\t%s\tMDL-%02d-%02d\t',obj.TransID,0,1);
% By Sung Jig Kim, 04/30/2009
Tsend_str1 = sprintf('propose\t%s\tMDL-%02d-%02d:LBCB1\t',obj.TransID,0,1);  % For LBCB 1
Tsend_str2 = sprintf('propose\t%s\tMDL-%02d-%02d:LBCB2\t',obj.TransID,0,1);  % For LBCB 2
	% For LBCB 1
	tmp_str01 = sprintf('x\tdisplacement\t%.10e\t',	obj.T_Disp(1));
	tmp_str02 = sprintf('y\tdisplacement\t%.10e\t',	obj.T_Disp(2));
	tmp_str03 = sprintf('z\tdisplacement\t%.10e\t',	obj.T_Disp(3));
	tmp_str04 = sprintf('x\trotation\t%.10e\t',	obj.T_Disp(4));
	tmp_str05 = sprintf('y\trotation\t%.10e\t',	obj.T_Disp(5));
	tmp_str06 = sprintf('z\trotation\t%.10e\t',	obj.T_Disp(6));
    % For LBCB 2        
	tmp_str07 = sprintf('x\tdisplacement\t%.10e\t',	obj.T_Disp(7));
	tmp_str08 = sprintf('y\tdisplacement\t%.10e\t',	obj.T_Disp(8));
	tmp_str09 = sprintf('z\tdisplacement\t%.10e\t',	obj.T_Disp(9));
	tmp_str10 = sprintf('x\trotation\t%.10e\t',	obj.T_Disp(10));
	tmp_str11 = sprintf('y\trotation\t%.10e\t',	obj.T_Disp(11));
	tmp_str12 = sprintf('z\trotation\t%.10e\t',	obj.T_Disp(12));
% By Sung Jig Kim, 04/30/2009
send_str1 = [Tsend_str1 tmp_str01 tmp_str02 tmp_str03 tmp_str04 tmp_str05 tmp_str06];
send_str2 = [Tsend_str2 tmp_str07 tmp_str08 tmp_str09 tmp_str10 tmp_str11 tmp_str12];
send_str1 = send_str1(1:end-1);                 			% Remove last tab
send_str2 = send_str2(1:end-1);                 			% Remove last tab

% by Sung Jig Kim, 05/02/2009
% LBCB 1: Send proposing command and Receive acknowledgement
[obj.NetworkConnectionState]=SendandGetvar_LabView(obj, send_str1, 1); 

% LBCB 2: Send proposing command and Receive acknowledgement
if obj.NetworkConnectionState==1
	[obj.NetworkConnectionState]=SendandGetvar_LabView(obj, send_str2, 1); 
end

if obj.NetworkConnectionState==1
	obj.T_Disp_0 = obj.T_Disp;
	obj.tDisp_history(obj.curStep,:)    = obj.T_Disp;
	
	obj.curState = 1;  
end


