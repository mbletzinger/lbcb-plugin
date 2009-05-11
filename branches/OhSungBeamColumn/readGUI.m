function handles = readGUI(handles)

% Input source ---------------------------------------------------------------------------------
if     get(handles.RB_Source_Network, 'value') ==1 & get(handles.RB_Source_File, 'value') ==0 
	handles.MDL.InputSource = 2;
elseif get(handles.RB_Source_Network, 'value') ==0 & get(handles.RB_Source_File, 'value') ==1 
	handles.MDL.InputSource = 1;
end
handles.MDL.InputPort 		= str2num(get(handles.Edit_PortNo,  	'String'));
handles.MDL.InputFile 		= get(handles.Edit_File_Path,       	'String');
%%%%%
% Modified by Sung Jig Kim, 05/02/2009
handles.MDL.NetworkWaitTime = str2num(get(handles.Edit_LBCB_NetworkWaitTime,  	'String'));

% LBCB -----------------------------------------------------------------------------------------
handles.MDL.IP_1 		= get(handles.Edit_LBCB_IP_1,	    	'String');
handles.MDL.Port_1 		= str2num(get(handles.Edit_LBCB_Port_1,	'String'));
% handles.MDL.IP_2 		= get(handles.Edit_LBCB_IP_2,	    	'String');
% handles.MDL.Port_2 		= str2num(get(handles.Edit_LBCB_Port_2,	'String'));

% Disp. Iteration ------------------------------------------------------------------------------
if 	get(handles.RB_Elastic_Deformation_ON,'value') == 1
	handles.MDL.ItrElasticDeform	= 1;
else                                        
	handles.MDL.ItrElasticDeform	= 0;
end
handles.MDL.maxitr              = str2num(get(handles.EB_Max_Itr,       'string'));
handles.MDL.DispTolerance( 1) 	= str2num(get(handles.Edit_Dtol_DOF11, 	'string'));
handles.MDL.DispTolerance( 2) 	= str2num(get(handles.Edit_Dtol_DOF12, 	'string'));
handles.MDL.DispTolerance( 3) 	= str2num(get(handles.Edit_Dtol_DOF13, 	'string'));
handles.MDL.DispTolerance( 4) 	= str2num(get(handles.Edit_Dtol_DOF14, 	'string'));
handles.MDL.DispTolerance( 5) 	= str2num(get(handles.Edit_Dtol_DOF15, 	'string'));
handles.MDL.DispTolerance( 6) 	= str2num(get(handles.Edit_Dtol_DOF16, 	'string'));                         	                                    	
handles.MDL.DispTolerance( 7) 	= str2num(get(handles.Edit_Dtol_DOF21, 	'string'));
handles.MDL.DispTolerance( 8) 	= str2num(get(handles.Edit_Dtol_DOF22, 	'string'));
handles.MDL.DispTolerance( 9) 	= str2num(get(handles.Edit_Dtol_DOF23, 	'string'));
handles.MDL.DispTolerance(10) 	= str2num(get(handles.Edit_Dtol_DOF24, 	'string'));
handles.MDL.DispTolerance(11) 	= str2num(get(handles.Edit_Dtol_DOF25, 	'string'));
handles.MDL.DispTolerance(12) 	= str2num(get(handles.Edit_Dtol_DOF26, 	'string'));  

% Step Reduction -------------------------------------------------------------------------------
if 	get(handles.RB_Disp_Refine_ON,'value') == 1
	handles.MDL.StepReduction	= 1;
else                                        
	handles.MDL.StepReduction	= 0;
end
handles.MDL.DispIncMax( 1) 	= str2num(get(handles.Edit_Dsub_DOF11, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 2) 	= str2num(get(handles.Edit_Dsub_DOF12, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 3) 	= str2num(get(handles.Edit_Dsub_DOF13, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 4) 	= str2num(get(handles.Edit_Dsub_DOF14, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 5) 	= str2num(get(handles.Edit_Dsub_DOF15, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 6) 	= str2num(get(handles.Edit_Dsub_DOF16, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 7) 	= str2num(get(handles.Edit_Dsub_DOF21, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 8) 	= str2num(get(handles.Edit_Dsub_DOF22, 	'string'));                         	                                    	
handles.MDL.DispIncMax( 9) 	= str2num(get(handles.Edit_Dsub_DOF23, 	'string'));                         	                                    	
handles.MDL.DispIncMax(10) 	= str2num(get(handles.Edit_Dsub_DOF24, 	'string'));                         	                                    	
handles.MDL.DispIncMax(11) 	= str2num(get(handles.Edit_Dsub_DOF25, 	'string'));                         	                                    	
handles.MDL.DispIncMax(12) 	= str2num(get(handles.Edit_Dsub_DOF26, 	'string'));                         	                                    	
                       

% Target Disp. Limit Check, LBCB1 ---------------------------------------------------------------------
handles.MDL.CheckLimit_Disp1  	= get(handles.CB_Disp_Limit1, 'value');      
handles.MDL.CheckLimit_DispInc1 = get(handles.CB_Disp_Inc1,   'value');      
handles.MDL.CheckLimit_Forc1  	= get(handles.CB_Forc_Limit1, 'value');      
handles.MDL.CheckLimit_Disp2  	= get(handles.CB_Disp_Limit2, 'value');      
handles.MDL.CheckLimit_DispInc2 = get(handles.CB_Disp_Inc2,   'value');      
handles.MDL.CheckLimit_Forc2  	= get(handles.CB_Forc_Limit2, 'value');      
                                                                 	
handles.MDL.CAP_D_min( 1) 	= str2num(get(handles.Edit_DLmin_DOF11, 	'string'));
handles.MDL.CAP_D_min( 2) 	= str2num(get(handles.Edit_DLmin_DOF12, 	'string'));
handles.MDL.CAP_D_min( 3) 	= str2num(get(handles.Edit_DLmin_DOF13, 	'string'));
handles.MDL.CAP_D_min( 4) 	= str2num(get(handles.Edit_DLmin_DOF14, 	'string'));
handles.MDL.CAP_D_min( 5) 	= str2num(get(handles.Edit_DLmin_DOF15, 	'string'));
handles.MDL.CAP_D_min( 6) 	= str2num(get(handles.Edit_DLmin_DOF16, 	'string'));
handles.MDL.CAP_D_min( 7) 	= str2num(get(handles.Edit_DLmin_DOF21, 	'string'));
handles.MDL.CAP_D_min( 8) 	= str2num(get(handles.Edit_DLmin_DOF22, 	'string'));
handles.MDL.CAP_D_min( 9) 	= str2num(get(handles.Edit_DLmin_DOF23, 	'string'));
handles.MDL.CAP_D_min(10) 	= str2num(get(handles.Edit_DLmin_DOF24, 	'string'));
handles.MDL.CAP_D_min(11) 	= str2num(get(handles.Edit_DLmin_DOF25, 	'string'));
handles.MDL.CAP_D_min(12) 	= str2num(get(handles.Edit_DLmin_DOF26, 	'string'));

handles.MDL.CAP_D_max( 1) 	= str2num(get(handles.Edit_DLmax_DOF11, 	'string'));
handles.MDL.CAP_D_max( 2) 	= str2num(get(handles.Edit_DLmax_DOF12, 	'string'));
handles.MDL.CAP_D_max( 3) 	= str2num(get(handles.Edit_DLmax_DOF13, 	'string'));
handles.MDL.CAP_D_max( 4) 	= str2num(get(handles.Edit_DLmax_DOF14, 	'string'));
handles.MDL.CAP_D_max( 5) 	= str2num(get(handles.Edit_DLmax_DOF15, 	'string'));
handles.MDL.CAP_D_max( 6) 	= str2num(get(handles.Edit_DLmax_DOF16, 	'string'));
handles.MDL.CAP_D_max( 7) 	= str2num(get(handles.Edit_DLmax_DOF21, 	'string'));
handles.MDL.CAP_D_max( 8) 	= str2num(get(handles.Edit_DLmax_DOF22, 	'string'));
handles.MDL.CAP_D_max( 9) 	= str2num(get(handles.Edit_DLmax_DOF23, 	'string'));
handles.MDL.CAP_D_max(10) 	= str2num(get(handles.Edit_DLmax_DOF24, 	'string'));
handles.MDL.CAP_D_max(11) 	= str2num(get(handles.Edit_DLmax_DOF25, 	'string'));
handles.MDL.CAP_D_max(12) 	= str2num(get(handles.Edit_DLmax_DOF26, 	'string'));

handles.MDL.TGT_D_inc( 1) 	= str2num(get(handles.Edit_DLinc_DOF11, 	'string'));
handles.MDL.TGT_D_inc( 2) 	= str2num(get(handles.Edit_DLinc_DOF12, 	'string'));
handles.MDL.TGT_D_inc( 3) 	= str2num(get(handles.Edit_DLinc_DOF13, 	'string'));
handles.MDL.TGT_D_inc( 4) 	= str2num(get(handles.Edit_DLinc_DOF14, 	'string'));
handles.MDL.TGT_D_inc( 5) 	= str2num(get(handles.Edit_DLinc_DOF15, 	'string'));
handles.MDL.TGT_D_inc( 6) 	= str2num(get(handles.Edit_DLinc_DOF16, 	'string'));
handles.MDL.TGT_D_inc( 7) 	= str2num(get(handles.Edit_DLinc_DOF21, 	'string'));
handles.MDL.TGT_D_inc( 8) 	= str2num(get(handles.Edit_DLinc_DOF22, 	'string'));
handles.MDL.TGT_D_inc( 9) 	= str2num(get(handles.Edit_DLinc_DOF23, 	'string'));
handles.MDL.TGT_D_inc(10) 	= str2num(get(handles.Edit_DLinc_DOF24, 	'string'));
handles.MDL.TGT_D_inc(11) 	= str2num(get(handles.Edit_DLinc_DOF25, 	'string'));
handles.MDL.TGT_D_inc(12) 	= str2num(get(handles.Edit_DLinc_DOF26, 	'string'));
   
handles.MDL.CAP_F_min( 1) 	= str2num(get(handles.Edit_FLmin_DOF11, 	'string'));
handles.MDL.CAP_F_min( 2) 	= str2num(get(handles.Edit_FLmin_DOF12, 	'string'));
handles.MDL.CAP_F_min( 3) 	= str2num(get(handles.Edit_FLmin_DOF13, 	'string'));
handles.MDL.CAP_F_min( 4) 	= str2num(get(handles.Edit_FLmin_DOF14, 	'string'));
handles.MDL.CAP_F_min( 5) 	= str2num(get(handles.Edit_FLmin_DOF15, 	'string'));
handles.MDL.CAP_F_min( 6) 	= str2num(get(handles.Edit_FLmin_DOF16, 	'string'));
handles.MDL.CAP_F_min( 7) 	= str2num(get(handles.Edit_FLmin_DOF21, 	'string'));
handles.MDL.CAP_F_min( 8) 	= str2num(get(handles.Edit_FLmin_DOF22, 	'string'));
handles.MDL.CAP_F_min( 9) 	= str2num(get(handles.Edit_FLmin_DOF23, 	'string'));
handles.MDL.CAP_F_min(10) 	= str2num(get(handles.Edit_FLmin_DOF24, 	'string'));
handles.MDL.CAP_F_min(11) 	= str2num(get(handles.Edit_FLmin_DOF25, 	'string'));
handles.MDL.CAP_F_min(12) 	= str2num(get(handles.Edit_FLmin_DOF26, 	'string'));
    
                                                                 
handles.MDL.CAP_F_max( 1) 	= str2num(get(handles.Edit_FLmax_DOF11, 	'string'));
handles.MDL.CAP_F_max( 2) 	= str2num(get(handles.Edit_FLmax_DOF12, 	'string'));
handles.MDL.CAP_F_max( 3) 	= str2num(get(handles.Edit_FLmax_DOF13, 	'string'));
handles.MDL.CAP_F_max( 4) 	= str2num(get(handles.Edit_FLmax_DOF14, 	'string'));
handles.MDL.CAP_F_max( 5) 	= str2num(get(handles.Edit_FLmax_DOF15, 	'string'));
handles.MDL.CAP_F_max( 6) 	= str2num(get(handles.Edit_FLmax_DOF16, 	'string'));                                                                  
handles.MDL.CAP_F_max( 7) 	= str2num(get(handles.Edit_FLmax_DOF21, 	'string'));
handles.MDL.CAP_F_max( 8) 	= str2num(get(handles.Edit_FLmax_DOF22, 	'string'));
handles.MDL.CAP_F_max( 9) 	= str2num(get(handles.Edit_FLmax_DOF23, 	'string'));
handles.MDL.CAP_F_max(10) 	= str2num(get(handles.Edit_FLmax_DOF24, 	'string'));
handles.MDL.CAP_F_max(11) 	= str2num(get(handles.Edit_FLmax_DOF25, 	'string'));
handles.MDL.CAP_F_max(12) 	= str2num(get(handles.Edit_FLmax_DOF26, 	'string'));                         	                                    	
                          
                                               
                          
% Displacement measurement source ---------------------------------------------------------------------                          
if 	get(handles.RB_Disp_Mesurement_External,'value') == 1
	handles.MDL.DispMesurementSource	= 1;
else                                        
	handles.MDL.DispMesurementSource	= 0;
end         
    
                          
% Averaging measurements ------------------------------------------------------------------------------                          
if 	get(handles.CB_Noise_Compensation,'value') == 1
	handles.MDL.NoiseCompensation	= 1;
else                                        
	handles.MDL.NoiseCompensation	= 0;
end


% Monitoring window -----------------------------------------------------------------------------------                          
handles.MDL.Axis_X1 		= get(handles.PM_Axis_X1,		'value');
handles.MDL.Axis_X2 		= get(handles.PM_Axis_X2,		'value');
handles.MDL.Axis_X3 		= get(handles.PM_Axis_X3,		'value');
handles.MDL.Axis_X4 		= get(handles.PM_Axis_X4,		'value');

handles.MDL.Axis_Y1 		= get(handles.PM_Axis_Y1,		'value');
handles.MDL.Axis_Y2 		= get(handles.PM_Axis_Y2,		'value');
handles.MDL.Axis_Y3 		= get(handles.PM_Axis_Y3,		'value');
handles.MDL.Axis_Y4 		= get(handles.PM_Axis_Y4,		'value');

handles.MDL.MovingWinWidth 	= str2num(get(handles.Edit_Window_Size, 'string'));
handles.MDL.NumSample 		= str2num(get(handles.Edit_Sample_Size, 'string'));

% AUX Module -----------------------------------------------------------------------------------------

if handles.Num_AuxModules >= 1
	for i=1:handles.Num_AuxModules
		handles.AUX(i).NetworkWaitTime = str2num(get(handles.Edit_LBCB_NetworkWaitTime,  	'String'));
	end
end
