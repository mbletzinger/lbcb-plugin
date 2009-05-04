function handles = Reconnect_LBCB(handles)
% =====================================================================================================================
% Reconnect remote site using LABVIEW protocol
%
% Written by    5/02/2009 Sung Jig KIM
% Last update   5/02/2009 Sung Jig KIM
% =====================================================================================================================

if get(handles.PB_LBCB_Reconnect, 'UserData')
	% close the corrent network port.
	close(handles.MDL);
	disp_str ='The current network is closed for RECONNECTION';
	disp(disp_str);
	set(handles.PB_LBCB_Reconnect, 'UserData', 0);
end
% Connect...
handles = readGUI(handles);				% Read parameters from GUI
handles.MDL = open(handles.MDL);
if handles.MDL.NetworkConnectionState
	disp ('Connection is established with LBCB.');
	set(handles.PB_LBCB_Reconnect, 'UserData', 1);
	
	StatusIndicator(handles,23);
	disp ('Read the current LBCB displacement and force data.');	
	handles.MDL = query_mean(handles.MDL,1);

	if handles.MDL.NetworkConnectionState
		set(handles.TXT_Disp_M_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.3f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.3f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
		set(handles.TXT_Forc_M_LBCB, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
		updatePLOT(handles);
		StatusIndicator(handles,20);	
        tmp01=handles.MDL.M_Disp;
        % Save the current position
		save ('CurrentLBCB_Position.txt', 'tmp01','-ascii');
		button2 = questdlg('Do you want to set up the LBCB offset?','LBCB Offset','Yes','No','No');
		if strcmp(button2,'Yes')
			Help_String='Hussam!, The setting for LBCB offset is under construction';
			helpdlg(Help_String,'Under construction');
		end
		set(handles.PB_LBCB_Reconnect,	'enable',	'off');
	end
end

if handles.MDL.NetworkConnectionState==0
	Help_String='No Connection present. Try it again';
	helpdlg(Help_String,'Warning');
	set(handles.PB_LBCB_Reconnect,	'enable',	'on');
end

handles = readGUI(handles);
