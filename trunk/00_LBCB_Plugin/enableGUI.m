function enableGUI(handles)

if handles.MDL.CtrlMode==2
	set(handles.Edit_K_low,		'enable',	'on');
	set(handles.Edit_Iteration_Ksec,'enable',	'on');
	set(handles.Edit_K_factor,	'enable',	'on');
	set(handles.Edit_Max_Itr,	'enable',	'on');
end

set(handles.CB_UpdateMonitor, 'enable', 'on');
if handles.MDL.UpdateMonitor
	set(handles.PM_Axis_X1,		'enable',	'on');
	set(handles.PM_Axis_Y1,		'enable',	'on');
	set(handles.PM_Axis_X2,		'enable',	'on');
	set(handles.PM_Axis_Y2,		'enable',	'on');
	set(handles.CB_MovingWindow,	'enable',	'on');
	set(handles.Edit_Window_Size,	'enable',	'on');
else
	set(handles.PM_Axis_X1,		'enable',	'off');
	set(handles.PM_Axis_Y1,		'enable',	'off');
	set(handles.PM_Axis_X2,		'enable',	'off');
	set(handles.PM_Axis_Y2,		'enable',	'off');
	set(handles.CB_MovingWindow,	'enable',	'off');
	set(handles.Edit_Window_Size,	'enable',	'off');
end


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
%set(handles.Edit_Disp_SF,	'enable',	'on');
%set(handles.Edit_Rotation_SF,	'enable',	'on');
%set(handles.Edit_Forc_SF,	'enable',	'on');
%set(handles.Edit_Moment_SF,	'enable',	'on');

set(handles.PB_Save_Config ,	'enable',	'on');
set(handles.PB_LBCB_Disconnect,	'enable',	'on');
set(handles.RB_Elastic_Deformation_ON,		'enable',	'on');
set(handles.RB_Elastic_Deformation_OFF,		'enable',	'on');
set(handles.RB_Disp_Refine_ON,			'enable',	'on');
set(handles.RB_Disp_Refine_OFF,			'enable',	'on');
set(handles.RB_Disp_Mesurement_LBCB,		'enable',	'on');
set(handles.RB_Disp_Mesurement_External,	'enable',	'on');