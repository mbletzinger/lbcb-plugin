% _____________________________________________________________________
% 
% Function Run_Simulation.m contains the main code for running a test.
% Targets for each step are loaded from a file, or from a network source.
% The steps are broken down into substeps and sent to the Operations 
% Manager.  Iterations are performed to reach targeted state.
% _____________________________________________________________________

function Run_Simulation(hObject, eventdata, handles)

% _____________________________________________________________________
% 
% Initialize Variables
% _____________________________________________________________________

StatusIndicator(handles,1);   % Processing
guidata(hObject,handles);				% Save handles parameters
handles = readGUI(handles);				% Read parameters from GUI
handles = SetTransMCoord(handles);			% Formulate transformation matrix
disableGUI(handles);					% Disable GUI 


End_of_Command  = 0;					% flag to define activity. 1 for run simmulation. 2 for end of simulation
handles.StepNo		= 0;                        % step number
TGTlast			=zeros(6,1);			% for elastic deformation
Adjusted_Commandlast	=zeros(6,1);			% for elastic deformation
% Scale factors - displacement scale factors for DOF's 1, 2, 4, 6 and force
% scale factors for DOF's 3, 5:
handles.SclFctrs=[handles.MDL.DispScale(1) handles.MDL.DispScale(2)...
    handles.MDL.ForcScale(3) handles.MDL.DispScale(4)...
    handles.MDL.ForcScale(5) handles.MDL.DispScale(6)]';
handles.MDL.curStep=0;
handles.Stop=0;

% Stiffness values should be the stiffest that might be exected
% Both should be positive numbers
K33=1200;    % K33 is the stiffness in the delta Z direction in kips/in
K55=950000;  % K55 is the stiffness in the theta Y direction in k-in/rad

% _____________________________________________________________________
%
% Get Initial Data From Operations Manager
% _____________________________________________________________________

StatusIndicator(handles,2);   % Waiting for OM
guidata(hObject,handles);				% Save handles parameters
handles.MDL = query_mean(handles.MDL,1);
StatusIndicator(handles,1);   % Processing
guidata(hObject,handles);				% Save handles parameters

% Use initial readings as the offset.  Use offset to zero readings later.
offset_M_disp = handles.MDL.M_Disp;
offset_M_forc = handles.MDL.M_Forc;
offset_Aux = handles.MDL.M_AuxDisp;
offset_M_disp
offset_M_forc
offset_Aux
% Do not zero out the pin load cell readings:
% offset_Aux(1) = 0;
% offset_Aux(2) = 0;
% offset_Aux(3) = 0;
% offset_Aux(4) = 0;
% Zero out the readings by subtracting initial offset
handles.MDL.M_Disp = handles.MDL.M_Disp - offset_M_disp;
handles.MDL.M_Forc = handles.MDL.M_Forc - offset_M_forc;
handles.MDL.M_AuxDisp = handles.MDL.M_AuxDisp - offset_Aux;

u_CMND_Last=zeros(6,1);
f_Mdl_Last=zeros(6,1);
u_Mdl_Last=zeros(6,1);

K=zeros(6,6);
G=eye(6,6);

% _____________________________________________________________________
%
% Load targets from file, or establish network connection with Simcor
% _____________________________________________________________________

StatusIndicator(handles,3);   % Getting Targets
guidata(hObject,handles);				% Save handles parameters
switch handles.MDL.InputSource
	case 1						% Input from file
		% Input file consists of six columns.  Dx Dy Fz Rx My Rz.  Fz and
		% My are computed about the point at the level of the load cell
		% pins.  Dx is at the level of the String Pots.
        disp(sprintf('Reading input displacement history from %s', handles.MDL.InputFile));
		handles.disp_his = load(handles.MDL.InputFile);	% 6 column data
		tmp = size(handles.disp_his);
		if tmp(2) ~= 6
			error('Input file should have six columns of data.')
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

% _____________________________________________________________________
%
% Get target data for the first step
% _____________________________________________________________________

switch handles.MDL.InputSource
	case 1                              % Input from file
		TGT = handles.disp_his(1,:)';			% 6 column data, model space
	case 2                              % Input from network
			% Wait for Simcor to send the target displacement and rotation
		recv_str = Get_Parmatlab(ip_fid,1);
		[TransID TGT handles.MDL]    = Format_Rcv_Data(handles.MDL, recv_str);
	otherwise
end
StatusIndicator(handles,1);   % Processing
guidata(hObject,handles);				% Save handles parameters

TGT=[handles.SclFctrs(1)*TGT(1) handles.SclFctrs(2)*TGT(2) handles.SclFctrs(3)*TGT(3)...
    handles.SclFctrs(4)*TGT(4) handles.SclFctrs(5)*TGT(5) handles.SclFctrs(6)*TGT(6)]';

% Display Targets on the Screen
set(handles.Target_DX,		'string',	num2str(TGT(1)));
set(handles.Target_DY,		'string',	num2str(TGT(2)));
set(handles.Target_FZ,		'string',	num2str(TGT(3)));
set(handles.Target_RX,		'string',	num2str(TGT(4)));
set(handles.Target_MY,		'string',	num2str(TGT(5)));
set(handles.Target_RZ,		'string',	num2str(TGT(6)));
guidata(hObject, handles);

StatusIndicator(handles,0);   % Blank Status
guidata(hObject,handles);				% Save handles parameters
% Give the User time to Update Targets or Load a New Targets File
handles  = RunCheck(handles);
StatusIndicator(handles,1);   % Processing
guidata(hObject,handles);				% Save handles parameters

% Get the New Targets
TGT(1) 		= str2num(get(handles.Target_DX, 	'string'));
TGT(2) 		= str2num(get(handles.Target_DY, 	'string'));
TGT(3) 		= str2num(get(handles.Target_FZ, 	'string'));
TGT(4) 		= str2num(get(handles.Target_RX, 	'string'));
TGT(5) 		= str2num(get(handles.Target_MY, 	'string'));
TGT(6) 		= str2num(get(handles.Target_RZ, 	'string'));

SbStpPerPic     = str2num(get(handles.NumPics, 	'string'));


% _____________________________________________________________________
%
% Start loop over steps
% _____________________________________________________________________

while End_of_Command==0
    handles.StepNo=handles.StepNo+1;
    PicCount=1;
    ItrNo=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate Substep size and total number of substeps required
    
    Increment=TGT-TGTlast;
    OverLimit = abs(Increment)./handles.MDL.DispIncMax;
    % Number of substeps, and IncSubstep are based on displacement
    % controlled DOF's only:
    OverLimit_Rdcd=[OverLimit(1) OverLimit(2) OverLimit(4) OverLimit(6)]';
    [division MaxOverLimitDOF] = max(OverLimit_Rdcd);
    NumSubStps=ceil(division);
    IncSubStep = Increment/NumSubStps;
    % Note that NumSubStps should be at least 1 because ceil function
    % rounds up to next largest integer
    
    time_s = clock;
    time_i = clock;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get First Step Command
    Command=TGTlast+IncSubStep;
    CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
        -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
        -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
    delta_cmnd=Command-CrntState;  % Used in Tolerance Check
    Adjusted_Command=Adjusted_Commandlast+delta_cmnd;
    % At the beginning execute the displacement controlled DOF's only
    Adjusted_Command=[Adjusted_Command(1) Command(2) Adjusted_Commandlast(3) Command(4)...
        Adjusted_Commandlast(5) Command(6)]';
    % The following code was inserted for the first component to adjust for
    % the difference between string pot height and LBCB height:
    % Adjusted_Command(1)*handles.MDL.Aux_Config.LBCB_Ht/handles.MDL.Aux_Config.Roof_Ht
    LBCB_Command=handles.MDL.TransM*Adjusted_Command;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Start Loop over Substeps
    
    fprintf('Step number %d, starting loop over substeps.\n',handles.StepNo);
    
    for sbstp=1:NumSubStps
        % |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|
        % Check Pause Button and Limit Detects
        StatusIndicator(handles,0);     % Blank
        guidata(hObject,handles);		% Save handles parameters
        accepted = 0;
        while accepted == 0
            accepted = LimitCheck(handles);
            guidata(hObject,handles);
            handles  = PauseStopCheck(handles);
        end
        fprintf('Executing substep number %d.\n',sbstp);
        
        StatusIndicator(handles,41);        % Running Iterations and Processing
        guidata(hObject,handles);			% Save handles parameters
        % |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|
        % Start the iteration loop for convergence        
        delta_cmnd=ones(6,1).*10;
        while any(abs(delta_cmnd)>handles.MDL.DispTolerance) & ItrNo < handles.MDL.max_itr & handles.Stop==0;
            
            %////////////////////////////////
            % Loop for convergence of X Displacement
            while abs(delta_cmnd(1))>handles.MDL.DispTolerance(1) & handles.Stop==0;
                ItrNo=ItrNo+1;
                %--------------------------------------
                % Propose, Execute, and Read Data
                
                % MDL.T_Disp is the command that gets executed
                handles.MDL.T_Disp = LBCB_Command;
                accepted = 0;
                
                while accepted == 0
                    StatusIndicator(handles,4);   % Running Iterations
                    accepted = LimitCheck(handles);
                    guidata(hObject,handles);
                    handles = PauseStopCheck(handles);
                end
                
                if handles.Stop==0
                                        
                    StatusIndicator(handles,42);   % Running Iterations and Waiting on OM
                    guidata(hObject,handles);				% Save handles parameters
                    handles.MDL = propose(handles.MDL);     % PROPOSE COMMAND
                    handles.MDL = execute(handles.MDL);     % EXECUTE COMMAND
                    handles.MDL = query_mean(handles.MDL,1);% GET NEW READINGS
                    
                    StatusIndicator(handles,41);   % Running Iterations and Processing
                    guidata(hObject,handles);				% Save handles parameters
                                        
                    % Zero out the readings by subtracting initial offset
                    handles.MDL.M_Disp = handles.MDL.M_Disp - offset_M_disp;
                    handles.MDL.M_Forc = handles.MDL.M_Forc - offset_M_forc;
                    handles.MDL.M_AuxDisp = handles.MDL.M_AuxDisp - offset_Aux;
                    
                    %--------------------------------------
                    % Record data to file
                    curstepTemp=handles.MDL.curStep;
                    M_DispTemp=handles.MDL.M_Disp;
                    M_ForcTemp=handles.MDL.M_Forc;
                    tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
                    tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
                    tmp1(end) = floor(tmp1(end));
                    stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));
                    
                    fid = fopen('RunLog.txt','a');
                    fprintf(fid,'%s %f ',stamp,handles.StepNo);
                    fprintf(fid,'%f %f %f %f %f %f ',TGT);
                    fprintf(fid,'%f %f %f %f %f %f ',TGTlast);
                    fprintf(fid,'%f ',curstepTemp+1);
                    fprintf(fid,'%f %f %f %f %f %f ',M_DispTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',M_ForcTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',Command);
                    fprintf(fid,'%f %f %f %f %f %f ',CrntState);
                    fprintf(fid,'%f %f %f %f %f %f ',Adjusted_Command);
                    fprintf(fid,'%f %f %f %f %f %f ',LBCB_Command);
                    fprintf(fid,'\r\n');
                    fclose(fid);

                    %--------------------------------------
                    % Update Graph and Values on the Screen
                    if handles.MDL.UpdateMonitor
                        set(handles.TXT_Disp_T_Model, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n        -     \n%+12.5f\n', Command(1),Command(2),Command(4),Command(6)));
                        set(handles.TXT_Forc_T_Model, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n%+12.5f\n        -     \n', Command(3),Command(5)));
                        set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', LBCB_Command(1),LBCB_Command(2),LBCB_Command(3),LBCB_Command(4),LBCB_Command(5),LBCB_Command(6)));
                        set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n        -     \n'));

                        set(handles.TXT_Disp_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Disp));
                        set(handles.TXT_Forc_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Forc));
                        set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Disp));
                        set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Forc));
                        set(handles.TXT_M_Ext_Feedback, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_AuxDisp));

                        set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d',handles.StepNo));
                        set(handles.TXT_LBCB_Mes_Sbstp, 'string', sprintf('Substep #: %d',sbstp));
                        set(handles.TXT_LBCB_Mes_Itr, 'string', sprintf('Iteration #: %d',ItrNo));

                        % Write data to history variables for use in the plot
                        handles.MDL.tDisp_history(handles.MDL.curStep,:) = LBCB_Command;
                        handles.MDL.mDisp_history(handles.MDL.curStep,:) = handles.MDL.M_Disp;
                        handles.MDL.mForc_history(handles.MDL.curStep,:) = handles.MDL.M_Forc;
                        handles.MDL.tDisp_history_SC(handles.MDL.curStep,:) = Command;
                        guidata(hObject, handles);
                        updatePLOT(handles);
                    end

                    %--------------------------------------
                    % Calculate Next Command
                    Adjusted_Commandlast=Adjusted_Command;
                    CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                        -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                        -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
                    delta_cmnd=Command-CrntState;  % Used in Tolerance Check
                    Adjusted_Command=Adjusted_Commandlast+delta_cmnd;
                    Adjusted_Command=[Adjusted_Command(1) Command(2) Adjusted_Commandlast(3) Command(4)...
                        Adjusted_Commandlast(5) Command(6)]';
                    LBCB_Command=handles.MDL.TransM*Adjusted_Command;
                end
            end
            
            if handles.Stop==0
                %///////////////////////////////////////////////////////
                % Calculate the first command for the next loop
                Adjusted_Commandlast=Adjusted_Command;
                handles.MDL.M_Disp
                handles.MDL.M_Forc
                CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                    -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                    -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
                delta_cmnd=Command-CrntState;  % Used in Tolerance Check
                CrntState
                delta_f3=Command(3)-CrntState(3);
                delta_u3=delta_f3/K33;
                delta_u=[0 0 delta_u3 0 0 0]'; % Only execute Z displacement
                Adjusted_Command=Adjusted_Commandlast+delta_u;
                LBCB_Command=handles.MDL.TransM*Adjusted_Command;
            end
            
            %///////////////////////////////////////////////////////
            % Loop for convergence of Z Force
            while abs(delta_cmnd(3))>handles.MDL.DispTolerance(3) & handles.Stop==0;
                
                ItrNo=ItrNo+1;
                %--------------------------------------
                % Propose, Execute, and Read Data

                % MDL.T_Disp is the command that gets executed
                handles.MDL.T_Disp = LBCB_Command;
                accepted = 0;
                while accepted == 0
                    StatusIndicator(handles,4);   % Running Iterations
                    accepted = LimitCheck(handles);
                    guidata(hObject,handles);
                    handles = PauseStopCheck(handles);
                end
                
                if handles.Stop==0
                    StatusIndicator(handles,42);   % Running Iterations and Waiting on OM
                    guidata(hObject,handles);				% Save handles parameters
                    handles.MDL = propose(handles.MDL);     % PROPOSE COMMAND
                    handles.MDL = execute(handles.MDL);     % EXECUTE COMMAND
                    handles.MDL = query_mean(handles.MDL,1);% GET NEW READINGS
                    
                    StatusIndicator(handles,41);   % Running Iterations and Processing
                    guidata(hObject,handles);				% Save handles parameters
                    
                    % Zero out the readings by subtracting initial offset
                    handles.MDL.M_Disp = handles.MDL.M_Disp - offset_M_disp;
                    handles.MDL.M_Forc = handles.MDL.M_Forc - offset_M_forc;
                    handles.MDL.M_AuxDisp = handles.MDL.M_AuxDisp - offset_Aux;

                    %--------------------------------------
                    % Record data to file
                    curstepTemp=handles.MDL.curStep;
                    M_DispTemp=handles.MDL.M_Disp;
                    M_ForcTemp=handles.MDL.M_Forc;
                    tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
                    tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
                    tmp1(end) = floor(tmp1(end));
                    stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));
                    
                    fid = fopen('RunLog.txt','a');
                    fprintf(fid,'%s %f ',stamp,handles.StepNo);
                    fprintf(fid,'%f %f %f %f %f %f ',TGT);
                    fprintf(fid,'%f %f %f %f %f %f ',TGTlast);
                    fprintf(fid,'%f ',curstepTemp+1);
                    fprintf(fid,'%f %f %f %f %f %f ',M_DispTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',M_ForcTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',Command);
                    fprintf(fid,'%f %f %f %f %f %f ',CrntState);
                    fprintf(fid,'%f %f %f %f %f %f ',Adjusted_Command);
                    fprintf(fid,'%f %f %f %f %f %f ',LBCB_Command);
                    fprintf(fid,'\r\n');
                    fclose(fid);
%                     cd('..');
%                     cd('Support Files');

                    %--------------------------------------
                    % Update Graph and Values on the Screen
                    if handles.MDL.UpdateMonitor
                        set(handles.TXT_Disp_T_Model, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n        -     \n%+12.5f\n', Command(1),Command(2),Command(4),Command(6)));
                        set(handles.TXT_Forc_T_Model, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n%+12.5f\n        -     \n', Command(3),Command(5)));
                        set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', LBCB_Command(1),LBCB_Command(2),LBCB_Command(3),LBCB_Command(4),LBCB_Command(5),LBCB_Command(6)));
                        set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n        -     \n'));
                        set(handles.TXT_Disp_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Disp));
                        set(handles.TXT_Forc_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Forc));
                        set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Disp));
                        set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Forc));
                        set(handles.TXT_M_Ext_Feedback, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_AuxDisp));
                        
                        set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d',handles.StepNo));
                        set(handles.TXT_LBCB_Mes_Sbstp, 'string', sprintf('Substep #: %d',sbstp));
                        set(handles.TXT_LBCB_Mes_Itr, 'string', sprintf('Iteration #: %d',ItrNo));

                        % Write data to history variables for use in the plot
                        handles.MDL.tDisp_history(handles.MDL.curStep,:) = LBCB_Command;
                        handles.MDL.mDisp_history(handles.MDL.curStep,:) = handles.MDL.M_Disp;
                        handles.MDL.mForc_history(handles.MDL.curStep,:) = handles.MDL.M_Forc;
                        handles.MDL.tDisp_history_SC(handles.MDL.curStep,:) = Command;
                        guidata(hObject, handles);
                        updatePLOT(handles);
                    end

                    %--------------------------------------
                    % Calculate the command for the next iteration
                    Adjusted_Commandlast=Adjusted_Command;
                    CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                        -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                        -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
                    delta_cmnd=Command-CrntState;  % Used in Tolerance Check
                    delta_f3=Command(3)-CrntState(3);
                    delta_u3=delta_f3/K33;
                    delta_u=[0 0 delta_u3 0 0 0]'; % Only execute Z displacement
                    Adjusted_Command=Adjusted_Commandlast+delta_u;
                    LBCB_Command=handles.MDL.TransM*Adjusted_Command;
                end 
            end
            
            if handles.Stop==0
                %///////////////////////////////////////////////////////
                % Calculate the first command for the next loop
                Adjusted_Commandlast=Adjusted_Command;
                CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                    -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                    -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
                delta_cmnd=Command-CrntState;  % Used in Tolerance Check
                delta_f5=Command(5)-CrntState(5);
                delta_u5=delta_f5/K55;
                delta_u=[0 0 0 0 delta_u5 0]';  % Only execute Theta Y
                Adjusted_Command=Adjusted_Commandlast+delta_u;
                LBCB_Command=handles.MDL.TransM*Adjusted_Command;
            end
            
            %///////////////////////////////////////////////////////
            % Loop for convergence of Y Moment
            while abs(delta_cmnd(5))>handles.MDL.DispTolerance(5) & handles.Stop==0;
                ItrNo=ItrNo+1;
                %--------------------------------------
                % Propose, Execute, and Read Data

                % MDL.T_Disp is the command that gets executed
                handles.MDL.T_Disp = LBCB_Command;
                accepted = 0;
                while accepted == 0
                    StatusIndicator(handles,4);   % Running Iterations
                    accepted = LimitCheck(handles);
                    guidata(hObject,handles);
                    handles = PauseStopCheck(handles);
                end
                
                if handles.Stop==0
                    StatusIndicator(handles,42);   % Running Iterations and Waiting on OM
                    guidata(hObject,handles);				% Save handles parameters
                    handles.MDL = propose(handles.MDL);     % PROPOSE COMMAND
                    handles.MDL = execute(handles.MDL);     % EXECUTE COMMAND
                    handles.MDL = query_mean(handles.MDL,1);% GET NEW READINGS
                    
                    StatusIndicator(handles,41);   % Running Iterations and Processing
                    guidata(hObject,handles);				% Save handles parameters
                    
                    % Zero out the readings by subtracting initial offset
                    handles.MDL.M_Disp = handles.MDL.M_Disp - offset_M_disp;
                    handles.MDL.M_Forc = handles.MDL.M_Forc - offset_M_forc;
                    handles.MDL.M_AuxDisp = handles.MDL.M_AuxDisp - offset_Aux;
                    
                    %--------------------------------------
                    % Record data to file
                    curstepTemp=handles.MDL.curStep;
                    M_DispTemp=handles.MDL.M_Disp;
                    M_ForcTemp=handles.MDL.M_Forc;
                    tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
                    tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
                    tmp1(end) = floor(tmp1(end));
                    stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));
                    
                    fid = fopen('RunLog.txt','a');
                    fprintf(fid,'%s %f ',stamp,handles.StepNo);
                    fprintf(fid,'%f %f %f %f %f %f ',TGT);
                    fprintf(fid,'%f %f %f %f %f %f ',TGTlast);
                    fprintf(fid,'%f ',curstepTemp+1);
                    fprintf(fid,'%f %f %f %f %f %f ',M_DispTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',M_ForcTemp);
                    fprintf(fid,'%f %f %f %f %f %f ',Command);
                    fprintf(fid,'%f %f %f %f %f %f ',CrntState);
                    fprintf(fid,'%f %f %f %f %f %f ',Adjusted_Command);
                    fprintf(fid,'%f %f %f %f %f %f ',LBCB_Command);
                    fprintf(fid,'\r\n');
                    fclose(fid);
%                     cd('..');
%                     cd('Support Files');

                    %--------------------------------------
                    % Update Graph and Values on the Screen
                    if handles.MDL.UpdateMonitor
                        set(handles.TXT_Disp_T_Model, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n        -     \n%+12.5f\n', Command(1),Command(2),Command(4),Command(6)));
                        set(handles.TXT_Forc_T_Model, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n%+12.5f\n        -     \n', Command(3),Command(5)));
                        set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', LBCB_Command(1),LBCB_Command(2),LBCB_Command(3),LBCB_Command(4),LBCB_Command(5),LBCB_Command(6)));
                        set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n        -     \n'));

                        set(handles.TXT_Disp_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Disp));
                        set(handles.TXT_Forc_M_Model, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_Forc));
                        set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Disp));
                        set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_LBCB_Forc));
                        set(handles.TXT_M_Ext_Feedback, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', handles.MDL.M_AuxDisp));
                        
                        set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d',handles.StepNo));
                        set(handles.TXT_LBCB_Mes_Sbstp, 'string', sprintf('Substep #: %d',sbstp));
                        set(handles.TXT_LBCB_Mes_Itr, 'string', sprintf('Iteration #: %d',ItrNo));

                        % Write data to history variables for use in the plot
                        handles.MDL.tDisp_history(handles.MDL.curStep,:) = LBCB_Command;
                        handles.MDL.mDisp_history(handles.MDL.curStep,:) = handles.MDL.M_Disp;
                        handles.MDL.mForc_history(handles.MDL.curStep,:) = handles.MDL.M_Forc;
                        handles.MDL.tDisp_history_SC(handles.MDL.curStep,:) = Command;
                        guidata(hObject, handles);
                        updatePLOT(handles);
                    end

                    %--------------------------------------
                    % Calculate the command for the next iteration
                    Adjusted_Commandlast=Adjusted_Command;
                    CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                        -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                        -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
                    delta_cmnd=Command-CrntState;  % Used in Tolerance Check
                    delta_f5=Command(5)-CrntState(5);
                    delta_u5=delta_f5/K55;
                    delta_u=[0 0 0 0 delta_u5 0]';  % Only execute Theta Y
                    Adjusted_Command=Adjusted_Commandlast+delta_u;
                    LBCB_Command=handles.MDL.TransM*Adjusted_Command;
                end
            end
            
        end
        ItrNo=0;
        
        if handles.Stop==0
            % |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|
            % Trigger the DAQ Computer and Camera Control Computer
            TriggerDAQ(handles.AUX,handles.StepNo,sbstp);
%             pause(2)
            curstepTemp=handles.MDL.curStep;
            fid = fopen('TriggerLog.txt','a');
            
            tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
            tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
            tmp1(end) = floor(tmp1(end));
            stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));
            fprintf(fid,'%s %f ',stamp,handles.StepNo);
            fprintf(fid,'%f ',sbstp);
            fprintf(fid,'%f ',curstepTemp);
            fprintf(fid,'%f ',PicCount);
            fprintf(fid,'%f ',SbStpPerPic);
            fprintf(fid,'Yes ');
            if PicCount>=SbStpPerPic
                TriggerCam(handles.AUX);
                whos
%                 pause(3)
                PicCount=0;
                fprintf(fid,'Yes ');
            else
                fprintf(fid,'No ');
            end
            fprintf(fid,'\r\n');
            fclose(fid);
            
            % |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|
            % Compute command for next substep
            Command=Command+IncSubStep;
            CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
                -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
                -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
            delta_cmnd=Command-CrntState;  % Used in Tolerance Check
            Adjusted_Command=Adjusted_Commandlast+delta_cmnd;
            % At the beginning execute the displacement controlled DOF's only
            Adjusted_Command=[Adjusted_Command(1) Command(2) Adjusted_Commandlast(3) Command(4)...
                Adjusted_Commandlast(5) Command(6)]';
            LBCB_Command=handles.MDL.TransM*Adjusted_Command;
        end
        PicCount=PicCount+1;
    end
    StatusIndicator(handles,1);   % Processing
    guidata(hObject,handles);	  % Save handles parameters
    
    % Set the value of TGTlast for use in next step
    if handles.Stop==0
        TGTlast=TGT;
    else
        handles.MDL = query_mean(handles.MDL,1);% GET NEW READINGS
        % Zero out the readings by subtracting initial offset
        handles.MDL.M_Disp = handles.MDL.M_Disp - offset_M_disp;
        handles.MDL.M_Forc = handles.MDL.M_Forc - offset_M_forc;
        CrntState=[handles.MDL.M_Disp(1) handles.MDL.M_Disp(2)...
            -handles.MDL.M_Forc(3) handles.MDL.M_Disp(4)...
            -handles.MDL.M_Forc(5) handles.MDL.M_Disp(6)]';
        TGTlast=[CrntState(1) TGT(2) CrntState(3) TGT(4) CrntState(5) TGT(6)]';
        handles.StepNo=handles.StepNo-1;
        Adjusted_Commandlast=inv(handles.MDL.TransM)*handles.MDL.M_LBCB_Disp;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get target for next step and check if all steps are done
    StatusIndicator(handles,3);   % Getting Targets
    guidata(hObject,handles);				% Save handles parameters
	switch handles.MDL.InputSource
		case 1						% Input from file
			if handles.StepNo + 1 <= length(handles.disp_his)
				TGT = handles.disp_his(handles.StepNo+1,:)';	  %'
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
				disp('Connection to UI-SimCor closed.                                     ');
			else
				[TransID TGT handles.MDL]    = Format_Rcv_Data(handles.MDL, recv_str);
            end
    end
    StatusIndicator(handles,1);   % Processing
    guidata(hObject,handles);				% Save handles parameters
    
    TGT=[handles.SclFctrs(1)*TGT(1) handles.SclFctrs(2)*TGT(2) handles.SclFctrs(3)*TGT(3)...
    handles.SclFctrs(4)*TGT(4) handles.SclFctrs(5)*TGT(5) handles.SclFctrs(6)*TGT(6)]';

    % Enable GUI, Unpress the Run button, and wait for the User to adjust
    % targets and press run again
    enableGUI(handles);
    set(handles.PB_Pause, 'value', 0);
    guidata(hObject, handles);

    % Display New Targets on the Screen
    set(handles.Target_DX,		'string',	num2str(TGT(1)));
    set(handles.Target_DY,		'string',	num2str(TGT(2)));
    set(handles.Target_FZ,		'string',	num2str(TGT(3)));
    set(handles.Target_RX,		'string',	num2str(TGT(4)));
    set(handles.Target_MY,		'string',	num2str(TGT(5)));
    set(handles.Target_RZ,		'string',	num2str(TGT(6)));
    guidata(hObject, handles);

    % Give the User time to Update Targets
    Temp_InputFile=handles.MDL.InputFile;

    handles.Stop=0;
    tmp_flag = 0;
    StatusIndicator(handles,0);   % Blank
    guidata(hObject,handles);				% Save handles parameters
    while get(handles.PB_Pause, 'value') == 0
        pause(0.01);
        if tmp_flag == 0
            tmp_flag = 1;
            enableGUI(handles);			% enable GUI menu
        end
        handles = readGUI(handles);
    %     handles.MDL.InputFile
    %     Temp_InputFile
        if strcmp(handles.MDL.InputFile,Temp_InputFile)
        else
            handles.StepNo=0;
            disp_his=load(handles.MDL.InputFile);	% 6 column data
            handles.disp_his=disp_his;
            tmp = size(disp_his);
            if tmp(2) ~= 6
                error('Input file should have six columns of data.')
            end
            handles.MDL.totStep = tmp(1);
            TGT = disp_his(1,:)';
            TGT=[handles.SclFctrs(1)*TGT(1) handles.SclFctrs(2)*TGT(2) handles.SclFctrs(3)*TGT(3)...
            handles.SclFctrs(4)*TGT(4) handles.SclFctrs(5)*TGT(5) handles.SclFctrs(6)*TGT(6)]';
            % Display New Targets on the Screen
            set(handles.Target_DX,		'string',	num2str(TGT(1)));
            set(handles.Target_DY,		'string',	num2str(TGT(2)));
            set(handles.Target_FZ,		'string',	num2str(TGT(3)));
            set(handles.Target_RX,		'string',	num2str(TGT(4)));
            set(handles.Target_MY,		'string',	num2str(TGT(5)));
            set(handles.Target_RZ,		'string',	num2str(TGT(6)));
            guidata(hObject, handles);
            Temp_InputFile=handles.MDL.InputFile;
        end
    end
    if tmp_flag
        disableGUI(handles);
    end
    StatusIndicator(handles,1);   % Processing
    guidata(hObject,handles);				% Save handles parameters

    % Get the New Targets
    TGT(1) 		= str2num(get(handles.Target_DX, 	'string'));
    TGT(2) 		= str2num(get(handles.Target_DY, 	'string'));
    TGT(3) 		= str2num(get(handles.Target_FZ, 	'string'));
    TGT(4) 		= str2num(get(handles.Target_RX, 	'string'));
    TGT(5) 		= str2num(get(handles.Target_MY, 	'string'));
    TGT(6) 		= str2num(get(handles.Target_RZ, 	'string'));
    
    SbStpPerPic     = str2num(get(handles.NumPics, 	'string'));

end

% _____________________________________________________________________
%
% Final Tasks to Finish the Test
% _____________________________________________________________________

enableGUI(handles);
set(handles.PB_Pause, 'value', 0);
guidata(hObject, handles);



