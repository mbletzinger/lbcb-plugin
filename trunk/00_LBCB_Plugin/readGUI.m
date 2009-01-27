function handles = readGUI(handles)

try,
	ConvertStatus=[];
	
	% AUX module
	AUX_Initialized=get(handles.AUXModule_Connect, 'UserData'); 
	for i=1:length(AUX_Initialized)
		handles.AUX(i).Initialized=AUX_Initialized(i);
	end
		
	handles.MDL.InputPort 		= str2num(get(handles.Edit_PortNo,  	'String'));
	handles.MDL.InputFilePath   = get(handles.PM_FileInput_Select, 'UserData');
	InputNum=get(handles.PM_FileInput_Select,'value')-1;
	if InputNum~=0
		handles.MDL.InputFile 		= handles.MDL.InputFilePath{InputNum};
	end
	
	%handles.MDL.InputFile 		= get(handles.Edit_File_Path,       	'String');
	handles.MDL.IP 			= get(handles.Edit_LBCB_IP,	    	'String');
	handles.MDL.Port 		= str2num(get(handles.Edit_LBCB_Port,	'String'));
	
	[handles.MDL.K_vert_ini, 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_K_low,   	'string'), ConvertStatus);
	[handles.MDL.secK_eval_itr, ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Iteration_Ksec,'string'), ConvertStatus);
	[handles.MDL.secK_factor, 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_K_factor,	'string'), ConvertStatus);
	[handles.MDL.max_itr, 		ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Max_Itr, 	'string'), ConvertStatus);
	
	[handles.MDL.ScaleF(1),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Disp_SF, 	'string'), ConvertStatus);
	[handles.MDL.ScaleF(2),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Rotation_SF,	'string'), ConvertStatus);
	[handles.MDL.ScaleF(3),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Forc_SF, 	'string'), ConvertStatus);
	[handles.MDL.ScaleF(4),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Moment_SF,	'string'), ConvertStatus);
	%
	handles.MDL.DispScale(1:3)=handles.MDL.ScaleF(1);
	handles.MDL.DispScale(4:6)=handles.MDL.ScaleF(2);
	handles.MDL.ForcScale(1:3)=handles.MDL.ScaleF(3);
	handles.MDL.ForcScale(4:6)=handles.MDL.ScaleF(4);
	
%	handles.MDL.UpdateMonitor	= get(handles.CB_UpdateMonitor, 'value');
	
	handles.MDL.CheckLimit_Disp  	= get(handles.CB_Disp_Limit, 'value');      
	handles.MDL.CheckLimit_DispInc  = get(handles.CB_Disp_Inc,   'value');      
	handles.MDL.CheckLimit_Forc  	= get(handles.CB_Forc_Limit, 'value');      
	                                                                    	
	[handles.MDL.CAP_D_min(1), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_min(2), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_min(3), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_min(4), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_min(5), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_min(6), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmin_DOF6, 	'string'), ConvertStatus);
	
	[handles.MDL.CAP_D_max(1), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_max(2), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_max(3), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_max(4), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_max(5), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.CAP_D_max(6), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLmax_DOF6, 	'string'), ConvertStatus);
	
	[handles.MDL.TGT_D_inc(1), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.TGT_D_inc(2), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.TGT_D_inc(3), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.TGT_D_inc(4), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.TGT_D_inc(5), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.TGT_D_inc(6), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_DLinc_DOF6, 	'string'), ConvertStatus);
	
	[handles.MDL.CAP_F_min(1), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_min(2), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_min(3), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_min(4), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_min(5), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_min(6), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmin_DOF6, 	'string'), ConvertStatus);
	
	[handles.MDL.CAP_F_max(1), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_max(2), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_max(3), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_max(4), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_max(5), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.CAP_F_max(6), 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_FLmax_DOF6, 	'string'), ConvertStatus);                         	                                    	
	
	[handles.MDL.DispTolerance(1),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF1, 	'string'), ConvertStatus);
	[handles.MDL.DispTolerance(2),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF2, 	'string'), ConvertStatus);
	[handles.MDL.DispTolerance(3),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF3, 	'string'), ConvertStatus);
	[handles.MDL.DispTolerance(4),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF4, 	'string'), ConvertStatus);
	[handles.MDL.DispTolerance(5),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF5, 	'string'), ConvertStatus);
	[handles.MDL.DispTolerance(6),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dtol_DOF6, 	'string'), ConvertStatus);                         	                                    	
	%tt=handles.MDL.DispTolerance;
	%for i=1:length(tt)
%		disp(sprintf ('%12.5e',tt(i)));
%	end
	[handles.MDL.DispIncMax(1),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF1, 	'string'), ConvertStatus);                         	                                    	
	[handles.MDL.DispIncMax(2),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF2, 	'string'), ConvertStatus);                         	                                    	
	[handles.MDL.DispIncMax(3),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF3, 	'string'), ConvertStatus);                         	                                    	
	[handles.MDL.DispIncMax(4),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF4, 	'string'), ConvertStatus);                         	                                    	
	[handles.MDL.DispIncMax(5),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF5, 	'string'), ConvertStatus);                         	                                    	
	[handles.MDL.DispIncMax(6),	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Dsub_DOF6, 	'string'), ConvertStatus);                         	                                    	
	
	[handles.MDL.MovingWinWidth 	ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Window_Size, 'string'), ConvertStatus);
	[handles.MDL.NumSample 		ConvertStatus] = readGUI_str2num_evaluate(get(handles.Edit_Sample_Size, 'string'), ConvertStatus);
	
	if     get(handles.RB_Source_Network, 'value') ==1 & get(handles.RB_Source_File, 'value') ==0 
		handles.MDL.InputSource = 2;
	elseif get(handles.RB_Source_Network, 'value') ==0 & get(handles.RB_Source_File, 'value') ==1 
		handles.MDL.InputSource = 1;
	end
	
	if     get(handles.RB_Disp_Ctrl, 'value') ==1 & get(handles.RB_Forc_Ctrl, 'value') ==0 & get(handles.RB_MixedControl_Static, 'value')==0
		handles.MDL.CtrlMode = 1;
	elseif get(handles.RB_Disp_Ctrl, 'value') ==0 & get(handles.RB_Forc_Ctrl, 'value') ==1 & get(handles.RB_MixedControl_Static, 'value')==0
		handles.MDL.CtrlMode = 2;
	elseif get(handles.RB_Disp_Ctrl, 'value') ==0 & get(handles.RB_Forc_Ctrl, 'value') ==0 & get(handles.RB_MixedControl_Static, 'value')==1
		handles.MDL.CtrlMode = 3;
	end
	
	handles.MDL.FrcCtrlDOF 	= get(handles.PM_Frc_Ctrl_DOF,		'Value');
	
	if handles.MDL.CtrlMode==2
		handles.MDL.LBCB_FrcCtrlDOF=zeros(6,1);		
		handles.MDL.LBCB_FrcCtrlDOF(handles.MDL.FrcCtrlDOF)=1;
		
	elseif handles.MDL.CtrlMode==3
		handles.MDL.LBCB_FrcCtrlDOF(1) = get(handles.CB_MixedCtrl_Fx, 'value');
		handles.MDL.LBCB_FrcCtrlDOF(2) = get(handles.CB_MixedCtrl_Fy, 'value');
		handles.MDL.LBCB_FrcCtrlDOF(3) = get(handles.CB_MixedCtrl_Fz, 'value');
		handles.MDL.LBCB_FrcCtrlDOF(4) = get(handles.CB_MixedCtrl_Mx, 'value');
		handles.MDL.LBCB_FrcCtrlDOF(5) = get(handles.CB_MixedCtrl_My, 'value');
		handles.MDL.LBCB_FrcCtrlDOF(6) = get(handles.CB_MixedCtrl_Mz, 'value');
		% Model Force control DOF
		
	end	
	handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
	
	handles.MDL.ModelCoord 		= get(handles.PM_Model_Coord,		'Value') ;
	handles.MDL.LBCBCoord 		= get(handles.PM_LBCB_Coord,		'Value') ;
	
	handles.MDL.Axis_X1 		= get(handles.PM_Axis_X1,		'value');
	handles.MDL.Axis_X2 		= get(handles.PM_Axis_X2,		'value');
	handles.MDL.Axis_X3 		= get(handles.PM_Axis_X3,		'value');
	handles.MDL.Axis_Y1 		= get(handles.PM_Axis_Y1,		'value');
	handles.MDL.Axis_Y2 		= get(handles.PM_Axis_Y2,		'value');
	handles.MDL.Axis_Y3 		= get(handles.PM_Axis_Y3,		'value');
	
	if 	get(handles.RB_Elastic_Deformation_ON,'value') == 1
		handles.MDL.ItrElasticDeform	= 1;
	else                                        
		handles.MDL.ItrElasticDeform	= 0;
	end
	if 	get(handles.RB_Disp_Refine_ON,'value') == 1
		handles.MDL.StepReduction	= 1;
	else                                        
		handles.MDL.StepReduction	= 0;
	end
	
	if 	get(handles.RB_Disp_Mesurement_External,'value') == 1
		handles.MDL.DispMesurementSource	= 1;
	else                                        
		handles.MDL.DispMesurementSource	= 0;
	end
	
	if 	get(handles.CB_Noise_Compensation,'value') == 1
		handles.MDL.NoiseCompensation	= 1;
	else                                        
		handles.MDL.NoiseCompensation	= 0;
	end
	
	%______________________________________________________________
	%
	% User Input Option
	%______________________________________________________________
	
	if get(handles.UserInputOption_On, 'value')
		[handles.MDL.LBCB_Target_1(1), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF1,'string'), ConvertStatus);
		[handles.MDL.LBCB_Target_1(2), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF2,'string'), ConvertStatus);
		[handles.MDL.LBCB_Target_1(3), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF3,'string'), ConvertStatus);
		[handles.MDL.LBCB_Target_1(4), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF4,'string'), ConvertStatus);
		[handles.MDL.LBCB_Target_1(5), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF5,'string'), ConvertStatus);
		[handles.MDL.LBCB_Target_1(6), ConvertStatus] = readGUI_str2num_evaluate(get(handles.User_Cmd_DOF6,'string'), ConvertStatus);
	end
	
	
	% save tolerance in displacement control and max displ increment in step reduction. Also, Input file
	SaveFileName=sprintf('DispTol_MaxDispIncr_%s.txt',handles.DataSave_TestDate_Str);  SaveData=[];
	SaveData=[handles.MDL.DispTolerance ; handles.MDL.DispIncMax];
	% save data
	SaveSimulationData (SaveFileName,handles.MDL.StepNos,SaveData,2,handles.MDL.InputSource,handles.MDL.InputFile);

	% Check Error

	if all(ConvertStatus)==0
		handles.error_check	=1;
		disp (sprintf('*** Error at str2num, ConvertStatus Line: %d', min(find(ConvertStatus==0)) ));
	else
		handles.error_check	=0;
	end
	
	if get(handles.RB_Source_File, 'value') & get(handles.PM_FileInput_Select,'value')==1
		handles.error_check	=1;
		errordlg('One input file should be selected!','Data Error');
	end
	
catch,
	err_check=lasterror;
	err_str=err_check.stack(1,1);
	disp (sprintf ('*** Error at file: %s, line: %d ',err_str.name,err_str.line));
	disp (sprintf ('*** Message: %s',err_check.message));
	handles.error_check=1;
end

if handles.error_check
	set(handles.PB_Pause, 'value', 0);  
end
