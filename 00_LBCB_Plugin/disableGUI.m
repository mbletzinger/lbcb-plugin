function disableGUI(handles)

set(handles.RB_Disp_Ctrl,			'enable',	'off');
set(handles.RB_Forc_Ctrl,			'enable',	'off');
set(handles.RB_Source_Network,			'enable',	'off');
set(handles.RB_Source_File,			'enable',	'off');
set(handles.RB_Elastic_Deformation_ON,		'enable',	'off');
set(handles.RB_Elastic_Deformation_OFF,		'enable',	'off');
set(handles.RB_Disp_Refine_ON,			'enable',	'off');
set(handles.RB_Disp_Refine_OFF,			'enable',	'off');
set(handles.RB_Disp_Mesurement_LBCB,		'enable',	'off');
set(handles.RB_Disp_Mesurement_External,	'enable',	'off');


set(handles.Edit_PortNo,	'enable',	'off');
set(handles.PB_Load_File,	'enable',	'off');
set(handles.Edit_File_Path,	'enable',	'off');
set(handles.PM_FileInput_Select,    'enable', 'off');
set(handles.Edit_FileInput_Add_Num, 'enable', 'off');
set(handles.PB_FileInput_Add,       'enable', 'off');
set(handles.PB_Input_Plot,          'enable', 'off');

set(handles.Edit_LBCB_IP,	'enable',	'off');
set(handles.Edit_LBCB_Port,	'enable',	'off');

set(handles.PM_Frc_Ctrl_DOF,	'enable',	'off');
set(handles.Edit_K_low,		'enable',	'off');
set(handles.Edit_Iteration_Ksec,'enable',	'off');
set(handles.Edit_K_factor,	'enable',	'off');
set(handles.Edit_Max_Itr,	'enable',	'off');
set(handles.PM_Model_Coord,	'enable',	'off');
set(handles.PM_LBCB_Coord,	'enable',	'off');

set(handles.CB_Disp_Limit,	'enable',	'off');
set(handles.CB_Disp_Inc,	'enable',	'off');
set(handles.CB_Forc_Limit,	'enable',	'off');

set(handles.Edit_DLmin_DOF1,	'enable',	'off');
set(handles.Edit_DLmin_DOF2,	'enable',	'off');
set(handles.Edit_DLmin_DOF3,	'enable',	'off');
set(handles.Edit_DLmin_DOF4,	'enable',	'off');
set(handles.Edit_DLmin_DOF5,	'enable',	'off');
set(handles.Edit_DLmin_DOF6,	'enable',	'off');
set(handles.Edit_DLmax_DOF1,	'enable',	'off');
set(handles.Edit_DLmax_DOF2,	'enable',	'off');
set(handles.Edit_DLmax_DOF3,	'enable',	'off');
set(handles.Edit_DLmax_DOF4,	'enable',	'off');
set(handles.Edit_DLmax_DOF5,	'enable',	'off');
set(handles.Edit_DLmax_DOF6,	'enable',	'off');
set(handles.Edit_DLinc_DOF1,	'enable',	'off');
set(handles.Edit_DLinc_DOF2,	'enable',	'off');
set(handles.Edit_DLinc_DOF3,	'enable',	'off');
set(handles.Edit_DLinc_DOF4,	'enable',	'off');
set(handles.Edit_DLinc_DOF5,	'enable',	'off');
set(handles.Edit_DLinc_DOF6,	'enable',	'off');
set(handles.Edit_FLmin_DOF1,	'enable',	'off');
set(handles.Edit_FLmin_DOF2,	'enable',	'off');
set(handles.Edit_FLmin_DOF3,	'enable',	'off');
set(handles.Edit_FLmin_DOF4,	'enable',	'off');
set(handles.Edit_FLmin_DOF5,	'enable',	'off');
set(handles.Edit_FLmin_DOF6,	'enable',	'off');
set(handles.Edit_FLmax_DOF1,	'enable',	'off');
set(handles.Edit_FLmax_DOF2,	'enable',	'off');
set(handles.Edit_FLmax_DOF3,	'enable',	'off');
set(handles.Edit_FLmax_DOF4,	'enable',	'off');
set(handles.Edit_FLmax_DOF5,	'enable',	'off');
set(handles.Edit_FLmax_DOF6,	'enable',	'off');
set(handles.Edit_Dtol_DOF1,	'enable',	'off');
set(handles.Edit_Dtol_DOF2,	'enable',	'off');
set(handles.Edit_Dtol_DOF3,	'enable',	'off');
set(handles.Edit_Dtol_DOF4,	'enable',	'off');
set(handles.Edit_Dtol_DOF5,	'enable',	'off');
set(handles.Edit_Dtol_DOF6,	'enable',	'off');
set(handles.Edit_Dsub_DOF1,	'enable',	'off');
set(handles.Edit_Dsub_DOF2,	'enable',	'off');
set(handles.Edit_Dsub_DOF3,	'enable',	'off');
set(handles.Edit_Dsub_DOF4,	'enable',	'off');
set(handles.Edit_Dsub_DOF5,	'enable',	'off');
set(handles.Edit_Dsub_DOF6,	'enable',	'off');

set(handles.Edit_Disp_SF,	'enable',	'off');
set(handles.Edit_Rotation_SF,	'enable',	'off');
set(handles.Edit_Forc_SF,	'enable',	'off');
set(handles.Edit_Moment_SF,	'enable',	'off');

set(handles.PB_Load_Config ,	'enable',	'off');
set(handles.PB_Load_Default,	'enable',	'off');
set(handles.PB_Save_Config ,	'enable',	'off');
set(handles.PB_LBCB_Disconnect,	'enable',	'off');

%set(handles.CB_UpdateMonitor, 'enable', 'off');

set(handles.RB_MixedControl_Static, 'enable', 'off');
set(handles.CB_MixedCtrl_Fx,	'enable',	'off');
set(handles.CB_MixedCtrl_Fy,	'enable',	'off');
set(handles.CB_MixedCtrl_Fz,	'enable',	'off');
set(handles.CB_MixedCtrl_Mx,	'enable',	'off');
set(handles.CB_MixedCtrl_My,	'enable',	'off');
set(handles.CB_MixedCtrl_Mz,	'enable',	'off');

set(handles.AUXModule_Disconnect,	'enable',	'off');
set(handles.AUXModule_Connect,	'enable',	'off');
%______________________________________________________________
%
% User Input Option
%______________________________________________________________

set(handles.UserInputOption_Off, 'enable','off');
set(handles.UserInputOption_On, 'enable', 'off');
set(handles.User_Cmd_DOF1,   'enable', 'off');
set(handles.User_Cmd_DOF2,   'enable', 'off');
set(handles.User_Cmd_DOF3,   'enable', 'off');
set(handles.User_Cmd_DOF4,   'enable', 'off');
set(handles.User_Cmd_DOF5,   'enable', 'off');
set(handles.User_Cmd_DOF6,   'enable', 'off');
set(handles.User_Cmd_Txt_Dx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Ry, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mx, 'enable', 'off');              
set(handles.User_Cmd_Txt_My, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mz, 'enable', 'off'); 

set(handles.STR_UserInput_PreviousTarget,  'enable', 'off');
set(handles.UserInputOption_M_AdjustedCMD, 'enable', 'off');
set(handles.STXT_AdjustedCMD, 'enable', 'off');

set(handles.PB_UserCMD_Pre_DOF1,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF2,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF3,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF4,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF5,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF6,        'enable', 'off');

set(handles.PB_UserCMD_Decrease_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF6,   'enable', 'off');

set(handles.PB_UserCMD_Increase_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF6,   'enable', 'off');

set(handles.ED_UserCMD_Increment_DOF1,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF2,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF3,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF4,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF5,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF6,  'enable', 'off');