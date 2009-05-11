function disableGUI(handles)

set(handles.RB_Source_Network,			'enable',	'off');
set(handles.RB_Source_File,			'enable',	'off');
set(handles.RB_Elastic_Deformation_ON,		'enable',	'off');
set(handles.RB_Elastic_Deformation_OFF,		'enable',	'off');
set(handles.RB_Disp_Refine_ON,			'enable',	'off');
set(handles.RB_Disp_Refine_OFF,			'enable',	'off');
set(handles.RB_Disp_Mesurement_LBCB,		'enable',	'off');
set(handles.RB_Disp_Mesurement_External,	'enable',	'off');
%%%%%
% Modified by Sung Jig Kim, 05/02/2009
set(handles.Edit_LBCB_NetworkWaitTime, 'enable', 'off');
set(handles.PB_LBCB_Reconnect,	'enable',	'off');
%%%%
set(handles.EB_Max_Itr,		        'enable',	'off');
set(handles.Edit_PortNo,	'enable',	'off');
set(handles.PB_Load_File,	'enable',	'off');
set(handles.Edit_File_Path,	'enable',	'off');
set(handles.Edit_LBCB_IP_1,	'enable',	'off');
set(handles.Edit_LBCB_Port_1,	'enable',	'off');
% set(handles.Edit_LBCB_IP_2,	'enable',	'off');
% set(handles.Edit_LBCB_Port_2,	'enable',	'off');

set(handles.CB_Disp_Limit1,	'enable',	'off');
set(handles.CB_Disp_Inc1,	'enable',	'off');
set(handles.CB_Forc_Limit1,	'enable',	'off');
set(handles.CB_Disp_Limit2,	'enable',	'off');
set(handles.CB_Disp_Inc2,	'enable',	'off');
set(handles.CB_Forc_Limit2,	'enable',	'off');

set(handles.Edit_DLmin_DOF11,	'enable',	'off');
set(handles.Edit_DLmin_DOF12,	'enable',	'off');
set(handles.Edit_DLmin_DOF13,	'enable',	'off');
set(handles.Edit_DLmin_DOF14,	'enable',	'off');
set(handles.Edit_DLmin_DOF15,	'enable',	'off');
set(handles.Edit_DLmin_DOF16,	'enable',	'off');
set(handles.Edit_DLmin_DOF21,	'enable',	'off');
set(handles.Edit_DLmin_DOF22,	'enable',	'off');
set(handles.Edit_DLmin_DOF23,	'enable',	'off');
set(handles.Edit_DLmin_DOF24,	'enable',	'off');
set(handles.Edit_DLmin_DOF25,	'enable',	'off');
set(handles.Edit_DLmin_DOF26,	'enable',	'off');

set(handles.Edit_DLmax_DOF11,	'enable',	'off');
set(handles.Edit_DLmax_DOF12,	'enable',	'off');
set(handles.Edit_DLmax_DOF13,	'enable',	'off');
set(handles.Edit_DLmax_DOF14,	'enable',	'off');
set(handles.Edit_DLmax_DOF15,	'enable',	'off');
set(handles.Edit_DLmax_DOF16,	'enable',	'off');  
set(handles.Edit_DLmax_DOF21,	'enable',	'off');
set(handles.Edit_DLmax_DOF22,	'enable',	'off');
set(handles.Edit_DLmax_DOF23,	'enable',	'off');
set(handles.Edit_DLmax_DOF24,	'enable',	'off');
set(handles.Edit_DLmax_DOF25,	'enable',	'off');
set(handles.Edit_DLmax_DOF26,	'enable',	'off');  

set(handles.Edit_DLinc_DOF11,	'enable',	'off');
set(handles.Edit_DLinc_DOF12,	'enable',	'off');
set(handles.Edit_DLinc_DOF13,	'enable',	'off');
set(handles.Edit_DLinc_DOF14,	'enable',	'off');
set(handles.Edit_DLinc_DOF15,	'enable',	'off');
set(handles.Edit_DLinc_DOF16,	'enable',	'off');  
set(handles.Edit_DLinc_DOF21,	'enable',	'off');
set(handles.Edit_DLinc_DOF22,	'enable',	'off');
set(handles.Edit_DLinc_DOF23,	'enable',	'off');
set(handles.Edit_DLinc_DOF24,	'enable',	'off');
set(handles.Edit_DLinc_DOF25,	'enable',	'off');
set(handles.Edit_DLinc_DOF26,	'enable',	'off');  

set(handles.Edit_FLmin_DOF11,	'enable',	'off');
set(handles.Edit_FLmin_DOF12,	'enable',	'off');
set(handles.Edit_FLmin_DOF13,	'enable',	'off');
set(handles.Edit_FLmin_DOF14,	'enable',	'off');
set(handles.Edit_FLmin_DOF15,	'enable',	'off');
set(handles.Edit_FLmin_DOF16,	'enable',	'off');
set(handles.Edit_FLmin_DOF21,	'enable',	'off');
set(handles.Edit_FLmin_DOF22,	'enable',	'off');
set(handles.Edit_FLmin_DOF23,	'enable',	'off');
set(handles.Edit_FLmin_DOF24,	'enable',	'off');
set(handles.Edit_FLmin_DOF25,	'enable',	'off');
set(handles.Edit_FLmin_DOF26,	'enable',	'off');

set(handles.Edit_FLmax_DOF11,	'enable',	'off');
set(handles.Edit_FLmax_DOF12,	'enable',	'off');
set(handles.Edit_FLmax_DOF13,	'enable',	'off');
set(handles.Edit_FLmax_DOF14,	'enable',	'off');
set(handles.Edit_FLmax_DOF15,	'enable',	'off');
set(handles.Edit_FLmax_DOF16,	'enable',	'off');
set(handles.Edit_FLmax_DOF21,	'enable',	'off');
set(handles.Edit_FLmax_DOF22,	'enable',	'off');
set(handles.Edit_FLmax_DOF23,	'enable',	'off');
set(handles.Edit_FLmax_DOF24,	'enable',	'off');
set(handles.Edit_FLmax_DOF25,	'enable',	'off');
set(handles.Edit_FLmax_DOF26,	'enable',	'off');

set(handles.Edit_Dtol_DOF11,	'enable',	'off');
set(handles.Edit_Dtol_DOF12,	'enable',	'off');
set(handles.Edit_Dtol_DOF13,	'enable',	'off');
set(handles.Edit_Dtol_DOF14,	'enable',	'off');
set(handles.Edit_Dtol_DOF15,	'enable',	'off');
set(handles.Edit_Dtol_DOF16,	'enable',	'off');        
set(handles.Edit_Dtol_DOF21,	'enable',	'off');
set(handles.Edit_Dtol_DOF22,	'enable',	'off');
set(handles.Edit_Dtol_DOF23,	'enable',	'off');
set(handles.Edit_Dtol_DOF24,	'enable',	'off');
set(handles.Edit_Dtol_DOF25,	'enable',	'off');
set(handles.Edit_Dtol_DOF26,	'enable',	'off');        

set(handles.Edit_Dsub_DOF11,	'enable',	'off');
set(handles.Edit_Dsub_DOF12,	'enable',	'off');
set(handles.Edit_Dsub_DOF13,	'enable',	'off');
set(handles.Edit_Dsub_DOF14,	'enable',	'off');
set(handles.Edit_Dsub_DOF15,	'enable',	'off');
set(handles.Edit_Dsub_DOF16,	'enable',	'off');
set(handles.Edit_Dsub_DOF21,	'enable',	'off');
set(handles.Edit_Dsub_DOF22,	'enable',	'off');
set(handles.Edit_Dsub_DOF23,	'enable',	'off');
set(handles.Edit_Dsub_DOF24,	'enable',	'off');
set(handles.Edit_Dsub_DOF25,	'enable',	'off');
set(handles.Edit_Dsub_DOF26,	'enable',	'off');

set(handles.PB_LBCB_Disconnect,	'enable',	'off');


set (handles.PB_AuxModule_Connect,    'enable', 'off');
set (handles.PB_AuxModule_Reconnect,  'enable', 'off');
set (handles.PB_AuxModule_Disconnect, 'enable', 'off');

