function obj = propose(obj)

obj.curStep = obj.curStep +1;         % increase current step number

obj.TransID  = sprintf('trans%4d%02d%02d%02d%02d%4.2f',clock);       % Create transaction ID
send_str = sprintf('propose\t%s\tMDL-%02d-%02d\t',obj.TransID,0,1);

if (obj.FrcCtrlDOF==1 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==1 & obj.CtrlMode == 3)
	tmp_str1 = sprintf('x\tforce\t%.10e\t',		obj.T_Forc(1));
else
	tmp_str1 = sprintf('x\tdisplacement\t%.10e\t',	obj.T_Disp(1));
end

if (obj.FrcCtrlDOF==2 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==2 & obj.CtrlMode == 3)
	tmp_str2 = sprintf('y\tforce\t%.10e\t',		obj.T_Forc(2));
else
	tmp_str2 = sprintf('y\tdisplacement\t%.10e\t',	obj.T_Disp(2));
end

% Only for vertical DOF in Static Test
if (obj.FrcCtrlDOF==3 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==3 & obj.CtrlMode == 3)
	tmp_str3 = sprintf('z\tforce\t%.10e\t',		obj.T_Forc(3));
else
	tmp_str3 = sprintf('z\tdisplacement\t%.10e\t',	obj.T_Disp(3));
end

if (obj.FrcCtrlDOF==4 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==4 & obj.CtrlMode == 3)
	tmp_str4 = sprintf('x\tmoment\t%.10e\t',	obj.T_Forc(4));
else
	tmp_str4 = sprintf('x\trotation\t%.10e\t',	obj.T_Disp(4));
end

if (obj.FrcCtrlDOF==5 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==5 & obj.CtrlMode == 3)
	tmp_str5 = sprintf('y\tmoment\t%.10e\t',	obj.T_Forc(5));
else
	tmp_str5 = sprintf('y\trotation\t%.10e\t',	obj.T_Disp(5));
end

if (obj.FrcCtrlDOF==6 & obj.CtrlMode == 2) | (obj.FrcCtrlDOF==6 & obj.CtrlMode == 3)
	tmp_str6 = sprintf('z\tmoment\t%.10e\t',	obj.T_Forc(6));
else
	tmp_str6 = sprintf('z\trotation\t%.10e\t',	obj.T_Disp(6));
end

send_str = [send_str tmp_str1 tmp_str2 tmp_str3 tmp_str4 tmp_str5 tmp_str6];

send_str = send_str(1:end-1);                 			% Remove last tab
Sendvar_LabView(obj,send_str);                                  % Send proposing command
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);                        % Receive acknowledgement

obj.T_Disp_0 = obj.T_Disp;
obj.T_Forc_0 = obj.T_Forc;
obj.tDisp_history(obj.curStep,:)    = obj.T_Disp;
obj.curState = 1;  

% For UI-SimCor or Text input Step
obj.tDisp_history_SC(obj.curStep,:) = obj.T_Disp_SC_his;

