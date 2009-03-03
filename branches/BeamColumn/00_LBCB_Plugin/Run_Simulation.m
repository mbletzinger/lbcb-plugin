
function Run_Simulation(hObject, eventdata, handles)

% -------------------------------------------------------------------------------------------------
% --- Run Simulation 
% -------------------------------------------------------------------------------------------------


% Initialize parameters --------------------------------
handles = readGUI(handles);				% Read parameters from GUI
handles = SetTransMCoord(handles);			% Formulate transformation matrix
disableGUI(handles);					% Disable GUI 

% To save data file with date string
handles.MDL.TestDate_Str=handles.DataSave_TestDate_Str;

End_of_Command  = 0;					% flag to define activity. 1 for run simmulation. 2 for end of simulation
StepNo		= 0;					% step number
Disp_Command 	= zeros(6,1);
Forc_Command 	= zeros(6,1);
F_prev     	= 0;					% Force at previous iteration
D_prev     	= 0;					% Displacement at previous iteration
D_prev_s   	= 0;					% Displacement at previous step
D_v 		= zeros(handles.MDL.max_itr,1);		% Temporary variable in each step
F_v 		= zeros(handles.MDL.max_itr,1);		% Temporary variable in each step
TGT_D       = zeros(6,1);                 % Target Displacement
TGT_F       = zeros(6,1);                 % Target Force
TGT_Dlast	= zeros(6,1);			% for elastic deformation
Adjusted_Commandlast	=zeros(6,1);			% for elastic deformation

handles = Query_Main(handles, 1);	
offset.Lbcb1 = handles.MDL.Lbcb1.MeasDisp;
offset.Lbcb2 = handles.MDL.Lbcb2.MeasDisp;
% BY sjkim
save LBCBPlugin_IntialOffset.txt offset -ascii;
%handles.Initial_Offset=offset;

% Load input displacement history or establish network connection to remote site
switch handles.MDL.InputSource
	case 1						% Input from file
		GUI_tmp_str =sprintf('Reading input history from %s', handles.MDL.InputFile);
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		
		disp_his = load(handles.MDL.InputFile);	% 6 column data
		tmp = size(disp_his);
		if tmp(2) ~= 6
			error('Input file should have six columns of data.')
		end
		handles.MDL.totStep = tmp(1);
		InputFile_Pre_Num = get(handles.PM_FileInput_Select,'value')-1;
		%InputFile_Pre_Num = InputFile_Cur_Num;
		
	case 2						% Input from network
		GUI_tmp_str =sprintf('Waiting for connection from remote site. Port #: %d', handles.MDL.InputPort);
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		
		ip_fid = TCPIP_Server(handles.MDL.InputPort);		% Get handler from the SC. This function is in parmatlab folder.
		% Wait for the SC to send an acknowledgement from the SC
		Get_Parmatlab (ip_fid);
		Send_Parmatlab(ip_fid,sprintf('OK	0	dummyOpenSession	LBCB Gateway is Connected.'));
		recv_str = Get_Parmatlab(ip_fid,1);		% get number of steps
		handles.MDL.totStep = str2num(recv_str(strfind(recv_str,'nstep')+5:end));				% total number of steps
		Send_Parmatlab(ip_fid,sprintf('OK	0	dummySetParam	Module initialized.'));

		GUI_tmp_str ='Connection is established with the UI-SimCor.';
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
end  

guidata(hObject,handles);				% Save handles parameters


% 1st step data	
handles = HoldCheck(handles);				% check for pause button is pressed. check this right before reading step data

% Check whether input file has been changed or not
if handles.MDL.InputSource
	InputFile_Cur_Num = get(handles.PM_FileInput_Select,'value')-1;
	if InputFile_Pre_Num ~= InputFile_Cur_Num
		disp_his = load(handles.MDL.InputFile);	% 6 column data
		InputFile_Pre_Num = InputFile_Cur_Num;
	end
end

% Start 1step data
StatusIndicator(handles,1);
switch handles.MDL.InputSource
	case 1						% Input from file
		TGT = disp_his(1,:)';			% 6 column data, model space '
	case 2						% Input from network
							% Wait for the SC to send the target displacement and rotation
		recv_str = Get_Parmatlab(ip_fid,1);
		[TransID TGT handles.MDL]    = Format_Rcv_Data(handles.MDL, recv_str);
	otherwise
end
StatusIndicator(handles,0);

% for the elapsed time
handles.Starting_time=clock;  

% Model Force control DOF
handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);

% Initialize Elastic Deformation Calculations
handles.MDL.ExtTrans.Lbcb1.State = ResetExtTransState(handles.MDL.ExtTrans.Lbcb1.State,...
    handles.MDL.ExtTrans.Lbcb1.Config.NumSensors);
handles.MDL.ExtTrans.Lbcb2.State = ResetExtTransState(handles.MDL.ExtTrans.Lbcb2.State,...
    handles.MDL.ExtTrans.Lbcb2.Config.NumSensors);


while End_of_Command == 0				% until end of command is reached, 
	StepNo = StepNo + 1;							% count current step number
	ItrNo = 1;	
	handles.MDL.StepNos=StepNo;        %For RawMean.txt, SJKIM Oct24-2007
	
	% Simulation Index, Cur step
	set(handles.PB_Input_Plot, 'UserData', [1, StepNo]);
	
	% Seperate Target Displacement and Force 
	switch handles.MDL.CtrlMode
		case 1 
			TGT_D = TGT;
		case 2
			TGT_D = TGT;
		case 3
			TGT_D(handles.MDL.Model_FrcCtrlDOF~=1)=TGT(handles.MDL.Model_FrcCtrlDOF~=1);
			TGT_F(handles.MDL.Model_FrcCtrlDOF==1)=TGT(handles.MDL.Model_FrcCtrlDOF==1);
	end
	handles.MDL.T_Disp_SC_his=handles.MDL.TransM * TGT;   % for the Input history from text input or UI-SimCor step
	% Apply Input -----------------------------------------------	
	tmpTGT_D = handles.MDL.TransM * (handles.MDL.DispScale.* TGT_D);			% convert target displacement to LBCB space
	tmpTGT_F = handles.MDL.TransM * (handles.MDL.ForcScale.* TGT_F);			% convert target force to LBCB space
	
	% if elastic deformation is accounted for--------------------------------------------------
	if handles.MDL.ItrElasticDeform		
		Increment=TGT_D-TGT_Dlast;
		Adjusted_Command=Adjusted_Commandlast+Increment;
		Disp_Command = handles.MDL.TransM * (handles.MDL.DispScale.* Adjusted_Command);	% convert target displacement to LBCB space
	else
		Disp_Command = tmpTGT_D;   %handles.MDL.TransM * TGT_D;					% convert target displacement to LBCB space
	end
	
	% For the force control
	if handles.MDL.CtrlMode == 2
		Forc_Command(handles.MDL.FrcCtrlDOF) = F_prev;					% only meaningful for mixed control 1
	elseif handles.MDL.CtrlMode == 3
		Forc_Command = tmpTGT_F;
	end
	
	% Update monitoring panel
%	time_s = clock;
%	time_i = clock;
	
	% Update Monitor Panel
	if StepNo~=1
		[TimeString]=TimeCalFun(handles.Starting_time);
		GUI_tmp_str =sprintf('  %s',TimeString );
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
	end
	GUI_tmp_str =sprintf('Step %d ----------------------------',StepNo );
	disp(GUI_tmp_str);
	UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
	% Model Target
	handles.MDL.Model_T_Displ = TGT_D;
	handles.MDL.Model_T_Force = TGT_F;
	UpdateMonitorPanel (handles, 1);
	% LBCB Target
	%handles.MDL.LBCB_T_Displ = Disp_Command;
	%handles.MDL.LBCB_T_Force = Forc_Command;
	% Update monitor panel
	
	%UpdateMonitorPanel (handles, 2);

	% -------------------------------------------------------------------------------
	if handles.MDL.ItrElasticDeform		% if elastic deformation is accounted for
	% -------------------------------------------------------------------------------
		% initialize iteration for elastic deformation
		delta_disp = 10*ones(6,1);
		ItrNo = 0;					% Increment iteration number

		switch handles.MDL.CtrlMode
			case 1 
				DispCtrlDOF = ones(6,1);
			case 2
				DispCtrlDOF = [1; 2; 3; 4; 5; 6] ~= handles.MDL.FrcCtrlDOF; 
			case 3
				DispCtrlDOF = ~handles.MDL.LBCB_FrcCtrlDOF;  
		end
		
		% run while loop if displacement controlled DOFs error is larger than tolerance	
		while any(abs(delta_disp)>handles.MDL.DispTolerance & DispCtrlDOF) & ItrNo < handles.MDL.max_itr
			handles.MDL.T_Disp = Disp_Command;
			handles.MDL.T_Forc = Forc_Command;			
			
			if handles.MDL.CtrlMode==2
				handles.MDL.T_Disp(handles.MDL.FrcCtrlDOF) = tmpTGT_D(handles.MDL.FrcCtrlDOF);
			end
			
			%accepted = 0;
			%while accepted == 0
			%	accepted = LimitCheck(handles);
			%	handles  = HoldCheck(handles);
			%end
			
			ItrNo = ItrNo+1;
			GUI_tmp_str =sprintf('  Elastic Deformation %d',ItrNo);
			disp(GUI_tmp_str);
			if ItrNo==1
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
			else
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,2); 
			end
			
			% By sjkim
			if ItrNo~=1 
				% LBCB Target                                  
				handles.MDL.LBCB_T_Displ = handles.MDL.T_Disp;       
				handles.MDL.LBCB_T_Force = handles.MDL.T_Forc;       
				% Update monitor panel                         
				%set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
				UpdateMonitorPanel (handles, 2);
			end
			
			handles = propose_execute_substeps(handles);
			StatusIndicator(handles,23);	
			%
			handles = Query_Main(handles, 2);
			%
			StatusIndicator(handles,20);	
			
			NormDisp.Lbcb1 = handles.MDL.Lbcb1.MeasDisp - offset.Lbcb1;	%Remove offset
			NormDisp.Lbcb2 = handles.MDL.Lbcb2.MeasDisp - offset.Lbcb2;	%Remove offset
			
			updatePLOT(handles);
			% For Model Coordinate
			UpdateMonitorPanel (handles, 3);
			
			delta_disp.Lbcb1 = handles.MDL.TransM*(handles.MDL.DispScale.*TGT_D) ...
                - NormDisp.Lbcb1;		% in LBCB space
			delta_disp.Lbcb2 = handles.MDL.TransM*(handles.MDL.DispScale.*TGT_D) ...
                - NormDisp.Lbcb2;		% in LBCB space
			
			if handles.MDL.CtrlMode == 3
				delta_disp(handles.MDL.LBCB_FrcCtrlDOF==1) = 0;    % Neglect error for Force control DOF
			end
			
			% For UserInputOption
			if get (handles.UserInputOption_M_AdjustedCMD, 'value')
				disp ('  The previous adjusted command is coverted to the current LBCB measurement');
				Adj_CMD_LBCB_measured = handles.MDL.LBCB_MDispl + delta_disp;  % in LBCB space
				Adjusted_Command = (inv(handles.MDL.TransM) * Adj_CMD_LBCB_measured)./handles.MDL.DispScale;  % in model space
			else 
				% without User Option
				Adjusted_Command = Adjusted_Command + (inv(handles.MDL.TransM) * delta_disp)./handles.MDL.DispScale;						% in model space
			end
			
			Disp_Command = handles.MDL.TransM * (handles.MDL.DispScale.* Adjusted_Command);			% in LBCB space
			
			if ItrNo >= handles.MDL.max_itr
				GUI_tmp_str ='  Maximum number of iteration reached.';
				disp(GUI_tmp_str);
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
			end
		end	
		Adjusted_Commandlast = Adjusted_Command;
		TGT_Dlast = TGT_D;
	
	%-------------------------------------------------------------------------------
	else	% if elastic deformation is neglected
	%-------------------------------------------------------------------------------
		handles.MDL.T_Disp = tmpTGT_D;
		handles.MDL.T_Forc = Forc_Command;
%		GUI_tmp_str =sprintf('  Elastic Deformation %d',ItrNo);
%		disp(GUI_tmp_str);
%		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		%set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
		handles = propose_execute_substeps(handles);
		StatusIndicator(handles,23);	
		%
		handles = Query_Main(handles, 2);
		%
		StatusIndicator(handles,20);	

		updatePLOT(handles);
		% For Model Coordinate
		UpdateMonitorPanel (handles, 3);
	end
	
	% Apply force -----------------------------------------------		
	ItrNo = 1;								% Increment iteration number
	switch handles.MDL.CtrlMode
		case 1
		case 3
		case 2
			% This will be deleted in the later version.
			Run_Simulation_FrCtl_PSD_Script;
		otherwise
	end

    % AUX module... CAMERA and DAQ, by SJKIM
    Trigger(handles.AUX);
    
	% To Save SimCor step data
	% RawMeanData for Elastic Deformation iteration
	SaveFileName=sprintf('RawMean_SimCorStep_%s.txt',handles.MDL.TestDate_Str);
	SaveData = handles.MDL.SimCorStepData;
	% save data
	SaveSimulationData (SaveFileName,StepNo,SaveData,1);
	%
	%
	handles = HoldCheck(handles);
	StatusIndicator(handles,1);
	switch handles.MDL.InputSource
		case 1						% Input from file
			% Check whether input file has been changed or not
			InputFile_Cur_Num = get(handles.PM_FileInput_Select,'value')-1;
			if InputFile_Pre_Num ~= InputFile_Cur_Num
				GUI_tmp_str =sprintf('Reading input history from %s', handles.MDL.InputFile);
				disp(GUI_tmp_str);
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
				
				disp_his = load(handles.MDL.InputFile);	% 6 column data
				InputFile_Pre_Num = InputFile_Cur_Num;
			end
			
			if StepNo + 1 <= length(disp_his)
				TGT = disp_his(StepNo+1,:)';	  %'
			else 
				End_of_Command = 1;
			end
		case 2						% Input from network
			send_str = Format_Rtn_Data(handles.MDL);
			Send_Parmatlab(ip_fid,send_str);
			recv_str = Get_Parmatlab(ip_fid,1);
				
			if strncmp(recv_str, 'close-session',13)
				End_of_Command = 1;
				Send_Parmatlab(ip_fid,sprintf('OK	0	dummyCloseSession	See you later!.'));
				tcpip_close(ip_fid);
				GUI_tmp_str ='Connection to UI-SimCor closed.    ';
				disp(GUI_tmp_str);
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
			else
				[TransID TGT handles.MDL]    = Format_Rcv_Data(handles.MDL, recv_str);
		    	end
		otherwise
	end	
	StatusIndicator(handles,0);
%	tmpstr = sprintf('%d %e %e %e %e %e %e %e %e %e %e %e %e ',StepNo, [handles.MDL.M_Disp ; handles.MDL.M_Forc]);
%	DataLogger(tmpstr,5);
end
enableGUI(handles);
set(handles.PB_Pause, 'value', 0);
guidata(hObject, handles);