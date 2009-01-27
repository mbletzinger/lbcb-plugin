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

% Last Modified by GUIDE v2.5 07-Feb-2008 00:55:48

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
% Push Buttons
% *************************************************************************************************
% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_LBCB_Connect. 
% -------------------------------------------------------------------------------------------------
function PB_LBCB_Connect_Callback(hObject, eventdata, handles)

error_bool=1;
if get(handles.RB_Source_File, 'value') & get(handles.PM_FileInput_Select,'value')==1
	errordlg('One input file should be selected!','Data Error');
	error_bool=0;
end

if error_bool==1
	if strcmp(lower(get(handles.AUXModule_Connect,'enable')),'on')
		QuestResult = questdlg('AUX Modules are not connected. Simulation will not proceed except the first query to LBCB. Continue?', 'Warning','Okay','Cancel','Cancel');
		if strcmp(QuestResult,'Cancel')
			error_bool=0;
		end 
	end
end

if error_bool==1
	handles.MDL.IP 	 = get(handles.Edit_LBCB_IP,	    	'String');
	handles.MDL.Port = str2num(get(handles.Edit_LBCB_Port,	'String'));
	
	GUI_tmp_str ='Connecting to LBCB ..........................';
	disp(GUI_tmp_str);
	UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
	
	handles.MDL.Comm_obj = tcpip(handles.MDL.IP,handles.MDL.Port);            % create TCPIP obj(objInd)ect
	set(handles.MDL.Comm_obj,'InputBufferSize', 1024*100);                    % set buffer size
	handles.MDL = open(handles.MDL);
	
	GUI_tmp_str ='Connection is established with LBCB.';
	disp(GUI_tmp_str);
	UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
	
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
	
	
	% Run Simulation;
	Run_Simulation(hObject, eventdata, handles);   
end

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_LBCB_Disconnect.
% -------------------------------------------------------------------------------------------------
function PB_LBCB_Disconnect_Callback(hObject, eventdata, handles)

quest_str={'Disconnect from LBCB? All variables will be initialized.';'Select ''Reconnect'' if you want to disconnect and reconnect LBCB.'};
button = questdlg(quest_str,'Disconnect','Yes','Reconnect','No','No');
switch button
	case 'Yes'
		GUI_tmp_str ='Simulation has successfully completed. ';
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		close(handles.MDL);

		GUI_tmp_str ='Connection to remote site is closed. ';
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		
		handles = readGUI(handles);
		handles = Plugin_Initialize(handles,2); 				% Initialize values
		
		guidata(hObject, handles);
	case 'Reconnect'
		close(handles.MDL);

		GUI_tmp_str ='Connection to remote site is closed. ';
		disp(GUI_tmp_str);
		UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
		
		tmp_bool=1;
		while tmp_bool~=-1
			button2 = questdlg('Make sure that OM is ready to connect. Ready?','Reconnection','Yes','No','Cancel','Yes');
			switch button2
				case 'Yes'
					handles.MDL = open(handles.MDL);
					GUI_tmp_str ='Connection is established with LBCB.';
					disp(GUI_tmp_str);
					UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
					tmp_bool=-1;
				case 'Cancel'
					tmp_bool=-1;
				case 'No'
			end
		end			
	case 'No'
end


% -------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_Load_File.
% -------------------------------------------------------------------------------------------------
function PB_Load_File_Callback(hObject, eventdata, handles)

[file,path] = uigetfile({'*.txt';'*.dat';'*.m';'*.mdl';'*.mat';'*.*'},'Load displacement history.');
if file ~= 0
	CurDir=sprintf('%s\\',cd);
	if strcmp(CurDir,path)
		set(handles.Edit_File_Path, 'String',file);
	else
		set(handles.Edit_File_Path, 'String',[path file]);
	end
	
	%set(handles.Edit_File_Path, 'String',[path file]);
	%handles.MDL.InputFile = [path file];
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

	save([path file], 'MDL');
end

% -------------------------------------------------------------------------------------------------
% --- Run Simulation 
% -------------------------------------------------------------------------------------------------


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

set(handles.PM_FileInput_Select,    'enable', 'off');
set(handles.Edit_FileInput_Add_Num, 'enable', 'off');
set(handles.PB_FileInput_Add,       'enable', 'off');
set(handles.PB_Input_Plot,          'enable', 'off');

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Source_File.
% -------------------------------------------------------------------------------------------------
function RB_Source_File_Callback(hObject, eventdata, handles)

set(handles.RB_Source_Network,	'value',	0);
set(handles.Edit_PortNo,	'enable',	'off');

set(handles.RB_Source_File,	'value',	1);
set(handles.Edit_File_Path,	'enable',	'on');
set(handles.PB_Load_File,	'enable',	'on');

set(handles.PM_FileInput_Select,    'enable', 'on');
set(handles.Edit_FileInput_Add_Num, 'enable', 'on');
set(handles.PB_FileInput_Add,       'enable', 'on');
set(handles.PB_Input_Plot,          'enable', 'on');

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Disp_Ctrl.
% -------------------------------------------------------------------------------------------------
function RB_Disp_Ctrl_Callback(hObject, eventdata, handles)

set(handles.RB_Disp_Ctrl,		'value',	1);
set(handles.RB_Forc_Ctrl,		'value',	0);
set(handles.RB_MixedControl_Static,	'value',0);
handles.MDL.CtrlMode = 1;

handles.MDL.LBCB_FrcCtrlDOF = zeros(6,1);
handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);

set(handles.PM_Frc_Ctrl_DOF,		'enable',	'off');
set(handles.Edit_K_low,			'enable',	'off');
set(handles.Edit_Iteration_Ksec,	'enable',	'off');
set(handles.Edit_K_factor,		'enable',	'off');
set(handles.Edit_Max_Itr,		'enable',	'on');

set(handles.CB_MixedCtrl_Fx,	'value',	0);
set(handles.CB_MixedCtrl_Fy,	'value',	0);
set(handles.CB_MixedCtrl_Fz,	'value',	0);
set(handles.CB_MixedCtrl_Mx,	'value',	0);
set(handles.CB_MixedCtrl_My,	'value',	0);
set(handles.CB_MixedCtrl_Mz,	'value',	0);

set(handles.CB_MixedCtrl_Fx,	'enable',	'off');
set(handles.CB_MixedCtrl_Fy,	'enable',	'off');
set(handles.CB_MixedCtrl_Fz,	'enable',	'off');
set(handles.CB_MixedCtrl_Mx,	'enable',	'off');
set(handles.CB_MixedCtrl_My,	'enable',	'off');
set(handles.CB_MixedCtrl_Mz,	'enable',	'off');

% update static text 
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);
guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_Forc_Ctrl.
% -------------------------------------------------------------------------------------------------
function RB_Forc_Ctrl_Callback(hObject, eventdata, handles)

set(handles.RB_Disp_Ctrl,		'value',	0);
set(handles.RB_Forc_Ctrl,		'value',	1);
set(handles.RB_MixedControl_Static,	'value',0);
handles.MDL.CtrlMode = 2;

set(handles.PM_Frc_Ctrl_DOF,		'enable',	'on');
set(handles.Edit_K_low,			'enable',	'on');
set(handles.Edit_Iteration_Ksec,	'enable',	'on');
set(handles.Edit_K_factor,		'enable',	'on');
set(handles.Edit_Max_Itr,		'enable',	'on');

set(handles.CB_MixedCtrl_Fx,	'value',	0);
set(handles.CB_MixedCtrl_Fy,	'value',	0);
set(handles.CB_MixedCtrl_Fz,	'value',	0);
set(handles.CB_MixedCtrl_Mx,	'value',	0);
set(handles.CB_MixedCtrl_My,	'value',	0);
set(handles.CB_MixedCtrl_Mz,	'value',	0);

set(handles.CB_MixedCtrl_Fx,	'enable',	'off');
set(handles.CB_MixedCtrl_Fy,	'enable',	'off');
set(handles.CB_MixedCtrl_Fz,	'enable',	'off');
set(handles.CB_MixedCtrl_Mx,	'enable',	'off');
set(handles.CB_MixedCtrl_My,	'enable',	'off');
set(handles.CB_MixedCtrl_Mz,	'enable',	'off');

set(handles.CB_MixedCtrl_Fx,	'value',	0);
set(handles.CB_MixedCtrl_Fy,	'value',	0);
set(handles.CB_MixedCtrl_Fz,	'value',	0);
set(handles.CB_MixedCtrl_Mx,	'value',	0);
set(handles.CB_MixedCtrl_My,	'value',	0);
set(handles.CB_MixedCtrl_Mz,	'value',	0);

set(handles.CB_MixedCtrl_Fx,	'enable',	'off');
set(handles.CB_MixedCtrl_Fy,	'enable',	'off');
set(handles.CB_MixedCtrl_Fz,	'enable',	'off');
set(handles.CB_MixedCtrl_Mx,	'enable',	'off');
set(handles.CB_MixedCtrl_My,	'enable',	'off');
set(handles.CB_MixedCtrl_Mz,	'enable',	'off');

handles.MDL.LBCB_FrcCtrlDOF = zeros(6,1);
handles.MDL.LBCB_FrcCtrlDOF(get(handles.PM_Frc_Ctrl_DOF,	'Value')) = 1;
handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
% update static text 
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);
guidata(hObject, handles);

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
handles = SetTransMCoord(handles); 
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
handles = SetTransMCoord(handles); 
guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Frc_Ctrl_DOF.
% -------------------------------------------------------------------------------------------------
function PM_Frc_Ctrl_DOF_Callback(hObject, eventdata, handles)

handles.MDL.LBCB_FrcCtrlDOF = zeros(6,1);
handles.MDL.LBCB_FrcCtrlDOF(get(handles.PM_Frc_Ctrl_DOF,	'Value')) = 1;
handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
% update static text 
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);
guidata(hObject, handles);
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

% --- Executes on selection change in PM_Axis_Y3.
function PM_Axis_Y3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function PM_Axis_Y3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in PM_Axis_X3.
function PM_Axis_X3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function PM_Axis_X3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CB_Noise_Compensation.
function CB_Noise_Compensation_Callback(hObject, eventdata, handles)

function Edit_Dtol_DOF1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dtol_DOF2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dtol_DOF3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dtol_DOF4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dtol_DOF5_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dtol_DOF6_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF3_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF4_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF5_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Dsub_DOF6_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------------------------------------------------------
% Mixed mode control 2 (Static), by Sung Jig Kim, Dec 19, 2007
%---------------------------------------------------------------------------------------------------------------
% --- Executes on button press in RB_MixedControl_Static.
function RB_MixedControl_Static_Callback(hObject, eventdata, handles)
% hObject    handle to RB_MixedControl_Static (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_MixedControl_Static

% Static Modlue
set(handles.RB_Disp_Ctrl,	'value',0)
set(handles.RB_Forc_Ctrl,		'value',	0);
set(handles.RB_MixedControl_Static,	'value',1);

handles.MDL.CtrlMode = 3;

handles.MDL.LBCB_FrcCtrlDOF(1) = get(handles.CB_MixedCtrl_Fx,'value');
handles.MDL.LBCB_FrcCtrlDOF(2) = get(handles.CB_MixedCtrl_Fy,'value');
handles.MDL.LBCB_FrcCtrlDOF(3) = get(handles.CB_MixedCtrl_Fz,'value');
handles.MDL.LBCB_FrcCtrlDOF(4) = get(handles.CB_MixedCtrl_Mx,'value');
handles.MDL.LBCB_FrcCtrlDOF(5) = get(handles.CB_MixedCtrl_My,'value');
handles.MDL.LBCB_FrcCtrlDOF(6) = get(handles.CB_MixedCtrl_Mz,'value');

set(handles.PM_Frc_Ctrl_DOF,		'enable',	'off');
set(handles.Edit_K_low,			'enable',	'off');
set(handles.Edit_Iteration_Ksec,	'enable',	'off');
set(handles.Edit_K_factor,		'enable',	'off');
set(handles.Edit_Max_Itr,		'enable',	'on');

set(handles.CB_MixedCtrl_Fx,	'enable',	'on');
set(handles.CB_MixedCtrl_Fy,	'enable',	'on');
set(handles.CB_MixedCtrl_Fz,	'enable',	'on');
set(handles.CB_MixedCtrl_Mx,	'enable',	'on');
set(handles.CB_MixedCtrl_My,	'enable',	'on');
set(handles.CB_MixedCtrl_Mz,	'enable',	'on');

handles = SetTransMCoord(handles); 

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);

UpdateMonitorPanel (handles, 100);


UpdateGUI_FontColor (handles, 1);
% Initialize check button
       
guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_Fx.
function CB_MixedCtrl_Fx_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_Fx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_Fx

if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Dx, 'visible', 'off');              
	set(handles.User_Cmd_Txt_Fx, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(1) = 1;
else
	set(handles.User_Cmd_Txt_Dx, 'visible', 'on');              
	set(handles.User_Cmd_Txt_Fx, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(1) = 0;
end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_Fy.
function CB_MixedCtrl_Fy_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_Fy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_Fy
if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Dy, 'visible', 'off');              
	set(handles.User_Cmd_Txt_Fy, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(2) = 1;
else
	set(handles.User_Cmd_Txt_Dy, 'visible', 'on');              
	set(handles.User_Cmd_Txt_Fy, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(2) = 0;

end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_Fz.
function CB_MixedCtrl_Fz_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_Fz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_Fz
if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Dz, 'visible', 'off');              
	set(handles.User_Cmd_Txt_Fz, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(3) = 1;

else
	set(handles.User_Cmd_Txt_Dz, 'visible', 'on');              
	set(handles.User_Cmd_Txt_Fz, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(3) = 0;

end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_Mx.
function CB_MixedCtrl_Mx_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_Mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_Mx
if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Rx, 'visible', 'off');              
	set(handles.User_Cmd_Txt_Mx, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(4) = 1;

else
	set(handles.User_Cmd_Txt_Rx, 'visible', 'on');              
	set(handles.User_Cmd_Txt_Mx, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(4) = 0;

end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_My.
function CB_MixedCtrl_My_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_My (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_My
if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Ry, 'visible', 'off');              
	set(handles.User_Cmd_Txt_My, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(5) = 1;
else
	set(handles.User_Cmd_Txt_Ry, 'visible', 'on');              
	set(handles.User_Cmd_Txt_My, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(5) = 0;
end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

% --- Executes on button press in CB_MixedCtrl_Mz.
function CB_MixedCtrl_Mz_Callback(hObject, eventdata, handles)
% hObject    handle to CB_MixedCtrl_Mz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_MixedCtrl_Mz
if get(hObject,'Value')
	set(handles.User_Cmd_Txt_Rz, 'visible', 'off');              
	set(handles.User_Cmd_Txt_Mz, 'visible', 'on'); 
	handles.MDL.LBCB_FrcCtrlDOF(6) = 1;

else
	set(handles.User_Cmd_Txt_Rz, 'visible', 'on');              
	set(handles.User_Cmd_Txt_Mz, 'visible', 'off'); 
	handles.MDL.LBCB_FrcCtrlDOF(6) = 0;

end

handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
UpdateMonitorPanel (handles, 100);

UpdateGUI_FontColor (handles, 1);

guidata(hObject, handles);

%---------------------------------------------------------------------------------------------------------
% User Input Option, 11/27/2007, Sung Jig Kim
%---------------------------------------------------------------------------------------------------------
% --- Executes on button press in UserInputOption_On.
function UserInputOption_On_Callback(hObject, eventdata, handles)
% hObject    handle to UserInputOption_On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UserInputOption_On
set(handles.UserInputOption_On, 'value' , 1)
set(handles.UserInputOption_Off, 'value', 0);
set(handles.User_Cmd_DOF1,  'enable', 'on');
set(handles.User_Cmd_DOF2,  'enable', 'on');
set(handles.User_Cmd_DOF3,  'enable', 'on');
set(handles.User_Cmd_DOF4,  'enable', 'on');
set(handles.User_Cmd_DOF5,  'enable', 'on');
set(handles.User_Cmd_DOF6,  'enable', 'on');
set(handles.User_Cmd_Txt_Dx, 'enable', 'on');              
set(handles.User_Cmd_Txt_Dy, 'enable', 'on');              
set(handles.User_Cmd_Txt_Dz, 'enable', 'on');              
set(handles.User_Cmd_Txt_Rx, 'enable', 'on');              
set(handles.User_Cmd_Txt_Ry, 'enable', 'on');              
set(handles.User_Cmd_Txt_Rz, 'enable', 'on');              
set(handles.User_Cmd_Txt_Fx, 'enable', 'on');              
set(handles.User_Cmd_Txt_Fy, 'enable', 'on');              
set(handles.User_Cmd_Txt_Fz, 'enable', 'on');              
set(handles.User_Cmd_Txt_Mx, 'enable', 'on');              
set(handles.User_Cmd_Txt_My, 'enable', 'on');              
set(handles.User_Cmd_Txt_Mz, 'enable', 'on'); 
set(handles.STR_UserInput_PreviousTarget,             'enable', 'on');
set(handles.UserInputOption_M_AdjustedCMD, 'enable', 'on');
set(handles.STXT_AdjustedCMD, 'enable', 'on');

set(handles.PB_UserCMD_Pre_DOF1,        'enable', 'on');
set(handles.PB_UserCMD_Pre_DOF2,        'enable', 'on');
set(handles.PB_UserCMD_Pre_DOF3,        'enable', 'on');
set(handles.PB_UserCMD_Pre_DOF4,        'enable', 'on');
set(handles.PB_UserCMD_Pre_DOF5,        'enable', 'on');
set(handles.PB_UserCMD_Pre_DOF6,        'enable', 'on');

set(handles.PB_UserCMD_Decrease_DOF1,   'enable', 'on');
set(handles.PB_UserCMD_Decrease_DOF2,   'enable', 'on');
set(handles.PB_UserCMD_Decrease_DOF3,   'enable', 'on');
set(handles.PB_UserCMD_Decrease_DOF4,   'enable', 'on');
set(handles.PB_UserCMD_Decrease_DOF5,   'enable', 'on');
set(handles.PB_UserCMD_Decrease_DOF6,   'enable', 'on');

set(handles.PB_UserCMD_Increase_DOF1,   'enable', 'on');
set(handles.PB_UserCMD_Increase_DOF2,   'enable', 'on');
set(handles.PB_UserCMD_Increase_DOF3,   'enable', 'on');
set(handles.PB_UserCMD_Increase_DOF4,   'enable', 'on');
set(handles.PB_UserCMD_Increase_DOF5,   'enable', 'on');
set(handles.PB_UserCMD_Increase_DOF6,   'enable', 'on');

set(handles.ED_UserCMD_Increment_DOF1,  'enable', 'on');
set(handles.ED_UserCMD_Increment_DOF2,  'enable', 'on');
set(handles.ED_UserCMD_Increment_DOF3,  'enable', 'on');
set(handles.ED_UserCMD_Increment_DOF4,  'enable', 'on');
set(handles.ED_UserCMD_Increment_DOF5,  'enable', 'on');
set(handles.ED_UserCMD_Increment_DOF6,  'enable', 'on');

guidata(hObject, handles);

% --- Executes on button press in UserInputOption_Off.
function UserInputOption_Off_Callback(hObject, eventdata, handles)
% hObject    handle to UserInputOption_Off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UserInputOption_Off
set(handles.UserInputOption_Off, 'value',1)
set(handles.UserInputOption_On, 'value', 0);
set(handles.User_Cmd_DOF1,   'enable', 'off');
set(handles.User_Cmd_DOF2,   'enable', 'off');
set(handles.User_Cmd_DOF3,   'enable', 'off');
set(handles.User_Cmd_DOF4,   'enable', 'off');
set(handles.User_Cmd_DOF5,   'enable', 'off');
set(handles.User_Cmd_DOF6,   'enable', 'off');
set(handles.User_Cmd_Txt_Dx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Ry, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mx, 'enable', 'off');              
set(handles.User_Cmd_Txt_My, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mz, 'enable', 'off'); 

set(handles.STR_UserInput_PreviousTarget,             'enable', 'off');
set(handles.UserInputOption_M_AdjustedCMD, 'value', 0);
set(handles.UserInputOption_M_AdjustedCMD, 'enable', 'off');
set(handles.STXT_AdjustedCMD, 'enable', 'off');

set(handles.PB_UserCMD_Pre_DOF1,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF2,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF3,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF4,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF5,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF6,        'enable', 'off');

set(handles.PB_UserCMD_Decrease_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF6,   'enable', 'off');

set(handles.PB_UserCMD_Increase_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF6,   'enable', 'off');

set(handles.ED_UserCMD_Increment_DOF1,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF2,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF3,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF4,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF5,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF6,  'enable', 'off');

guidata(hObject, handles);

% Manual Command
function User_Cmd_DOF1_Callback(hObject, eventdata, handles)
function User_Cmd_DOF1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function User_Cmd_DOF2_Callback(hObject, eventdata, handles)
function User_Cmd_DOF2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function User_Cmd_DOF3_Callback(hObject, eventdata, handles)
function User_Cmd_DOF3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function User_Cmd_DOF4_Callback(hObject, eventdata, handles)
function User_Cmd_DOF4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function User_Cmd_DOF5_Callback(hObject, eventdata, handles)
function User_Cmd_DOF5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function User_Cmd_DOF6_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function User_Cmd_DOF6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%---------------------------------------------------------------------------------------------------------
% AUX modules, 11/27/2007, Sung Jig Kim
%---------------------------------------------------------------------------------------------------------

% --- Executes on button press in AUXModule_Connect.
function AUXModule_Connect_Callback(hObject, eventdata, handles)
% hObject    handle to AUXModule_Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Connect Each module
GUI_tmp_str ='Connecting to Camera and DAQ ................';
disp(GUI_tmp_str);
UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 
handles.AUX = open(handles.AUX,1);

% Enable LBCB Connection
%set(handles.PB_LBCB_Connect,	'enable',	'on');

GUI_tmp_str ='Connecting is established with Camera and DAQ ...';
disp(GUI_tmp_str);
UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1); 

set(handles.AUXModule_Disconnect,	'enable',	'on');
set(handles.AUXModule_Connect,	'enable',	'off');

guidata(hObject, handles);

% --- Executes on button press in AUXModule_Disconnect.
function AUXModule_Disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to AUXModule_Disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


button = questdlg('Disconnect from Camera and DAQ? ','Disconnect','Disconnect All','Select Module','No','Select Module');
switch button
	case 'Disconnect All'
		button2 = questdlg('Is simulation completed?','Disconnect','Yes','No','No');
		if strcmp(button2,'Yes')
			GUI_tmp_str ='Simulation has successfully completed.      ';
			disp(GUI_tmp_str);
			UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1);
			close(handles.AUX,1);
	
			GUI_tmp_str ='Connection to remote site is closed.     ';
			disp(GUI_tmp_str);
			UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1);
	
			set(handles.AUXModule_Disconnect,	'enable',	'off');
			set(handles.AUXModule_Connect,	'enable',	'on');
			
			AUX_Initialized=get(handles.AUXModule_Connect, 'UserData'); 
			AUX_Initialized=AUX_Initialized*0;	
			set(handles.AUXModule_Connect, 'UserData', AUX_Initialized); 		
		end
	case 'Select Module'
		for i=1:length(handles.AUX)
			ListStr{1,i}=handles.AUX(i).name;
		end
		% SelectModule
		[s,v] = listdlg('PromptString','Select AUX modules',...
		                'SelectionMode','Multiple',...
		                'ListSize',[160,100],...
		                'ListString',ListStr);
		if v
			Num_discont_module=length(s);
			close(handles.AUX,Num_discont_module,s);
			
			AUX_Initialized=get(handles.AUXModule_Connect, 'UserData'); 
			for i=1:length(s)
				GUI_tmp_str =sprintf('Connection to %s is closed. ',handles.AUX(s(i)).name );
				AUX_Initialized(s(i))=0;
				disp(GUI_tmp_str);
				UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,1);
			end
			button2 = questdlg('Reconnect modules?','Reconnect','Yes','No','Yes');
			switch button2
				case 'Yes'
					handles.AUX = open(handles.AUX,Num_discont_module,s);
					for i=1:length(s)
						AUX_Initialized(s(i))=1;
					end
				case 'No'
			end
			set(handles.AUXModule_Connect, 'UserData', AUX_Initialized); 
		end
		
	case 'No'
end
guidata(hObject, handles);

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


% --- Executes on button press in RB_Monitor_Coord_Model.
function RB_Monitor_Coord_Model_Callback(hObject, eventdata, handles)
% hObject    handle to RB_Monitor_Coord_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_Monitor_Coord_Model

tmp_bool=get(handles.RB_Monitor_Coord_LBCB,  'value');  
set(handles.RB_Monitor_Coord_Model, 'value' ,1);
set(handles.RB_Monitor_Coord_LBCB,  'value' ,0);    

if tmp_bool
	Transform = inv(handles.MDL.TransM);
	UpdateMonitorPanel (handles, 101, Transform, handles.MDL.LBCB_FrcCtrlDOF);
end



guidata(hObject, handles);

% --- Executes on button press in RB_Monitor_Coord_LBCB.
function RB_Monitor_Coord_LBCB_Callback(hObject, eventdata, handles)
% hObject    handle to RB_Monitor_Coord_LBCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_Monitor_Coord_LBCB

tmp_bool=get(handles.RB_Monitor_Coord_Model,  'value'); 

set(handles.RB_Monitor_Coord_Model, 'value' ,0);
set(handles.RB_Monitor_Coord_LBCB,  'value' ,1);

if tmp_bool
	Transform = handles.MDL.TransM;
	UpdateMonitorPanel (handles, 101, Transform, handles.MDL.Model_FrcCtrlDOF);
end


guidata(hObject, handles);

function ET_GUI_Process_Text_Callback(hObject, eventdata, handles)
% hObject    handle to ET_GUI_Process_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ET_GUI_Process_Text as text
%        str2double(get(hObject,'String')) returns contents of ET_GUI_Process_Text as a double

	%% Update GUI text
	%tmpstr = get(varargin{1}{2},'string');
	%max_num_row  = 8;	% maximum number of rows
	%tmpstr = {tmpstr{:} varargin{2}};
	%curLength = length(tmpstr);
	%if curLength>max_num_row
	%	tmpstr = {tmpstr{curLength-max_num_row+1:curLength}};
	%end
    %
	%set(varargin{1}{2},'string',tmpstr)

% --- Executes during object creation, after setting all properties.
function ET_GUI_Process_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ET_GUI_Process_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RB_PlotData_ModelStep.
function RB_PlotData_ModelStep_Callback(hObject, eventdata, handles)
% hObject    handle to RB_PlotData_ModelStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_PlotData_ModelStep

set(handles.RB_PlotData_ModelStep,     'value' ,1);
set(handles.RB_PlotData_LBCBStep,      'value' ,0);
guidata(hObject, handles);

% --- Executes on button press in RB_PlotData_LBCBStep.
function RB_PlotData_LBCBStep_Callback(hObject, eventdata, handles)
% hObject    handle to RB_PlotData_LBCBStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_PlotData_LBCBStep

set(handles.RB_PlotData_ModelStep,     'value' ,0);
set(handles.RB_PlotData_LBCBStep,      'value' ,1);
guidata(hObject, handles);


% --- Executes on button press in PB_UserCMD_Pre_DOF1.
function PB_UserCMD_Pre_DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF1,        'string');
set(handles.User_Cmd_DOF1,   'string', PreCMD);
guidata(hObject, handles);

% --- Executes on button press in PB_UserCMD_Pre_DOF2.
function PB_UserCMD_Pre_DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF2,        'string');
set(handles.User_Cmd_DOF2,   'string', PreCMD);
guidata(hObject, handles);

% --- Executes on button press in PB_UserCMD_Pre_DOF3.
function PB_UserCMD_Pre_DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF3,        'string');
set(handles.User_Cmd_DOF3,   'string', PreCMD);
guidata(hObject, handles);

% --- Executes on button press in PB_UserCMD_Pre_DOF4.
function PB_UserCMD_Pre_DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF4,        'string');
set(handles.User_Cmd_DOF4,   'string', PreCMD);
guidata(hObject, handles);

% --- Executes on button press in PB_UserCMD_Pre_DOF5.
function PB_UserCMD_Pre_DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF5,        'string');
set(handles.User_Cmd_DOF5,   'string', PreCMD);
guidata(hObject, handles);

% --- Executes on button press in PB_UserCMD_Pre_DOF6.
function PB_UserCMD_Pre_DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Pre_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PreCMD=get(handles.PB_UserCMD_Pre_DOF6,        'string');
set(handles.User_Cmd_DOF6,   'string', PreCMD);
guidata(hObject, handles);

function PB_UserCMD_Increase_DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF1, handles.ED_UserCMD_Increment_DOF1, handles.MDL.LBCB_FrcCtrlDOF(1)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Decrease_DOF1.
function PB_UserCMD_Decrease_DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF1, handles.ED_UserCMD_Increment_DOF1, handles.MDL.LBCB_FrcCtrlDOF(1)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Increase_DOF2.
function PB_UserCMD_Increase_DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF2, handles.ED_UserCMD_Increment_DOF2, handles.MDL.LBCB_FrcCtrlDOF(2)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Decrease_DOF2.
function PB_UserCMD_Decrease_DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF2, handles.ED_UserCMD_Increment_DOF2, handles.MDL.LBCB_FrcCtrlDOF(2)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Increase_DOF3.
function PB_UserCMD_Increase_DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF3, handles.ED_UserCMD_Increment_DOF3, handles.MDL.LBCB_FrcCtrlDOF(3)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Decrease_DOF3.
function PB_UserCMD_Decrease_DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF3, handles.ED_UserCMD_Increment_DOF3, handles.MDL.LBCB_FrcCtrlDOF(3)};
UpdateUserCMD (handles_val, Incr_Decr);


% --- Executes on button press in PB_UserCMD_Increase_DOF4.
function PB_UserCMD_Increase_DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF4, handles.ED_UserCMD_Increment_DOF4, handles.MDL.LBCB_FrcCtrlDOF(4)};
UpdateUserCMD (handles_val, Incr_Decr);


% --- Executes on button press in PB_UserCMD_Decrease_DOF4.
function PB_UserCMD_Decrease_DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF4, handles.ED_UserCMD_Increment_DOF4, handles.MDL.LBCB_FrcCtrlDOF(4)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Increase_DOF5.
function PB_UserCMD_Increase_DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF5, handles.ED_UserCMD_Increment_DOF5, handles.MDL.LBCB_FrcCtrlDOF(5)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Decrease_DOF5.
function PB_UserCMD_Decrease_DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF5, handles.ED_UserCMD_Increment_DOF5, handles.MDL.LBCB_FrcCtrlDOF(5)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Increase_DOF6.
function PB_UserCMD_Increase_DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Increase_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = 1;
handles_val = {handles.User_Cmd_DOF6, handles.ED_UserCMD_Increment_DOF6, handles.MDL.LBCB_FrcCtrlDOF(6)};
UpdateUserCMD (handles_val, Incr_Decr);

% --- Executes on button press in PB_UserCMD_Decrease_DOF6.
function PB_UserCMD_Decrease_DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to PB_UserCMD_Decrease_DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Incr_Decr = -1;
handles_val = {handles.User_Cmd_DOF6, handles.ED_UserCMD_Increment_DOF6, handles.MDL.LBCB_FrcCtrlDOF(6)};
UpdateUserCMD (handles_val, Incr_Decr);

% Increment for USER OPtion
function ED_UserCMD_Increment_DOF1_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function ED_UserCMD_Increment_DOF1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ED_UserCMD_Increment_DOF2_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function ED_UserCMD_Increment_DOF2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ED_UserCMD_Increment_DOF3_Callback(hObject, eventdata, handles)
function ED_UserCMD_Increment_DOF3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ED_UserCMD_Increment_DOF4_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function ED_UserCMD_Increment_DOF4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ED_UserCMD_Increment_DOF5_Callback(hObject, eventdata, handles)
function ED_UserCMD_Increment_DOF5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ED_UserCMD_Increment_DOF6_Callback(hObject, eventdata, handles)
function ED_UserCMD_Increment_DOF6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_FileInput_Add.
function PB_FileInput_Add_Callback(hObject, eventdata, handles)
% hObject    handle to PB_FileInput_Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Input_Num     = str2num(get(handles.Edit_FileInput_Add_Num, 'string'));
InputFilePath = get(handles.Edit_File_Path, 'String');
Tmp_FileName  = strread(InputFilePath,'%s','delimiter','\\');
InputFileName = Tmp_FileName{end};

Tmp_UserData= get(handles.PB_Input_Plot, 'UserData');
Sim_Index=Tmp_UserData(1);CurStepNo=Tmp_UserData(2);

handles.MDL.InputFilePath=get(handles.PM_FileInput_Select, 'UserData');
% Effor check
Error_bool=0;
if floor(Input_Num)<=0 | (floor(Input_Num)~=Input_Num)
	errordlg('Number is not integer!. Try again!','File Number Error');
	Error_bool=1;
else
	if exist(InputFilePath)~=0
		Tmp_checkData=load (InputFilePath);
		[R_n,C_n]=size(Tmp_checkData);
		if C_n~=6
			errordlg('Number of Coulum should be 6!. Try again!','Data Error');
			Error_bool=1;
		end 
		
		if Input_Num > 1
			ReferData=load (handles.MDL.InputFilePath{1});
			[R_Rn,R_Cn]=size(ReferData);
			
			if R_Rn~=R_n
				errordlg('Number of Row is different from that of previous file!. Try again!','Data Error');
				Error_bool=1;
			end
		end
	else
		Err_String=sprintf ('%s does not exist!',InputFilePath);
		errordlg(Err_String,'File Error');
		Error_bool=1;
	end
end

% Assign the input file
if Error_bool==0
	
	InputFile_List=get (handles.PM_FileInput_Select, 'string');
	if length(InputFile_List)>=Input_Num+1
		if isempty(handles.MDL.InputFilePath{Input_Num,1})
			ModifiedList=InputFile_List;
			ModifiedList{Input_Num+1}=sprintf('Input %02d: %s', Input_Num, InputFileName);
		else
			quest_str=sprintf('%s already exists in the list. Do you want to replace it?',handles.MDL.InputFilePath{Input_Num,1});
			questResult = questdlg(quest_str,'File Exist','Yes','No','No'); 
			if strcmp(questResult,'Yes')
				ModifiedList=InputFile_List;
				ModifiedList{Input_Num+1}=sprintf('Input %02d: %s', Input_Num, InputFileName);
			else
				Error_bool=1;
			end
		end		
	else
		ModifiedList=cell(Input_Num+1,1);
		for i=1:length(InputFile_List)
			ModifiedList{i}=InputFile_List{i};
		end
		ModifiedList{Input_Num+1}=sprintf('Input %02d: %s', Input_Num, InputFileName);
		for i=2:Input_Num+1
			if isempty(ModifiedList{i})
				ModifiedList{i}=sprintf('Input %02d: Empty',i-1);
			end
		end
		
	end
	if Error_bool==0
		set (handles.PM_FileInput_Select, 'string',ModifiedList);
		handles.MDL.InputFilePath{Input_Num,1}=InputFilePath;
		set(handles.PM_FileInput_Select, 'UserData', handles.MDL.InputFilePath);
		
		if Sim_Index==0
			set(handles.Edit_File_Path, 'string',handles.MDL.InputFilePath{Input_Num});
			set(handles.PM_FileInput_Select,'value', Input_Num+1);
		end
	end
	
	guidata(hObject, handles);
end


function Edit_FileInput_Add_Num_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Edit_FileInput_Add_Num_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PM_FileInput_Select.
function PM_FileInput_Select_Callback(hObject, eventdata, handles)
% hObject    handle to PM_FileInput_Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PM_FileInput_Select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PM_FileInput_Select
Tmp_UserData= get(handles.PB_Input_Plot, 'UserData');
Sim_Index=Tmp_UserData(1);CurStepNo=Tmp_UserData(2);

handles.MDL.InputFilePath=get(handles.PM_FileInput_Select, 'UserData');
InputNum=get(handles.PM_FileInput_Select,'value')-1;
if InputNum~=0
	Change_Bool=1;
	if Sim_Index==1
		quest_str=sprintf('Do you want to replace %s with %s? Current Step: %05d',handles.MDL.InputFile, handles.MDL.InputFilePath{InputNum,1},CurStepNo);
		questResult = questdlg(quest_str,'Change of Input File','Yes','No','No');
		if strcmp(questResult,'No')
			Change_Bool=0;
		end
	end

	if isempty(handles.MDL.InputFilePath{InputNum})
		%set(handles.Edit_File_Path, 'string','Empty');
		errordlg('Wake up! Input Data is empty!. Try again!','Data Error');
		Change_Bool=0;
	end
	
	if Change_Bool==0;
		for i=1:length(handles.MDL.InputFilePath)
			if isempty(handles.MDL.InputFilePath{i})~=1
				if strcmp(handles.MDL.InputFilePath{i},handles.MDL.InputFile)
					set(handles.Edit_FileInput_Add_Num, 'string',sprintf('%02d',i));
					set(handles.Edit_File_Path, 'string',handles.MDL.InputFile);
					set(handles.PM_FileInput_Select,'value', i+1);
					break;
				end
			end
		end
	else
		set(handles.Edit_File_Path, 'string',handles.MDL.InputFilePath{InputNum});
		set(handles.Edit_FileInput_Add_Num, 'string',num2str(InputNum));
		handles.MDL.InputFile=get(handles.Edit_File_Path, 'string');
	end

else
	errordlg('One input file should be selected!','Data Error');
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function PM_FileInput_Select_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in PB_Input_Plot.
function PB_Input_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Input_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MDL.InputFilePath=get(handles.PM_FileInput_Select, 'UserData');
Tmp_UserData= get(handles.PB_Input_Plot, 'UserData');
Sim_Index=Tmp_UserData(1);CurStepNo=Tmp_UserData(2);

% Properties for figure
LineColorSpec=[1 0 0 %r red
        	   0 0 1 %b blue
			   0 0 0 %k black
			   0 1 0 %g green
			   1 0 1 %m magenta 			   
			   0 1 1 %c cyan
			   1 1 0]; %y yellow

FigureOrder=[1,4,2,5,3,6];
Component={'DOF 1','DOF 2','DOF 3','DOF 4','DOF 5','DOF 6'};

% Data information	
D_num=0;
for i=1:length(handles.MDL.InputFilePath)
	if isempty(handles.MDL.InputFilePath{i})~=1
		D_num=D_num+1;
		ListStr{D_num}=handles.MDL.InputFilePath{i};
		[pathstr, name, ext, versn] = fileparts(handles.MDL.InputFilePath{i});
		LegendStrRef{D_num}=sprintf('Input %02d: %s',i,name);
	end
end

% Select file for plot
[s,v] = listdlg('PromptString','Select files',...
                'SelectionMode','multiple',...
                'ListSize',[160,150],...
                'ListString',ListStr);
if v
	LegendStr=cell(1,length(s));
	for i=1:length(s)
		PlotData{i}=load (ListStr{s(i)});	
		LegendStr{i}=LegendStrRef{s(i)};
		[R_n,C_n]=size(PlotData{i});
		Step{i}=[1:1:R_n]';	  %'
		Num_Data(i)=R_n;
	end
	
	% Determine xlim
	prompt = {sprintf('Min Step, Current Step: %05d',CurStepNo),sprintf('Max Step, Current Step: %05d',CurStepNo)}; 
	dlg_title = 'xlim for plot';
	num_lines = 1; def = {'1','1500'};
	xlimAns = inputdlg(prompt,dlg_title,num_lines,def); 
	if isempty(xlimAns)~=1
		XLIMIT=[str2num(xlimAns{1}),str2num(xlimAns{2}) ];
	else
		XLIMIT=[1,max(Num_Data)];
	end 
	
	% Plot data
	figure;
	for i=1:6
		subplot (3,2,i)
		for j=1:length(s)
			ColorLine=rem(j,length(LineColorSpec));
			if ColorLine==0
				ColorLine=length(LineColorSpec);
			end
			plot (Step{j},PlotData{j}(:,FigureOrder(i)),'Color',LineColorSpec(ColorLine,:));
			hold on
		end
		hold off;
		xlabel('Step','FontWeight','bold');
		ylabel(Component{FigureOrder(i)},'FontWeight','bold');
		if FigureOrder(i)==4
			legend (LegendStr,2);
		end
		xlim (XLIMIT);
		grid on	
	end 
end 

