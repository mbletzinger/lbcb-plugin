function disableGUI(handles)

set(handles.RB_Disp_Ctrl,			'enable',	'off');
set(handles.RB_Forc_Ctrl,			'enable',	'off');
set(handles.MixedControl_Static,		'enable',	'off');

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

set(handles.CB_UpdateMonitor, 'enable', 'off');

% AUX moduel

set(handles.AUX_Module_Select,	'enable',	'off');	% this will automatically set OFF to 0
%set(handles.AUX_Connect,	'enable',	'off');
set(handles.AUX_Disconnect,	'enable',	'off');

