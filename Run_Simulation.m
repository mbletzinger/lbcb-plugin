function Run_Simulation(hObject, eventdata, handles)

% Initialize parameters --------------------------------
handles = readGUI(handles);				% Read parameters from GUI
disableGUI(handles);					% Disable GUI 

End_of_Command  	= 0;					% flag to define activity. 1 for run simmulation. 2 for end of simulation
StepNo			= 0;					% step number
Disp_Command 		= zeros(12,1);
D_prev     		= 0;					% Displacement at previous iteration
D_prev_s   		= 0;					% Displacement at previous step

TGTlast			=zeros(12,1);			% for elastic deformation
Adjusted_Commandlast	=zeros(12,1);			% for elastic deformation


% handles.MDL 		= query_mean(handles.MDL);	
% offset 			= handles.MDL.M_Disp;


% Load input displacement history or establish network connection to remote site
switch handles.MDL.InputSource
	case 1						% Input from file
		disp(sprintf('Reading input displacement history from %s', handles.MDL.InputFile));
		disp_his = load(handles.MDL.InputFile);	% 6 column data
		tmp = size(disp_his);
		if tmp(2) ~= 12
			error('Input file should have twelve columns of data.')
		end
		handles.MDL.totStep = tmp(1);
	case 2						% Input from network
		disp(sprintf('Waiting for connection from remote site. Port #: %d', handles.MDL.InputPort));
		ip_fid = TCPIP_Server(handles.MDL.InputPort);		% Get handler from the SC. This function is in parmatlab folder.
		% Wait for the SC to send an acknowledgement from the SC
		Get_Parmatlab (ip_fid);
		Send_Parmatlab(ip_fid,sprintf('OK	0	dummyOpenSession	LBCB Gateway is Connected.'));
		recv_str = Get_Parmatlab(ip_fid,1);		% get number of steps
		handles.MDL.totStep = str2num(recv_str(strfind(recv_str,'nstep')+5:end));				% total number of steps
		Send_Parmatlab(ip_fid,sprintf('OK	0	dummySetParam	Module initialized.'));
		disp('Connection is established with the UI-SimCor.                       ');
		disp('                                                                    ');
end  

guidata(hObject,handles);				% Save handles parameters

% 1st step data	
handles = HoldCheck(handles);				% check for pause button is pressed. check this right before reading step data
StatusIndicator(handles,1);
switch handles.MDL.InputSource
	case 1						% Input from file
		TGT = disp_his(1,:)';			% '6 column data, model space
	case 2						% Input from network
							% Wait for the SC to send the target displacement and rotation
		recv_str = Get_Parmatlab(ip_fid,1);
		[TransID TGT handles]    = Format_Rcv_Data(handles, recv_str);  
		
	otherwise
end
StatusIndicator(handles,0);
LBCB_Network_bool=1;				% For network state

while End_of_Command == 0				% until end of command is reached, 
	StepNo = StepNo + 1;				% count current step number
	ItrNo = 1;	
	
	% Apply displacement -----------------------------------------------	
	tmpTGT = TGT;					
	% -------------------------------------------------------------------------------
	if handles.MDL.ItrElasticDeform			% if elastic deformation is accounted for
	% -------------------------------------------------------------------------------
		Increment=TGT-TGTlast;
		Adjusted_Command=Adjusted_Commandlast+Increment;
		Disp_Command = Adjusted_Command;						% convert target displacement to LBCB space
	else
		Disp_Command = TGT;								% convert target displacement to LBCB space
	end
	
	% Update monitoring
	time_s = clock;
	time_i = clock;
	
	disp(sprintf('Step %d -----------------------------',StepNo));
	
		
	% -------------------------------------------------------------------------------
	if handles.MDL.ItrElasticDeform		% if elastic deformation is accounted for
	% -------------------------------------------------------------------------------
		% initialize iteration for elastic deformation
		delta_disp = 10*ones(12,1);
		ItrNo = 0;					% Increment iteration number
		
		% run while loop if displacement controlled DOFs error is larger than tolerance	
		while any(abs(delta_disp)>handles.MDL.DispTolerance) & ItrNo < handles.MDL.maxitr
			handles.MDL.T_Disp = Disp_Command;
			
			accepted = 0;
			while accepted == 0
				accepted = LimitCheck(handles);
				handles  = HoldCheck(handles);
			end
			
			ItrNo = ItrNo+1;
			disp(sprintf('  Elastic Deformation Iteration %d',ItrNo)); 
			set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
			
			handles = propose_execute_substeps(handles);
			
			% by Sung Jig Kim, 05/02/2009
			if handles.MDL.NetworkConnectionState  % when the network connection works well
				guidata(hObject, handles);
	%			StatusIndicator(handles,23);	
	%			handles.MDL = query_mean(handles.MDL);
	%			StatusIndicator(handles,20);	
	%			handles.MDL.M_Disp = handles.MDL.M_Disp - offset;	%Remove offset
				
				set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Disp. Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));
		
				delta_disp = TGT - handles.MDL.M_Disp;		% in LBCB space
				Adjusted_Command = Adjusted_Command + delta_disp;		
				Disp_Command = Adjusted_Command;			% in LBCB space
			else  % when the network connection is failed
				break;
			end
		end	
		
		% by Sung Jig Kim, 05/02/2009
		if handles.MDL.NetworkConnectionState  % when the network connection works well
			Adjusted_Commandlast = Adjusted_Command;
			TGTlast = TGT;
		end
	%-------------------------------------------------------------------------------
	else	% if elastic deformation is neglected
	%-------------------------------------------------------------------------------
		handles.MDL.T_Disp = tmpTGT;
	
		accepted = 0;
		while accepted == 0
			accepted = LimitCheck(handles);
			handles  = HoldCheck(handles);
		end

		disp(sprintf('  Elastic Deformation Iteration %d',ItrNo)); 
		set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
		handles = propose_execute_substeps(handles);
		
		% by Sung Jig Kim, 05/02/2009
		if handles.MDL.NetworkConnectionState  % when the network connection works well
			guidata(hObject, handles);
	%		StatusIndicator(handles,23);	
	%		handles.MDL = query_mean(handles.MDL);
	%		StatusIndicator(handles,20);	
	%		handles.MDL.M_Disp = handles.MDL.M_Disp - offset;	%Remove offset
			
	%		updatePLOT(handles);
	
			set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Disp. Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));
		end
	end
	
        % 
	% if handles.MDL.UpdateMonitor
	% 	set(handles.TXT_Disp_M_Model, 'string', sprintf('%+10.3f\n', handles.MDL.M_Disp));
	% 	set(handles.TXT_Forc_M_Model, 'string', sprintf('%+10.3f\n', handles.MDL.M_Forc));
	% end
	% set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d   %5.2f sec',StepNo,etime(clock, time_s)));
		%%%%%%%%%%%%%
	% by Sung Jig Kim, 05/02/2009
	if handles.MDL.NetworkConnectionState==0
		Help_String={'DUE TO NETWORK ERROR WITH LBCB OM...';
		             '    1. Adjusted CMD will be the current position';
		             '    2. Current SimCor target will be proposed when LBCB OM is reconnected';
		             '    3. The LBCB position will be saved at ''CurrentLBCB_Position.txt'' when the network is recovered';
		             '   ';
		             'PLEASE, FOLLOW INSTRUCTIONS BELOW...';
		             '    1. Push ''Reconnect'' to close the current network port and reconnect LBCB OM';
		             '    2. Do not delete ''CurrentLBCB_Position.txt'' ';
		             '    3. If this is the only network problem, neglect the LBCB offset';
		             '    4. If you need to restart the LBCB Operation Manager,';
		             '         Check current offset values in LBCB OM before switching to local origin';
		             '         Determine offset values in the LBCB' ;
		             '    5. Resume simulation'};
		             
		helpdlg(Help_String,'Instruction to resume the simulation');
		set(handles.PB_Pause, 'value', 0);
		LBCB_Network_bool=0;
	end
	
	handles = HoldCheck(handles);
	
	StatusIndicator(handles,1);
	switch handles.MDL.InputSource
		case 1						% Input from file
			% Modified by Sung Jig Kim, 05/02/2009
			if LBCB_Network_bool==1
				if StepNo + 1 <= length(disp_his)
					TGT = disp_his(StepNo+1,:)';	%'
				else 
					End_of_Command = 1;
				end
			else % when the network is reconnected
				StepNo=StepNo-1;                                            % adjust step number due to network error
				LBCB_Network_bool=1;
			end
		case 2						% Input from network
			% Modified by Sung Jig Kim, 05/02/2009
			if LBCB_Network_bool==1
				[handles send_str] = Format_Rtn_Data(handles);
				Send_Parmatlab(ip_fid,send_str);
				recv_str = Get_Parmatlab(ip_fid,1);
					
				if strncmp(recv_str, 'close-session',13)
					End_of_Command = 1;
					Send_Parmatlab(ip_fid,sprintf('OK	0	dummyCloseSession	See you later!.'));
					tcpip_close(ip_fid);
					disp('Connection to UI-SimCor closed.                                     ');
				else
					[TransID TGT handles]    = Format_Rcv_Data(handles, recv_str);  
			   	end
			else % when the network is reconnected
				StepNo=StepNo-1;                                            % adjust step number due to network error
                % This code shown below should be verified. sjkim
                % 05/03/2009
				TGT=tmpTGT;   % use previous target data 
				TGTlast=load ('CurrentLBCB_Position.txt');
				Adjusted_Commandlast=TGTlast;
				LBCB_Network_bool=1;
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
