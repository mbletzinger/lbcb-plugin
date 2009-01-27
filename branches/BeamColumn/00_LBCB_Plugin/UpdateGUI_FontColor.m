function UpdateGUI_FontColor (handles, varargin)

switch varargin{1}
	case 1
		if handles.MDL.LBCB_FrcCtrlDOF(1)
			set(handles.User_Cmd_DOF1, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF1, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF1, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF1, 'ForegroundColor', [0 0 0]); 
			set(handles.Edit_Dtol_DOF1, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF1, 'ForegroundColor', [0 0 0]);
		end
		
		if handles.MDL.LBCB_FrcCtrlDOF(2)                           
			set(handles.User_Cmd_DOF2, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF2, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF2, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF2, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dtol_DOF2, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF2, 'ForegroundColor', [0 0 0]);
		end
		
		if handles.MDL.LBCB_FrcCtrlDOF(3)                           
			set(handles.User_Cmd_DOF3, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF3, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF3, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF3, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dtol_DOF3, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF3, 'ForegroundColor', [0 0 0]);
		end
		
		
		if handles.MDL.LBCB_FrcCtrlDOF(4)                           
			set(handles.User_Cmd_DOF4, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF4, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF4, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF4, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dtol_DOF4, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF4, 'ForegroundColor', [0 0 0]);
		end
		
		if handles.MDL.LBCB_FrcCtrlDOF(5)                           
			set(handles.User_Cmd_DOF5, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF5, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF5, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF5, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dtol_DOF5, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF5, 'ForegroundColor', [0 0 0]);
		end
		
		if handles.MDL.LBCB_FrcCtrlDOF(6)                           
			set(handles.User_Cmd_DOF6, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dtol_DOF6, 'ForegroundColor', [0 0 1]);
			set(handles.Edit_Dsub_DOF6, 'ForegroundColor', [0 0 1]);
		else
			set(handles.User_Cmd_DOF6, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dtol_DOF6, 'ForegroundColor', [0 0 0]);
			set(handles.Edit_Dsub_DOF6, 'ForegroundColor', [0 0 0]);
		end


end