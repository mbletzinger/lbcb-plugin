function varargout = LBCB_Plugin(varargin)
% MLOOP M-file for MLoop.fig
%      MLOOP, by itself, creates a new MLOOP or raises the existing
%      singleton*.
%
%      H = MLOOP returns the handle to a new MLOOP or the handle to
%      the existing singleton*.
%
%      MLOOP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MLOOP.M with the given input arguments.
%
%      MLOOP('Property','Value',...) creates a new MLOOP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MLoop_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MLoop_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help MLoop

% Last Modified by GUIDE v2.5 08-Aug-2007 16:42:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MLoop_OpeningFcn, ...
                   'gui_OutputFcn',  @MLoop_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MLoop is made visible.
function MLoop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MLoop (see VARARGIN)

handles = Plugin_Initialize(handles,1); 				% Initialize values
handles.output = hObject;	% Choose default command line output for MLoop
guidata(hObject, handles);	% Update handles structure
% UIWAIT makes MLoop wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = MLoop_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% *************************************************************************************************
% *************************************************************************************************
% Push Buttons
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_LBCB_Connect. 
% -------------------------------------------------------------------------------------------------
function PB_LBCB_Connect_Callback(hObject, eventdata, handles)

disp('Connecting to LBCB ...................................');
handles.MDL.Comm_obj = tcpip(handles.MDL.IP,handles.MDL.Port);            % create TCPIP obj(objInd)ect
set(handles.MDL.Comm_obj,'InputBufferSize', 1024*100);                    % set buffer size
handles.MDL = open(handles.MDL);
disp('Connection is established with LBCB.');

set(handles.PB_LBCB_Disconnect,	'enable',	'on');
set(handles.PB_LBCB_Connect,	'enable',	'off');
set(handles.PB_Pause,		'enable',	'on');
set(handles.Edit_LBCB_IP,       'enable',	'off');
set(handles.Edit_LBCB_Port,     'enable',	'off');

%set(handles.Edit_Disp_SF,	'enable',	'on');
%set(handles.Edit_Rotation_SF,	'enable',	'on');
%set(handles.Edit_Forc_SF,	'enable',	'on');
%set(handles.Edit_Moment_SF,	'enable',	'on');
%set(handles.PM_Model_Coord,	'enable',	'on');
%set(handles.PM_LBCB_Coord,	'enable',	'on');
guidata(hObject, handles);



Run_Simulation(hObject, eventdata, handles);
% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_LBCB_Disconnect.
% -------------------------------------------------------------------------------------------------
function PB_LBCB_Disconnect_Callback(hObject, eventdata, handles)

button = questdlg('Disconnect from LBCB? All variables will be initialized.','Disconnect','Yes','No','Yes');
switch button
	case 'Yes'
		disp('Simulation has successfully completed.                              ');
		close(handles.MDL);
		disp('Connection to remote site is closed.                                ');
		
		handles = readGUI(handles);
		handles = Plugin_Initialize(handles,2); 				% Initialize values
		
		guidata(hObject, handles);
	case 'No'
end


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Load_File.
% -------------------------------------------------------------------------------------------------
function PB_Load_File_Callback(hObject, eventdata, handles)

[file,path] = uigetfile({'*.txt';'*.dat';'*.m';'*.mdl';'*.mat';'*.*'},'Load displacement history.');
if file ~= 0
	set(handles.Edit_File_Path, 'String',[path file]);
	handles.MDL.InputFile = [path file];
	guidata(hObject, handles);
end

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Load_Config.
% -------------------------------------------------------------------------------------------------
function PB_Load_Config_Callback(hObject, eventdata, handles)

[file,path] = uigetfile('*.mat','Load Configuration');
if file ~= 0 
	load([path file]);
	handles.MDL = MDL;
	handles = Plugin_Initialize(handles, 2);
	guidata(hObject, handles);
end

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Load_Default.
% -------------------------------------------------------------------------------------------------
function PB_Load_Default_Callback(hObject, eventdata, handles)

button = questdlg('All variables will be reset to default values. Proceed?','Load default configuration.','Yes','No','Yes');
switch button
	case 'Yes'
		handles = Plugin_Initialize(handles,1);
	case 'No'
end

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Save_Config.
% -------------------------------------------------------------------------------------------------
function PB_Save_Config_Callback(hObject, eventdata, handles)

[file,path] = uiputfile('*.mat','Save Configuration As');
if file ~= 0
	handles = readGUI(handles);
	MDL = handles.MDL;	% copy internal variables
	
	MDL.M_Disp        	= [];                       % Measured displacement at each step, Num_DOFx1
	MDL.M_Forc        	= [];                       % Measured force at each step, Num_DOFx1
	MDL.T_Disp_0      	= [];                       % Previous step's target displacement, Num_DOFx1
	MDL.T_Disp        	= [];                       % Target displacement, Num_DOFx1
	MDL.T_Forc_0      	= [];                       % Previous step's target displacement, Num_DOFx1
	MDL.T_Forc        	= [];                       % Target displacement, Num_DOFx1
	MDL.Comm_obj      	= {};                       % communication object

	% Following six variables are only used GUI mode to plot history of data
	MDL.tDisp_history     	= [];                   	% History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
	MDL.tForc_history     	= [];                   	% History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
	MDL.mDisp_history     	= [];                   	% History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
	MDL.mForc_history     	= [];                   	% History of measured force in global system, total step numbet x Num_DOF, in HSF space
	MDL.TransM		= [];
	MDL.TransID           	= '';                  		% Transaction ID
	MDL.curStep       	= 0;                        	% Current step number for this module
	MDL.totStep       	= 0;                        	% Total number of steps to be tested
	MDL.curState      	= 0;                        	% Current state of simulation

	save([path file], 'MDL')
end

% -------------------------------------------------------------------------------------------------
% --- Run Simulation 
% -------------------------------------------------------------------------------------------------
function Run_Simulation(hObject, eventdata, handles)

% Initialize parameters --------------------------------
handles = readGUI(handles);				% Read parameters from GUI
handles = SetTransMCoord(handles);			% Formulate transformation matrix
disableGUI(handles);					% Disable GUI 

End_of_Command  = 0;					% flag to define activity. 1 for run simmulation. 2 for end of simulation
StepNo		= 0;					% step number
Disp_Command 	= zeros(6,1);
Forc_Command 	= zeros(6,1);
F_prev     	= 0;					% Force at previous iteration
D_prev     	= 0;					% Displacement at previous iteration
D_prev_s   	= 0;					% Displacement at previous step
D_v 		= zeros(handles.MDL.max_itr,1);		% Temporary variable in each step
F_v 		= zeros(handles.MDL.max_itr,1);		% Temporary variable in each step

TGTlast			=zeros(6,1);			% for elastic deformation
Adjusted_Commandlast	=zeros(6,1);			% for elastic deformation


handles.MDL = query_mean(handles.MDL);	
offset = handles.MDL.M_Disp;

% Load input displacement history or establish network connection to remote site
switch handles.MDL.InputSource
	case 1						% Input from file
		disp(sprintf('Reading input displacement history from %s', handles.MDL.InputFile));
		disp_his = load(handles.MDL.InputFile);	% 6 column data
		tmp = size(disp_his);
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

% 1st step data	
handles = HoldCheck(handles);				% check for pause button is pressed. check this right before reading step data
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

while End_of_Command == 0				% until end of command is reached, 
	StepNo = StepNo + 1;							% count current step number
	ItrNo = 1;	
	handles.MDL.StepNos=StepNo;        %For RawMean.txt, SJKIM Oct24-2007
	handles.MDL.T_Disp_SC_his=handles.MDL.TransM * TGT;   % for the displacement history from text input or UI-SimCor step
	% Apply displacement -----------------------------------------------	
	tmpTGT = handles.MDL.TransM * (handles.MDL.DispScale.* TGT);			% convert target displacement to LBCB space
	% -------------------------------------------------------------------------------
	if handles.MDL.ItrElasticDeform		% if elastic deformation is accounted for
	% -------------------------------------------------------------------------------
		Increment=TGT-TGTlast;
		Adjusted_Command=Adjusted_Commandlast+Increment;
		Disp_Command = handles.MDL.TransM * (handles.MDL.DispScale.* Adjusted_Command);	% convert target displacement to LBCB space
		Forc_Command(handles.MDL.FrcCtrlDOF) = F_prev;					% only meaningful for mixed control
	else
		Disp_Command = handles.MDL.TransM * TGT;					% convert target displacement to LBCB space
		Forc_Command(handles.MDL.FrcCtrlDOF) = F_prev;					% only meaningful for mixed control
	end
	
	
	% Update monitoring
	time_s = clock;
	time_i = clock;
	
	if handles.MDL.UpdateMonitor
		disp(sprintf('Step %d -----------------------------',StepNo));
		set(handles.TXT_Disp_T_Model  , 'string', sprintf('%+12.5f\n', TGT));
		set(handles.TXT_Model_Tgt_Step, 'string', sprintf('Step #: %d',StepNo));
		set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Iteration #: %d',ItrNo));
		switch handles.MDL.CtrlMode 	
			case 1					% If displacement control mode
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n', Disp_Command));
			case 2					% If mixed control mode
				switch (handles.MDL.FrcCtrlDOF)
					case 1
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command(2:end)));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
					case 2
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1 3:end])));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
					case 3
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1:2 4:end])));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
					case 4                                                                                                                                         
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n', Disp_Command([1:3 5:end])));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n%+12.5f\n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
					case 5
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n', Disp_Command([1:4 6])));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n%+12.5f\n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
					case 6
						set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n', Disp_Command([1:5])));
						set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n%+12.5f\n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				end
		end  				
	end

	
	% -------------------------------------------------------------------------------
	if handles.MDL.ItrElasticDeform		% if elastic deformation is accounted for
	% -------------------------------------------------------------------------------
		% initialize iteration for elastic deformation
		delta_disp = 10*ones(6,1);
		ItrNo = 0;					% Increment iteration number
		% SJKIM Oct24-2007  
		% DispCtrlDOF = [1 2 3 4 5 6]' ~= handles.MDL.FrcCtrlDOF;  %'
		if handles.MDL.CtrlMode
			DispCtrlDOF = ones(6,1);
		else
			DispCtrlDOF = [1 2 3 4 5 6]' ~= handles.MDL.FrcCtrlDOF;  %'
		end
		
		% run while loop if displacement controlled DOFs error is larger than tolerance	
		while any(abs(delta_disp)>handles.MDL.DispTolerance & DispCtrlDOF) & ItrNo < handles.MDL.max_itr
			handles.MDL.T_Disp = Disp_Command;
			handles.MDL.T_Forc = Forc_Command;
			
			switch handles.MDL.CtrlMode
				case 1
				case 2
					handles.MDL.T_Disp(handles.MDL.FrcCtrlDOF) = tmpTGT(handles.MDL.FrcCtrlDOF);
			end
		
			accepted = 0;
			while accepted == 0
				accepted = LimitCheck(handles);
				handles  = HoldCheck(handles);
			end
			ItrNo = ItrNo+1;
			disp(sprintf('  Elastic Deformation %d',ItrNo)); 
			set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
			handles = propose_execute_substeps(handles);
			StatusIndicator(handles,23);	
			handles.MDL = query_mean(handles.MDL);
			StatusIndicator(handles,20);	
			handles.MDL.M_Disp = handles.MDL.M_Disp - offset;	%Remove offset
			
			if handles.MDL.UpdateMonitor
				updatePLOT(handles);
				set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
				set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
			end
			set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Disp. Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));
	
			delta_disp = handles.MDL.TransM*(handles.MDL.DispScale.*TGT) - handles.MDL.M_Disp;		% in LBCB space
			Adjusted_Command = Adjusted_Command + (inv(handles.MDL.TransM) * delta_disp)./handles.MDL.DispScale;						% in model space
			Disp_Command = handles.MDL.TransM * (handles.MDL.DispScale.* Adjusted_Command);			% in LBCB space
		end	
		Adjusted_Commandlast = Adjusted_Command;
		TGTlast = TGT;
	
	%-------------------------------------------------------------------------------
	else	% if elastic deformation is neglected
	%-------------------------------------------------------------------------------
		handles.MDL.T_Disp = tmpTGT;
		handles.MDL.T_Forc = Forc_Command;
	
		accepted = 0;
		while accepted == 0
			accepted = LimitCheck(handles);
			handles  = HoldCheck(handles);
		end

		disp(sprintf('  Elastic Deformation %d',ItrNo)); 
		set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
		handles = propose_execute_substeps(handles);
		StatusIndicator(handles,23);	
		handles.MDL = query_mean(handles.MDL);
		StatusIndicator(handles,20);	
		handles.MDL.M_Disp = handles.MDL.M_Disp - offset;	%Remove offset
		
		if handles.MDL.UpdateMonitor
			updatePLOT(handles);
			set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
			set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
		end
		set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Disp. Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));
	end
	
	% Apply force -----------------------------------------------		
	ItrNo = 1;								% Increment iteration number
	switch handles.MDL.CtrlMode
		case 1
		case 2
			F_prev = handles.MDL.M_Forc(handles.MDL.FrcCtrlDOF);	% Force of force controlled DOF, LBCB space
			D_prev = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);	% Force of displacement controlled DOF, LBCB space
			D_v(ItrNo) = D_prev;
			F_v(ItrNo) = F_prev;
			
			% Hold lateral displacement and apply vertical force
			Conv_Flag = 0;						% Flag to identify convergence
			K_F = handles.MDL.K_vert_ini;				% initial vertical stiffness at beginning of each iteration

			while (Conv_Flag == 0 )					% while it does not satisfy criteria
				% if target displacement is exceeded, end iteration
				if  (tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev_s) * (D_prev - tmpTGT(handles.MDL.FrcCtrlDOF)) > 0 
					Conv_Flag = 1;
					disp('Target displacement exceeded.');
				end
			
				% if within tolerance limit, end iteration
				if  abs(tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev)<handles.MDL.DispTolerance(handles.MDL.FrcCtrlDOF)
					Conv_Flag = 1;
					disp('Tolerance satisfied.');
				end
			
				% if maximum iteration reached
				if ItrNo >= handles.MDL.max_itr
					Conv_Flag = 1;
					disp('Maximum number of iteration reached.');
				end
	
				if Conv_Flag == 0 		
					ItrNo = ItrNo+1;							% increase iteration number
					F_target = F_prev + (tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev)*K_F;	% increase force from previous step
					Forc_Command(handles.MDL.FrcCtrlDOF) = F_target;			% update force command.
					handles.MDL.T_Forc = Forc_Command;
					time_i = clock;					
				
					if handles.MDL.UpdateMonitor
						set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Force Iteration #: %d',ItrNo));
						switch (handles.MDL.FrcCtrlDOF)
							case 1
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
							case 2
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
							case 3
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
							case 4                                                                                                                                         
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n%+12.5f\n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
							case 5
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n%+12.5f\n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
							case 6
								set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n%+12.5f\n', Forc_Command(handles.MDL.FrcCtrlDOF)));
						end
						disp(sprintf('  Iteration %d,  LBCB_DOF: %d   StepTarget D: %e,  IterationTarget F: %e',ItrNo,handles.MDL.FrcCtrlDOF,Disp_Command(handles.MDL.FrcCtrlDOF),Forc_Command(handles.MDL.FrcCtrlDOF)));
					end
					
					accepted = 0;
					while accepted == 0
						accepted = LimitCheck(handles);
						handles = HoldCheck(handles);
					end
				
					%handles = propose_execute_substeps(handles);
					StatusIndicator(handles,41);	handles.MDL = propose(handles.MDL); 	
					if handles.MDL.UpdateMonitor, updatePLOT(handles), end
					StatusIndicator(handles,42);	handles.MDL = execute(handles.MDL); 
					StatusIndicator(handles,43);	handles.MDL = query_mean(handles.MDL);
					StatusIndicator(handles,40);	
%disp(handles.MDL.M_AuxDisp);
					if handles.MDL.UpdateMonitor
						updatePLOT(handles);
						set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
						set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
					end
					set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Force Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));					

					F_prev = handles.MDL.M_Forc(handles.MDL.FrcCtrlDOF);
					D_prev = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);
				
					D_v(ItrNo) = D_prev;
					F_v(ItrNo) = F_prev;
	%					disp(sprintf('                 Current D: %e, Current F: %e',D_prev,F_prev));
				
					if ItrNo >= handles.MDL.secK_eval_itr		% if iteration goes over predefined steps, update secant stiffness
						%K_F = mean((F_v(j-secK_moving_average_window+2:j)-F_v(j-secK_moving_average_window+1:j-1))./(D_v(j-secK_moving_average_window+2:j)-D_v(j-secK_moving_average_window+1:j-1)))*secK_factor;
						tmp = polyfit(D_v(1:ItrNo),F_v(1:ItrNo),1);
						K_F = tmp(1)*handles.MDL.secK_factor;

						if K_F < handles.MDL.K_vert_ini		% if stiffness becomes smaller than lower bound stiffness, use lower bound stiffness
							K_F = handles.MDL.K_vert_ini;
						end
					end
				
					% Check Pause before getting command -----------------------------------------------
					handles = HoldCheck(handles);
					% -----------------------------------------------------------------------------------
				end
			end
			D_prev_s = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);		% vertical displacement.
		otherwise
	end

	handles.MDL.M_Disp = (inv(handles.MDL.TransM) * handles.MDL.M_Disp)./handles.MDL.DispScale;
	handles.MDL.M_Forc = (inv(handles.MDL.TransM) * handles.MDL.M_Forc)./handles.MDL.ForcScale;

	if handles.MDL.UpdateMonitor
		set(handles.TXT_Disp_M_Model, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
		set(handles.TXT_Forc_M_Model, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
	end
	set(handles.TXT_Model_Mes_Step, 'string', sprintf('Step #: %d   %5.2f sec',StepNo,etime(clock, time_s)));
	
	handles = HoldCheck(handles);
	StatusIndicator(handles,1);
	switch handles.MDL.InputSource
		case 1						% Input from file
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
				disp('Connection to UI-SimCor closed.                                     ');
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


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Pause.
% -------------------------------------------------------------------------------------------------
function PB_Pause_Callback(hObject, eventdata, handles)


% *************************************************************************************************
% *************************************************************************************************
% Check Boxes
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_MovingWindow.
% -------------------------------------------------------------------------------------------------
function CB_MovingWindow_Callback(hObject, eventdata, handles)

if get(hObject,'value')
	set(handles.Edit_Window_Size, 'enable', 	'on');
else
	set(handles.Edit_Window_Size, 'enable', 	'off');
end


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_Disp_Limit.
% -------------------------------------------------------------------------------------------------
function CB_Disp_Limit_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_DispTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLmin_DOF1, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF2, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF3, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF4, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF5, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF6, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF1, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF2, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF3, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF4, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF5, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF6, 'backgroundcolor',[1 1 1]);
end                                       
% guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_Forc_Limit.
% -------------------------------------------------------------------------------------------------
function CB_Forc_Limit_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_ForcTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_FLmin_DOF1, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF2, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF3, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF4, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF5, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF6, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF1, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF2, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF3, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF4, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF5, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF6, 'backgroundcolor',[1 1 1]);
end  
% guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_Disp_Inc.
% -------------------------------------------------------------------------------------------------
function CB_Disp_Inc_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_DispInc = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLinc_DOF1, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF2, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF3, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF4, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF5, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF6, 'backgroundcolor',[1 1 1]);
end      




% *************************************************************************************************
% *************************************************************************************************
% EDIT BOXES 
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
function Edit_PortNo_Callback(hObject, eventdata, handles)
function Edit_File_Path_Callback(hObject, eventdata, handles)
function Edit_LBCB_IP_Callback(hObject, eventdata, handles)
function Edit_LBCB_Port_Callback(hObject, eventdata, handles)
function Edit_K_low_Callback(hObject, eventdata, handles)
function Edit_Iteration_Ksec_Callback(hObject, eventdata, handles)
function Edit_K_factor_Callback(hObject, eventdata, handles)
function Edit_Max_Itr_Callback(hObject, eventdata, handles)
function Edit_Disp_SF_Callback(hObject, eventdata, handles)
function Edit_Rotation_SF_Callback(hObject, eventdata, handles)
function Edit_Forc_SF_Callback(hObject, eventdata, handles)
function Edit_Moment_SF_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF1_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF2_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF3_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF4_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF5_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF6_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF1_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF2_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF3_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF4_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF5_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF6_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF1_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF2_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF3_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF4_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF5_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF6_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF1_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF2_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF3_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF4_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF5_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF6_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF1_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF2_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF3_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF4_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF5_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF6_Callback(hObject, eventdata, handles)

% status indicator
function Edit_Waiting_CMD_Callback(hObject, eventdata, handles)
function Edit_Disp_Itr_Callback(hObject, eventdata, handles)
function Edit_Force_Itr_Callback(hObject, eventdata, handles)
function Edit_Step_Reduction_Callback(hObject, eventdata, handles)
function Edit_Propose_Callback(hObject, eventdata, handles)
function Edit_Execute_Callback(hObject, eventdata, handles)
function Edit_Querying_Callback(hObject, eventdata, handles)

function Edit_Sample_Size_Callback(hObject, eventdata, handles)
function Edit_Window_Size_Callback(hObject, eventdata, handles)

% *************************************************************************************************
% *************************************************************************************************
% Radio Buttons
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Source_Network.
% -------------------------------------------------------------------------------------------------
function RB_Source_Network_Callback(hObject, eventdata, handles)

set(handles.RB_Source_Network,	'value',	1);
set(handles.Edit_PortNo,	'enable',	'on');

set(handles.RB_Source_File,	'value',	0);
set(handles.Edit_File_Path,	'enable',	'off');
set(handles.PB_Load_File,	'enable',	'off');


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Source_File.
% -------------------------------------------------------------------------------------------------
function RB_Source_File_Callback(hObject, eventdata, handles)

set(handles.RB_Source_Network,	'value',	0);
set(handles.Edit_PortNo,	'enable',	'off');

set(handles.RB_Source_File,	'value',	1);
set(handles.Edit_File_Path,	'enable',	'on');
set(handles.PB_Load_File,	'enable',	'on');


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Disp_Ctrl.
% -------------------------------------------------------------------------------------------------
function RB_Disp_Ctrl_Callback(hObject, eventdata, handles)

set(handles.RB_Disp_Ctrl,		'value',	1);
set(handles.RB_Forc_Ctrl,		'value',	0);

set(handles.PM_Frc_Ctrl_DOF,		'enable',	'off');
set(handles.Edit_K_low,			'enable',	'off');
set(handles.Edit_Iteration_Ksec,	'enable',	'off');
set(handles.Edit_K_factor,		'enable',	'off');
set(handles.Edit_Max_Itr,		'enable',	'off');

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Forc_Ctrl.
% -------------------------------------------------------------------------------------------------
function RB_Forc_Ctrl_Callback(hObject, eventdata, handles)

set(handles.RB_Disp_Ctrl,		'value',	0);
set(handles.RB_Forc_Ctrl,		'value',	1);

set(handles.PM_Frc_Ctrl_DOF,		'enable',	'on');
set(handles.Edit_K_low,			'enable',	'on');
set(handles.Edit_Iteration_Ksec,	'enable',	'on');
set(handles.Edit_K_factor,		'enable',	'on');
set(handles.Edit_Max_Itr,		'enable',	'on');


% *************************************************************************************************
% *************************************************************************************************
% Popup Menus
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Model_Coord.
% -------------------------------------------------------------------------------------------------
function PM_Model_Coord_Callback(hObject, eventdata, handles)

handles.MDL.ModelCoord = get(hObject,'Value') ;
axes(handles.axes_model);
load Resources;
switch handles.MDL.ModelCoord
	case 1
		image(ModelCoord01); % Read the image file banner.bmp)		
	case 2
		image(ModelCoord02); % Read the image file banner.bmp)		
end
set(handles.axes_model, 'Visible', 'off');
guidata(hObject, handles);


% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_LBCB_Coord.
% -------------------------------------------------------------------------------------------------
function PM_LBCB_Coord_Callback(hObject, eventdata, handles)

handles.MDL.LBCBCoord = get(hObject,'Value') ;
load Resources;
axes(handles.axes_LBCB);
switch handles.MDL.LBCBCoord;
	case 1
		image(LBCB_R_Coord01); % Read the image file banner.bmp
	case 2
		image(LBCB_R_Coord02); % Read the image file banner.bmp
	case 3
		image(LBCB_R_Coord03); % Read the image file banner.bmp
	case 4
		image(LBCB_R_Coord04); % Read the image file banner.bmp
end
set(handles.axes_LBCB, 'Visible', 'off');
guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Frc_Ctrl_DOF.
% -------------------------------------------------------------------------------------------------
function PM_Frc_Ctrl_DOF_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_X1.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X1_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_X2.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X2_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y1.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y1_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y2.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y2_Callback(hObject, eventdata, handles)


% -------------------------------------------------------------------------------------------------
% --- Set transformation matrix
% -------------------------------------------------------------------------------------------------
function handles = SetTransMCoord(handles)

Model_Coord_No = get(handles.PM_Model_Coord,'value');
LBCB_Coord_No  = get(handles.PM_LBCB_Coord,'value');

TransM_No = (Model_Coord_No-1)*4 + LBCB_Coord_No;
switch TransM_No
	case 1
		direction_cosine = [	0 	90 	90
					90	90	0
					90	180	90];
	case 2
		direction_cosine = [	90 	180 	90
					90	90	0
					180	90	90];
	
	case 3
		direction_cosine = [	180 	90 	90
					90	90	0
					90	0	90];

	case 4
		direction_cosine = [	90 	 0 	90
					90	90	0
					0	90	90];

	case 5
		direction_cosine = [	0 	90 	90
					90	180	90
					90	90	180];

	case 6
		direction_cosine = [	90 	90 	180
					90	180	90
					180	90	90];

	case 7
		direction_cosine = [	180 	90 	90
					90	180	90
					90	90	0];

	case 8
		direction_cosine = [	90 	90 	0
					90	180	90
					0	90	90];

end
tmp1 = zeros(3,3);
tmp2 = cos(direction_cosine/180*pi) ;
handles.MDL.TransM = [tmp2 tmp1; tmp1 tmp2];
% disp('Coordinate transformation matrix is defined as following.');
% disp('   Values in LBCB coordiate = DirectionCosine * Values in Model coordinate');
% disp('   DirectionCosine = ');
% disp(handles.MDL.TransM);


% --- Executes on button press in CB_UpdateMonitor.
function CB_UpdateMonitor_Callback(hObject, eventdata, handles)
handles.MDL.UpdateMonitor = get(handles.CB_UpdateMonitor, 'value');
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


function CloseGUI

selection = questdlg('Closing GUI during simulation will interrupt the simulation. Do you want to close GUI?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
     delete(gcf)
   case 'No'
     return
end







% --- Executes on selection change in PM_Axis_Y3.
function PM_Axis_Y3_Callback(hObject, eventdata, handles)
% hObject    handle to PM_Axis_Y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PM_Axis_Y3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PM_Axis_Y3


% --- Executes during object creation, after setting all properties.
function PM_Axis_Y3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PM_Axis_Y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PM_Axis_X3.
function PM_Axis_X3_Callback(hObject, eventdata, handles)
% hObject    handle to PM_Axis_X3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PM_Axis_X3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PM_Axis_X3


% --- Executes during object creation, after setting all properties.
function PM_Axis_X3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PM_Axis_X3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CB_Noise_Compensation.
function CB_Noise_Compensation_Callback(hObject, eventdata, handles)



function Edit_Dtol_DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF1 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF1 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF2 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF2 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF3 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF3 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF4 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF4 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF5 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF5 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dtol_DOF6 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dtol_DOF6 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF1 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF1 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF2 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF2 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF3 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF3 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF4 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF4 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF5 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF5 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF6 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF6 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Processing_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Processing as text
%        str2double(get(hObject,'String')) returns contents of Edit_Processing as a double


% --- Executes during object creation, after setting all properties.
function Edit_Processing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


