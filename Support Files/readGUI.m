function handles = readGUI(handles)

handles.MDL.InputPort 		= str2num(get(handles.Edit_PortNo,  	'String'));
handles.MDL.InputFile 		= get(handles.Edit_File_Path,       	'String');
handles.MDL.IP 			= get(handles.Edit_LBCB_IP,	    	'String');
handles.MDL.Port 		= str2num(get(handles.Edit_LBCB_Port,	'String'));

% handles.MDL.K_vert_ini 		= str2num(get(handles.Edit_K_low,   	'string'));
% handles.MDL.secK_eval_itr 	= str2num(get(handles.Edit_Iteration_Ksec,'string'));
% handles.MDL.secK_factor 	= str2num(get(handles.Edit_K_factor,	'string'));
handles.MDL.max_itr 		= str2num(get(handles.Edit_Max_Itr, 	'string'));

handles.MDL.ScaleF(1) 		= str2num(get(handles.Edit_Disp_SF, 	'string'));
handles.MDL.ScaleF(2) 		= str2num(get(handles.Edit_Rotation_SF,	'string'));
handles.MDL.ScaleF(3) 		= str2num(get(handles.Edit_Forc_SF, 	'string'));
handles.MDL.ScaleF(4) 		= str2num(get(handles.Edit_Moment_SF,	'string'));

handles.MDL.UpdateMonitor	= get(handles.CB_UpdateMonitor, 'value');

handles.MDL.CheckLimit_Disp  	= get(handles.CB_Disp_Limit, 'value');      
handles.MDL.CheckLimit_DispInc  = get(handles.CB_Disp_Inc,   'value');      
handles.MDL.CheckLimit_Forc  	= get(handles.CB_Forc_Limit, 'value');      
                                                                    	
handles.MDL.CAP_D_min(1) 	= str2num(get(handles.Edit_DLmin_DOF1, 	'string'));
handles.MDL.CAP_D_min(2) 	= str2num(get(handles.Edit_DLmin_DOF2, 	'string'));
handles.MDL.CAP_D_min(3) 	= str2num(get(handles.Edit_DLmin_DOF3, 	'string'));
handles.MDL.CAP_D_min(4) 	= str2num(get(handles.Edit_DLmin_DOF4, 	'string'));
handles.MDL.CAP_D_min(5) 	= str2num(get(handles.Edit_DLmin_DOF5, 	'string'));
handles.MDL.CAP_D_min(6) 	= str2num(get(handles.Edit_DLmin_DOF6, 	'string'));

handles.MDL.CAP_D_max(1) 	= str2num(get(handles.Edit_DLmax_DOF1, 	'string'));
handles.MDL.CAP_D_max(2) 	= str2num(get(handles.Edit_DLmax_DOF2, 	'string'));
handles.MDL.CAP_D_max(3) 	= str2num(get(handles.Edit_DLmax_DOF3, 	'string'));
handles.MDL.CAP_D_max(4) 	= str2num(get(handles.Edit_DLmax_DOF4, 	'string'));
handles.MDL.CAP_D_max(5) 	= str2num(get(handles.Edit_DLmax_DOF5, 	'string'));
handles.MDL.CAP_D_max(6) 	= str2num(get(handles.Edit_DLmax_DOF6, 	'string'));

handles.MDL.TGT_D_inc(1) 	= str2num(get(handles.Edit_DLinc_DOF1, 	'string'));
handles.MDL.TGT_D_inc(2) 	= str2num(get(handles.Edit_DLinc_DOF2, 	'string'));
handles.MDL.TGT_D_inc(3) 	= str2num(get(handles.Edit_DLinc_DOF3, 	'string'));
handles.MDL.TGT_D_inc(4) 	= str2num(get(handles.Edit_DLinc_DOF4, 	'string'));
handles.MDL.TGT_D_inc(5) 	= str2num(get(handles.Edit_DLinc_DOF5, 	'string'));
handles.MDL.TGT_D_inc(6) 	= str2num(get(handles.Edit_DLinc_DOF6, 	'string'));

handles.MDL.CAP_F_min(1) 	= str2num(get(handles.Edit_FLmin_DOF1, 	'string'));
handles.MDL.CAP_F_min(2) 	= str2num(get(handles.Edit_FLmin_DOF2, 	'string'));
handles.MDL.CAP_F_min(3) 	= str2num(get(handles.Edit_FLmin_DOF3, 	'string'));
handles.MDL.CAP_F_min(4) 	= str2num(get(handles.Edit_FLmin_DOF4, 	'string'));
handles.MDL.CAP_F_min(5) 	= str2num(get(handles.Edit_FLmin_DOF5, 	'string'));
handles.MDL.CAP_F_min(6) 	= str2num(get(handles.Edit_FLmin_DOF6, 	'string'));

handles.MDL.CAP_F_max(1) 	= str2num(get(handles.Edit_FLmax_DOF1, 	'string'));
handles.MDL.CAP_F_max(2) 	= str2num(get(handles.Edit_FLmax_DOF2, 	'string'));
handles.MDL.CAP_F_max(3) 	= str2num(get(handles.Edit_FLmax_DOF3, 	'string'));
handles.MDL.CAP_F_max(4) 	= str2num(get(handles.Edit_FLmax_DOF4, 	'string'));
handles.MDL.CAP_F_max(5) 	= str2num(get(handles.Edit_FLmax_DOF5, 	'string'));
handles.MDL.CAP_F_max(6) 	= str2num(get(handles.Edit_FLmax_DOF6, 	'string'));                         	                                    	

handles.MDL.DispTolerance(1) 	= str2num(get(handles.Edit_Dtol_DOF1, 	'string'));
handles.MDL.DispTolerance(2) 	= str2num(get(handles.Edit_Dtol_DOF2, 	'string'));
handles.MDL.DispTolerance(3) 	= str2num(get(handles.Edit_Dtol_DOF3, 	'string'));
handles.MDL.DispTolerance(4) 	= str2num(get(handles.Edit_Dtol_DOF4, 	'string'));
handles.MDL.DispTolerance(5) 	= str2num(get(handles.Edit_Dtol_DOF5, 	'string'));
handles.MDL.DispTolerance(6) 	= str2num(get(handles.Edit_Dtol_DOF6, 	'string'));                         	                                    	

handles.MDL.DispIncMax(1) 	= str2num(get(handles.Edit_Dsub_DOF1, 	'string'));                         	                                    	
handles.MDL.DispIncMax(2) 	= str2num(get(handles.Edit_Dsub_DOF2, 	'string'));                         	                                    	
handles.MDL.DispIncMax(3) 	= str2num(get(handles.Edit_Dsub_DOF3, 	'string'));                         	                                    	
handles.MDL.DispIncMax(4) 	= str2num(get(handles.Edit_Dsub_DOF4, 	'string'));                         	                                    	
handles.MDL.DispIncMax(5) 	= str2num(get(handles.Edit_Dsub_DOF5, 	'string'));                         	                                    	
handles.MDL.DispIncMax(6) 	= str2num(get(handles.Edit_Dsub_DOF6, 	'string'));                         	                                    	

handles.MDL.MovingWinWidth 	= str2num(get(handles.Edit_Window_Size, 'string'));
% handles.MDL.NumSample 		= str2num(get(handles.Edit_Sample_Size, 'string'));

if     get(handles.RB_Source_Network, 'value') ==1 & get(handles.RB_Source_File, 'value') ==0 
	handles.MDL.InputSource = 2;
elseif get(handles.RB_Source_Network, 'value') ==0 & get(handles.RB_Source_File, 'value') ==1 
	handles.MDL.InputSource = 1;
end

% if     get(handles.RB_Disp_Ctrl, 'value') ==1 & get(handles.RB_Forc_Ctrl, 'value') ==0 
% 	handles.MDL.CtrlMode = 1;
% elseif get(handles.RB_Disp_Ctrl, 'value') ==0 & get(handles.RB_Forc_Ctrl, 'value') ==1 
% 	handles.MDL.CtrlMode = 2;
% end

% handles.MDL.FrcCtrlDOF 		= get(handles.PM_Frc_Ctrl_DOF,		'Value');
handles.MDL.ModelCoord 		= get(handles.PM_Model_Coord,		'Value') ;
handles.MDL.LBCBCoord 		= get(handles.PM_LBCB_Coord,		'Value') ;

handles.MDL.Axis_X1 		= get(handles.PM_Axis_X1,		'value');
handles.MDL.Axis_X2 		= get(handles.PM_Axis_X2,		'value');
handles.MDL.Axis_X3 		= get(handles.PM_Axis_X3,		'value');
handles.MDL.Axis_Y1 		= get(handles.PM_Axis_Y1,		'value');
handles.MDL.Axis_Y2 		= get(handles.PM_Axis_Y2,		'value');
handles.MDL.Axis_Y3 		= get(handles.PM_Axis_Y3,		'value');
% 
% if 	get(handles.RB_Elastic_Deformation_ON,'value') == 1
% 	handles.MDL.ItrElasticDeform	= 1;
% else                                        
% 	handles.MDL.ItrElasticDeform	= 0;
% end
% if 	get(handles.RB_Disp_Refine_ON,'value') == 1
% 	handles.MDL.StepReduction	= 1;
% else                                        
% 	handles.MDL.StepReduction	= 0;
% end

% if 	get(handles.RB_Disp_Mesurement_External,'value') == 1
% 	handles.MDL.DispMesurementSource	= 1;
% else                                        
% 	handles.MDL.DispMesurementSource	= 0;
% end

% if 	get(handles.CB_Noise_Compensation,'value') == 1
% 	handles.MDL.NoiseCompensation	= 1;
% else                                        
% 	handles.MDL.NoiseCompensation	= 0;
% end
