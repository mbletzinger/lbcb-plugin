function enableGUI(handles)


if handles.MDL.InputSource==1
	set(handles.Edit_File_Path,	'enable',	'on');
	set(handles.PB_Load_File,	'enable',	'on');
	set(handles.PM_FileInput_Select,    'enable', 'on');
	set(handles.Edit_FileInput_Add_Num, 'enable', 'on');
	set(handles.PB_FileInput_Add,       'enable', 'on');
	set(handles.PB_Input_Plot,          'enable', 'on');
end 

if handles.MDL.CtrlMode==2
	set(handles.Edit_K_low,		'enable',	'on');
	set(handles.Edit_Iteration_Ksec,'enable',	'on');
	set(handles.Edit_K_factor,	'enable',	'on');
elseif handles.MDL.CtrlMode==3
	%set(handles.CB_MixedCtrl_Fx,	'enable',	'on');
	%set(handles.CB_MixedCtrl_Fy,	'enable',	'on');
	%set(handles.CB_MixedCtrl_Fz,	'enable',	'on');
	%set(handles.CB_MixedCtrl_Mx,	'enable',	'on');
	%set(handles.CB_MixedCtrl_My,	'enable',	'on');
	%set(handles.CB_MixedCtrl_Mz,	'enable',	'on');
end
set(handles.Edit_Max_Itr,	'enable',	'on');

%set(handles.CB_UpdateMonitor, 'enable', 'on');
%if handles.MDL.UpdateMonitor
	set(handles.PM_Axis_X1,		'enable',	'on');
	set(handles.PM_Axis_Y1,		'enable',	'on');
	set(handles.PM_Axis_X2,		'enable',	'on');
	set(handles.PM_Axis_Y2,		'enable',	'on');
	set(handles.CB_MovingWindow,	'enable',	'on');
	set(handles.Edit_Window_Size,	'enable',	'on');
%else
%	set(handles.PM_Axis_X1,		'enable',	'off');
%	set(handles.PM_Axis_Y1,		'enable',	'off');
%	set(handles.PM_Axis_X2,		'enable',	'off');
%	set(handles.PM_Axis_Y2,		'enable',	'off');
%	set(handles.CB_MovingWindow,	'enable',	'off');
%	set(handles.Edit_Window_Size,	'enable',	'off');
%end


set(handles.CB_Disp_Limit,	'enable',	'on');
set(handles.CB_Disp_Inc,	'enable',	'on');
set(handles.CB_Forc_Limit,	'enable',	'on');

set(handles.Edit_DLmin_DOF1,	'enable',	'on');
set(handles.Edit_DLmin_DOF2,	'enable',	'on');
set(handles.Edit_DLmin_DOF3,	'enable',	'on');
set(handles.Edit_DLmin_DOF4,	'enable',	'on');
set(handles.Edit_DLmin_DOF5,	'enable',	'on');
set(handles.Edit_DLmin_DOF6,	'enable',	'on');
set(handles.Edit_DLmax_DOF1,	'enable',	'on');
set(handles.Edit_DLmax_DOF2,	'enable',	'on');
set(handles.Edit_DLmax_DOF3,	'enable',	'on');
set(handles.Edit_DLmax_DOF4,	'enable',	'on');
set(handles.Edit_DLmax_DOF5,	'enable',	'on');
set(handles.Edit_DLmax_DOF6,	'enable',	'on');
set(handles.Edit_DLinc_DOF1,	'enable',	'on');
set(handles.Edit_DLinc_DOF2,	'enable',	'on');
set(handles.Edit_DLinc_DOF3,	'enable',	'on');
set(handles.Edit_DLinc_DOF4,	'enable',	'on');
set(handles.Edit_DLinc_DOF5,	'enable',	'on');
set(handles.Edit_DLinc_DOF6,	'enable',	'on');
set(handles.Edit_FLmin_DOF1,	'enable',	'on');
set(handles.Edit_FLmin_DOF2,	'enable',	'on');
set(handles.Edit_FLmin_DOF3,	'enable',	'on');
set(handles.Edit_FLmin_DOF4,	'enable',	'on');
set(handles.Edit_FLmin_DOF5,	'enable',	'on');
set(handles.Edit_FLmin_DOF6,	'enable',	'on');
set(handles.Edit_FLmax_DOF1,	'enable',	'on');
set(handles.Edit_FLmax_DOF2,	'enable',	'on');
set(handles.Edit_FLmax_DOF3,	'enable',	'on');
set(handles.Edit_FLmax_DOF4,	'enable',	'on');
set(handles.Edit_FLmax_DOF5,	'enable',	'on');
set(handles.Edit_FLmax_DOF6,	'enable',	'on');
set(handles.Edit_Dtol_DOF1,	'enable',	'on');
set(handles.Edit_Dtol_DOF2,	'enable',	'on');
set(handles.Edit_Dtol_DOF3,	'enable',	'on');
set(handles.Edit_Dtol_DOF4,	'enable',	'on');
set(handles.Edit_Dtol_DOF5,	'enable',	'on');
set(handles.Edit_Dtol_DOF6,	'enable',	'on');
set(handles.Edit_Dsub_DOF1,	'enable',	'on');
set(handles.Edit_Dsub_DOF2,	'enable',	'on');
set(handles.Edit_Dsub_DOF3,	'enable',	'on');
set(handles.Edit_Dsub_DOF4,	'enable',	'on');
set(handles.Edit_Dsub_DOF5,	'enable',	'on');
set(handles.Edit_Dsub_DOF6,	'enable',	'on');

set(handles.PB_Save_Config ,	'enable',	'on');
set(handles.PB_LBCB_Disconnect,	'enable',	'on');
set(handles.RB_Elastic_Deformation_ON,		'enable',	'on');
set(handles.RB_Elastic_Deformation_OFF,		'enable',	'on');
set(handles.RB_Disp_Refine_ON,			'enable',	'on');
set(handles.RB_Disp_Refine_OFF,			'enable',	'on');
set(handles.RB_Disp_Mesurement_LBCB,		'enable',	'on');
set(handles.RB_Disp_Mesurement_External,	'enable',	'on');


if handles.Num_AuxModule~=0
	set(handles.AUXModule_Disconnect,	'enable',	'on');
end

%______________________________________________________________
%
% User Input Option
%______________________________________________________________

set(handles.UserInputOption_Off, 'enable','on');
set(handles.UserInputOption_On, 'enable', 'on');

if handles.MDL.LBCB_FrcCtrlDOF(1)
	set(handles.User_Cmd_DOF1,  'string', sprintf('%12.3f', handles.MDL.T_Forc(1)));
	set(handles.PB_UserCMD_Pre_DOF1,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(1)));
else
	set(handles.User_Cmd_DOF1,  'string', sprintf('%12.7f', handles.MDL.T_Disp(1)));
	set(handles.PB_UserCMD_Pre_DOF1,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(1)));
end

if handles.MDL.LBCB_FrcCtrlDOF(2)
	set(handles.User_Cmd_DOF2,  'string', sprintf('%12.3f', handles.MDL.T_Forc(2)));
	set(handles.PB_UserCMD_Pre_DOF2,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(2)));
else
	set(handles.User_Cmd_DOF2,  'string', sprintf('%12.7f', handles.MDL.T_Disp(2)));
	set(handles.PB_UserCMD_Pre_DOF2,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(2)));
end

if handles.MDL.LBCB_FrcCtrlDOF(3)
	set(handles.User_Cmd_DOF3,  'string', sprintf('%12.3f', handles.MDL.T_Forc(3)));
	set(handles.PB_UserCMD_Pre_DOF3,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(3)));
else
	set(handles.User_Cmd_DOF3,  'string', sprintf('%12.7f', handles.MDL.T_Disp(3)));
	set(handles.PB_UserCMD_Pre_DOF3,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(3)));
end

if handles.MDL.LBCB_FrcCtrlDOF(4)
	set(handles.User_Cmd_DOF4,  'string', sprintf('%12.3f', handles.MDL.T_Forc(4)));
	set(handles.PB_UserCMD_Pre_DOF4,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(4)));
else
	set(handles.User_Cmd_DOF4,  'string', sprintf('%12.7f', handles.MDL.T_Disp(4)));
	set(handles.PB_UserCMD_Pre_DOF4,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(4)));
end

if handles.MDL.LBCB_FrcCtrlDOF(5)
	set(handles.User_Cmd_DOF5,  'string', sprintf('%12.3f', handles.MDL.T_Forc(5)));
	set(handles.PB_UserCMD_Pre_DOF5,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(5)));
else
	set(handles.User_Cmd_DOF5,  'string', sprintf('%12.7f', handles.MDL.T_Disp(5)));
	set(handles.PB_UserCMD_Pre_DOF5,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(5)));
end

if handles.MDL.LBCB_FrcCtrlDOF(6)
	set(handles.User_Cmd_DOF6,  'string', sprintf('%12.3f', handles.MDL.T_Forc(6)));
	set(handles.PB_UserCMD_Pre_DOF6,  'string', sprintf('%12.3f', handles.MDL.LBCB_Target_0(6)));
else
	set(handles.User_Cmd_DOF6,  'string', sprintf('%12.7f', handles.MDL.T_Disp(6)));
	set(handles.PB_UserCMD_Pre_DOF6,  'string', sprintf('%12.7f', handles.MDL.LBCB_Target_0(6)));
end

if get(handles.UserInputOption_On, 'value')
	set(handles.User_Cmd_DOF1,   'enable', 'on');
	set(handles.User_Cmd_DOF2,   'enable', 'on');
	set(handles.User_Cmd_DOF3,   'enable', 'on');
	set(handles.User_Cmd_DOF4,   'enable', 'on');
	set(handles.User_Cmd_DOF5,   'enable', 'on');
	set(handles.User_Cmd_DOF6,   'enable', 'on');
	set(handles.User_Cmd_Txt_Dx, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Dy, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Dz, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Rx, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Ry, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Rz, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Fx, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Fy, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Fz, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Mx, 'enable', 'on');              
	set(handles.User_Cmd_Txt_My, 'enable', 'on');              
	set(handles.User_Cmd_Txt_Mz, 'enable', 'on'); 
	set(handles.STR_UserInput_PreviousTarget, 'enable', 'on');
	
	set(handles.STXT_AdjustedCMD,             'enable', 'on');
	set(handles.UserInputOption_M_AdjustedCMD, 'enable', 'on');
	
	
	set(handles.PB_UserCMD_Pre_DOF1,        'enable', 'on');
	set(handles.PB_UserCMD_Pre_DOF2,        'enable', 'on');
	set(handles.PB_UserCMD_Pre_DOF3,        'enable', 'on');
	set(handles.PB_UserCMD_Pre_DOF4,        'enable', 'on');
	set(handles.PB_UserCMD_Pre_DOF5,        'enable', 'on');
	set(handles.PB_UserCMD_Pre_DOF6,        'enable', 'on');
	
	set(handles.PB_UserCMD_Decrease_DOF1,   'enable', 'on');
	set(handles.PB_UserCMD_Decrease_DOF2,   'enable', 'on');
	set(handles.PB_UserCMD_Decrease_DOF3,   'enable', 'on');
	set(handles.PB_UserCMD_Decrease_DOF4,   'enable', 'on');
	set(handles.PB_UserCMD_Decrease_DOF5,   'enable', 'on');
	set(handles.PB_UserCMD_Decrease_DOF6,   'enable', 'on');
	
	set(handles.PB_UserCMD_Increase_DOF1,   'enable', 'on');
	set(handles.PB_UserCMD_Increase_DOF2,   'enable', 'on');
	set(handles.PB_UserCMD_Increase_DOF3,   'enable', 'on');
	set(handles.PB_UserCMD_Increase_DOF4,   'enable', 'on');
	set(handles.PB_UserCMD_Increase_DOF5,   'enable', 'on');
	set(handles.PB_UserCMD_Increase_DOF6,   'enable', 'on');
	
	set(handles.ED_UserCMD_Increment_DOF1,  'enable', 'on');
	set(handles.ED_UserCMD_Increment_DOF2,  'enable', 'on');
	set(handles.ED_UserCMD_Increment_DOF3,  'enable', 'on');
	set(handles.ED_UserCMD_Increment_DOF4,  'enable', 'on');
	set(handles.ED_UserCMD_Increment_DOF5,  'enable', 'on');
	set(handles.ED_UserCMD_Increment_DOF6,  'enable', 'on');
end

