function handles = Check_BeforePropose (handles)

% Seperate the displ. and Force.
if handles.MDL.CtrlMode==3  % For Static Mixed Module
	handles.MDL.T_Disp(handles.MDL.LBCB_FrcCtrlDOF~=1)= handles.MDL.LBCB_Target_1(handles.MDL.LBCB_FrcCtrlDOF~=1);
	handles.MDL.T_Forc(handles.MDL.LBCB_FrcCtrlDOF==1)= handles.MDL.LBCB_Target_1(handles.MDL.LBCB_FrcCtrlDOF==1);
else
	handles.MDL.T_Disp=handles.MDL.LBCB_Target_1;
end

% Update Current Target
% LBCB Target                                  
handles.MDL.LBCB_T_Displ = handles.MDL.T_Disp;       
handles.MDL.LBCB_T_Force = handles.MDL.T_Forc;       
UpdateMonitorPanel (handles, 2);

% Pause simulation to change the command for user option
if get (handles.UserInputOption_On, 'value')
	set(handles.PB_Pause, 'value', 0);  
	handles = HoldCheck(handles);
	
	%Update Target Displacement
	if handles.MDL.CtrlMode==3  % For Static Mixed Module
		handles.MDL.T_Disp(handles.MDL.LBCB_FrcCtrlDOF~=1)= handles.MDL.LBCB_Target_1(handles.MDL.LBCB_FrcCtrlDOF~=1);
		handles.MDL.T_Forc(handles.MDL.LBCB_FrcCtrlDOF==1)= handles.MDL.LBCB_Target_1(handles.MDL.LBCB_FrcCtrlDOF==1);
	else
		handles.MDL.T_Disp=handles.MDL.LBCB_Target_1;
	end
	handles.MDL.LBCB_T_Displ = handles.MDL.T_Disp;       
	handles.MDL.LBCB_T_Force = handles.MDL.T_Forc; 
	% Update Current Target
	UpdateMonitorPanel (handles, 2);
end

% Limit Check
accepted = 0;
while accepted == 0
	accepted = LimitCheck(handles);
	handles  = HoldCheck(handles);
end
