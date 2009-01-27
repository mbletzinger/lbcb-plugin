function UpdateMonitorPanel (handles, varargin)

% =====================================================================================================================
% This function update the current data to monitor panel in GUI.
%
%   str     	: Output string
%   varargin{1}	: 1 for data, 2 for network log, 3 for screen
%	varargin{2} : level for screen log
%
% Last updated  12/20/2007, Sung Jig Kim
% =====================================================================================================================

switch varargin{1}
	case 1  % Update Model Target 
		tmp_disp_str=cell(6,1);     tmp_forc_str=cell(6,1);
		if get(handles.RB_Monitor_Coord_LBCB,  'value')
			Frc_CtrlDOFs=handles.MDL.LBCB_FrcCtrlDOF;
			T_Disp = handles.MDL.TransM * (handles.MDL.DispScale.* handles.MDL.Model_T_Displ);
			T_Forc = handles.MDL.TransM * (handles.MDL.ForcScale.* handles.MDL.Model_T_Force); 
		else
			Frc_CtrlDOFs=handles.MDL.Model_FrcCtrlDOF;
			T_Disp = handles.MDL.Model_T_Displ;
			T_Forc = handles.MDL.Model_T_Force; 
		end     
		
		for i=1:6
			% Model
			if Frc_CtrlDOFs(i)
				tmp_disp_str{i}='     -     ';
				tmp_forc_str{i}=sprintf('%+12.3f',  T_Forc(i));
			else
				tmp_disp_str{i}=sprintf('%+12.7f',  T_Disp(i));
				tmp_forc_str{i}='     -     ';
			end
		end
		set(handles.TXT_Disp_T_Model, 'string', tmp_disp_str);
		set(handles.TXT_Forc_T_Model, 'string', tmp_forc_str);

	case 2  % Update LBCB Target

		tmp_disp_str_LBCB=cell(6,1);tmp_forc_str_LBCB=cell(6,1);
		for i=1:6
			if handles.MDL.LBCB_FrcCtrlDOF(i)
				tmp_disp_str_LBCB{i}='     -     ';
				tmp_forc_str_LBCB{i}=sprintf('%+12.3f',  handles.MDL.LBCB_T_Force(i));
			else
				tmp_disp_str_LBCB{i}=sprintf('%+12.7f',  handles.MDL.LBCB_T_Displ(i));
				tmp_forc_str_LBCB{i}='     -     ';
			end
		end
		set(handles.TXT_Disp_T_LBCB, 'string', tmp_disp_str_LBCB);
		set(handles.TXT_Forc_T_LBCB, 'string', tmp_forc_str_LBCB);

	case 3  % Measured Data and Error in Model Coordinate System
		%Model Space
		if get(handles.RB_Monitor_Coord_Model, 'value') % Convert to Model Space
			T_Disp = handles.MDL.Model_T_Displ;
			T_Forc = handles.MDL.Model_T_Force;
			M_Disp = inv(handles.MDL.TransM)*((handles.MDL.DispScale.^-1).*handles.MDL.M_Disp);
			M_Forc = inv(handles.MDL.TransM)*((handles.MDL.ForcScale.^-1).*handles.MDL.M_Forc);
			ForceCtlDOFs = handles.MDL.Model_FrcCtrlDOF;
			Disp_Toler = abs(inv(handles.MDL.TransM)*((handles.MDL.DispScale.^-1).*handles.MDL.DispTolerance));
		else % Convert to LBCB Space
			T_Disp = handles.MDL.TransM * (handles.MDL.DispScale.* handles.MDL.Model_T_Displ);
			T_Forc = handles.MDL.TransM * (handles.MDL.ForcScale.* handles.MDL.Model_T_Force); 
			M_Disp = handles.MDL.M_Disp;
			M_Forc = handles.MDL.M_Forc;
			ForceCtlDOFs = handles.MDL.LBCB_FrcCtrlDOF;	
			Disp_Toler = abs(handles.MDL.DispTolerance);	
		end
		DispError = T_Disp-M_Disp;  ForcError = T_Forc-M_Forc;
		tmp_disp_err=cell(6,1);     tmp_forc_err=cell(6,1);
 		for i=1:6
			if ForceCtlDOFs(i)
				tmp_disp_err{i}='     -     ';
				tmp_forc_err{i}=sprintf('%+12.6f',  ForcError(i));
			else
				tmp_disp_err{i}=sprintf('%+12.9f',  DispError(i));
				tmp_forc_err{i}='     -     ';
			end
		end
		Tmp_STR_1=cell(6,1); Tmp_STR_2=cell(6,1); 
		for i=1:6
			Tmp_STR_1{i}=sprintf('%+12.7f',M_Disp(i));
			Tmp_STR_2{i}=sprintf('%+12.3f',M_Forc(i));
		end
		set(handles.TXT_Disp_M_Model,    'string', Tmp_STR_1);
		set(handles.TXT_Forc_M_Model,    'string', Tmp_STR_2);
		set(handles.TXT_Force_Model_Error,    'string', tmp_forc_err);

		set(handles.TXT_Disp_Model_Error_Dx,'string', tmp_disp_err{1});
		if abs(DispError(1)) > Disp_Toler(1)
			set(handles.TXT_Disp_Model_Error_Dx,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Dx,'ForegroundColor', [0 0 0]);
		end
	
		set(handles.TXT_Disp_Model_Error_Dy,'string', tmp_disp_err{2});
		if abs(DispError(2)) > Disp_Toler(2)
			set(handles.TXT_Disp_Model_Error_Dy,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Dy,'ForegroundColor', [0 0 0]);
		end

		set(handles.TXT_Disp_Model_Error_Dz,'string', tmp_disp_err{3});
		if abs(DispError(3)) > Disp_Toler(3)
			set(handles.TXT_Disp_Model_Error_Dz,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Dz,'ForegroundColor', [0 0 0]);
		end
		
		set(handles.TXT_Disp_Model_Error_Rx,'string', tmp_disp_err{4});
		if abs(DispError(4)) > Disp_Toler(4)
			set(handles.TXT_Disp_Model_Error_Rx,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Rx,'ForegroundColor', [0 0 0]);
		end
		
		set(handles.TXT_Disp_Model_Error_Ry,'string', tmp_disp_err{5});
		if abs(DispError(5)) > Disp_Toler(5)
			set(handles.TXT_Disp_Model_Error_Ry,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Ry,'ForegroundColor', [0 0 0]);
		end
		
		set(handles.TXT_Disp_Model_Error_Rz,'string', tmp_disp_err{6});
		if abs(DispError(6)) > Disp_Toler(6)
			set(handles.TXT_Disp_Model_Error_Rz,'ForegroundColor', [1 0 0]);
		else
			set(handles.TXT_Disp_Model_Error_Rz,'ForegroundColor', [0 0 0]);
		end
		
	case 4  % Measured Data and Error in LBCB Coordinate System	
		% For the previous target
		% tmp_disp_str_LBCB=cell(6,1);tmp_forc_str_LBCB=cell(6,1);
		% for i=1:6
		% 	if handles.MDL.LBCB_FrcCtrlDOF(i)
		% 		tmp_disp_str_LBCB{i}='     -     ';
		% 		tmp_forc_str_LBCB{i}=sprintf('%+12.3f',  handles.MDL.LBCB_T_Force(i));
		% 	else
		% 		tmp_disp_str_LBCB{i}=sprintf('%+12.7f',  handles.MDL.LBCB_T_Displ(i));
		% 		tmp_forc_str_LBCB{i}='     -     ';
		% 	end
		% end
		% set(handles.TXT_Disp_T_LBCB, 'string', tmp_disp_str_LBCB);
		% set(handles.TXT_Forc_T_LBCB, 'string', tmp_forc_str_LBCB);
					
		% Measured Data
		set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.7f\n', handles.MDL.LBCB_MDispl));
		set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.3f\n', handles.MDL.M_Forc));
	
		LBCB_DispError = handles.MDL.LBCB_T_Displ - handles.MDL.LBCB_MDispl;
		LBCB_ForcError = handles.MDL.LBCB_T_Force - handles.MDL.M_Forc;
		tmp_disp_err_LBCB=cell(6,1);tmp_forc_err_LBCB=cell(6,1);
		for i=1:6
			if handles.MDL.LBCB_FrcCtrlDOF(i)
				tmp_disp_err_LBCB{i}='     -     ';
				tmp_forc_err_LBCB{i}=sprintf('%+12.6f',  LBCB_ForcError(i));
			else
				tmp_disp_err_LBCB{i}=sprintf('%+12.9f',  LBCB_DispError(i));
				tmp_forc_err_LBCB{i}='     -     ';
			end
		end
		set(handles.TXT_Disp_M_LBCB_Error, 'string', tmp_disp_err_LBCB);
		set(handles.TXT_Forc_M_LBCB_Error, 'string', tmp_forc_err_LBCB);
	
	case 100  % Update Panel before starting simulation.
		% Model Coordinate System   
		FDCtrlDoF=ones(6,1);
		if get(handles.RB_Monitor_Coord_Model, 'value')
			CTRL_DOF=handles.MDL.Model_FrcCtrlDOF;
		else
			CTRL_DOF=handles.MDL.LBCB_FrcCtrlDOF;
		end
		% Displacement
		FDCtrlDoF = CTRL_DOF==0; format_str = '%+12.7f';	
		TXT_StrPanel={handles.TXT_Disp_T_Model}; hndl={format_str,1,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Disp_M_Model}; hndl={format_str,1,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Disp_Model_Error_Dx, handles.TXT_Disp_Model_Error_Dy, handles.TXT_Disp_Model_Error_Dz,...
		              handles.TXT_Disp_Model_Error_Rx, handles.TXT_Disp_Model_Error_Ry, handles.TXT_Disp_Model_Error_Rz}; 
		format_str = '%+12.9f'; hndl={format_str,1,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		% Force
		FDCtrlDoF = CTRL_DOF==1; format_str = '%+12.3f';	
		TXT_StrPanel={handles.TXT_Forc_T_Model}; hndl={format_str,1,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Forc_M_Model}; hndl={format_str,1,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
	 	format_str = '%+12.6f';
		TXT_StrPanel={handles.TXT_Force_Model_Error}; hndl={format_str,1,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		% LBCB Coordinate System
		CTRL_DOF=handles.MDL.LBCB_FrcCtrlDOF;
		% Displacement
		FDCtrlDoF = CTRL_DOF==0; format_str = '%+12.7f';	
		%TXT_StrPanel={handles.TXT_Disp_Next_T_LBCB}; hndl={format_str,2,FDCtrlDoF,1};
		%UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Disp_T_LBCB}; hndl={format_str,2,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Disp_M_LBCB}; hndl={format_str,2,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Disp_M_LBCB_Error}; 
		format_str = '%+12.9f'; hndl={format_str,2,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		% Force
		FDCtrlDoF = CTRL_DOF==1; format_str = '%+12.3f';	
		%TXT_StrPanel={handles.TXT_Forc_Next_T_LBCB}; hndl={format_str,2,FDCtrlDoF,1};
		%UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Forc_T_LBCB}; hndl={format_str,2,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
		TXT_StrPanel={handles.TXT_Forc_M_LBCB}; hndl={format_str,2,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
	 	format_str = '%+12.6f';
		TXT_StrPanel={handles.TXT_Forc_M_LBCB_Error}; hndl={format_str,2,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 1);
		
	case 101   % Model Coordinate System in GUI
		Transform = varargin{2};CTRL_DOF=varargin{3};FDCtrlDoF=ones(6,1);
		% Change String
		% Displacement
		FDCtrlDoF = CTRL_DOF==0; format_str = '%+12.7f';	
		TXT_StrPanel={handles.TXT_Disp_T_Model}; hndl={format_str,Transform,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
		
		TXT_StrPanel={handles.TXT_Disp_M_Model}; hndl={format_str,Transform,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
		
		TXT_StrPanel={handles.TXT_Disp_Model_Error_Dx, handles.TXT_Disp_Model_Error_Dy, handles.TXT_Disp_Model_Error_Dz,...
		              handles.TXT_Disp_Model_Error_Rx, handles.TXT_Disp_Model_Error_Ry, handles.TXT_Disp_Model_Error_Rz}; 
		format_str = '%+12.9f'; hndl={format_str,Transform,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
		
		% Force
		FDCtrlDoF = CTRL_DOF==1; format_str = '%+12.3f';	
		TXT_StrPanel={handles.TXT_Forc_T_Model}; hndl={format_str,Transform,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
		
		TXT_StrPanel={handles.TXT_Forc_M_Model}; hndl={format_str,Transform,FDCtrlDoF,2};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
		
	 	format_str = '%+12.6f';
		TXT_StrPanel={handles.TXT_Force_Model_Error}; hndl={format_str,Transform,FDCtrlDoF,1};
		UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
end 				
