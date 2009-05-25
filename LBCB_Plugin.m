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

% Last Modified by GUIDE v2.5 07-May-2009 22:13:33

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

handles = readGUI(handles);

% Check AUX Module Connection
if handles.Num_AuxModules < 1
	AUX_bool=1;
else
	for i=1:handles.Num_AuxModules
		AUX_Network_Bool(i)=handles.AUX(i).NetworkConnectionState;
	end
	if all(AUX_Network_Bool)
		AUX_bool=1;
	else
		AUX_bool=0;
	end
end

if AUX_bool==1
	disp('Connecting to LBCB_1 & LBCB_2 ...................................');
	handles.MDL.Comm_obj_1 = tcpip(handles.MDL.IP_1,handles.MDL.Port_1);            % create TCPIP obj(objInd)ect
	set(handles.MDL.Comm_obj_1,'InputBufferSize', 1024*100);                    	% set buffer size
	
	% handles.MDL.Comm_obj_2 = tcpip(handles.MDL.IP_2,handles.MDL.Port_2);            % create TCPIP obj(objInd)ect
	% set(handles.MDL.Comm_obj_2,'InputBufferSize', 1024*100);                    	% set buffer size
	
	handles.MDL = open(handles.MDL);
	
	% Modified by Sung Jig Kim, 05/03/2009
	if handles.MDL.NetworkConnectionState
		disp('Connection is established with LBCB Operations Manager.');
		set(handles.PB_LBCB_Disconnect,	'enable',	'on');
		set(handles.PB_LBCB_Connect,	'enable',	'off');
		set(handles.PB_LBCB_Reconnect,	'enable',	'off');
		set(handles.PB_Pause,		'enable',	'on');
		set(handles.Edit_LBCB_IP_1,       'enable',	'off');
		set(handles.Edit_LBCB_Port_1,     'enable',	'off');
		
		% by Sung Jig Kim, 05/02/2009
		set(handles.PB_LBCB_Reconnect, 'UserData', 1);
		
		guidata(hObject, handles);    
		
		% Run Simulation
		Run_Simulation(hObject, eventdata, handles);
	else
		set(handles.PB_LBCB_Disconnect,	'enable',	'off');
		set(handles.PB_LBCB_Connect,	'enable',	'on');
		set(handles.PB_LBCB_Reconnect,	'enable',	'off');
		set(handles.Edit_LBCB_IP_1,       'enable',	'on');
		set(handles.Edit_LBCB_Port_1,     'enable',	'on');
	end
else
	err_str={'Wake up! Hussam and David';
	          'AUX Modules should be connected.'; 
	          'Please connect AUX module first.'};
	errordlg(err_str,'AUX Module Error');
end
    
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
    CurDir=sprintf('%s\\',cd);
	if strcmp(CurDir,path)
		set(handles.Edit_File_Path, 'String',file);
	else
		set(handles.Edit_File_Path, 'String',[path file]);
	end
	handles.MDL.InputFile = [path file];
	guidata(hObject, handles);
end


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
% --- Executes on button press in CB_Disp_Limit1.
% -------------------------------------------------------------------------------------------------
function CB_Disp_Limit1_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_DispTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLmin_DOF11, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF12, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF13, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF14, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF15, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF16, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF11, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF12, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF13, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF14, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF15, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF16, 'backgroundcolor',[1 1 1]);
end                                       
% guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_Forc_Limit1.
% -------------------------------------------------------------------------------------------------
function CB_Forc_Limit1_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_ForcTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_FLmin_DOF11, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF12, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF13, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF14, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF15, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF16, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF11, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF12, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF13, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF14, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF15, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF16, 'backgroundcolor',[1 1 1]);
end  
% guidata(hObject, handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on button press in CB_Disp_Inc1.
% -------------------------------------------------------------------------------------------------
function CB_Disp_Inc1_Callback(hObject, eventdata, handles)

% handles.MDL.CheckLimit_DispInc = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLinc_DOF11, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF12, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF13, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF14, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF15, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF16, 'backgroundcolor',[1 1 1]);
end      




% *************************************************************************************************
% *************************************************************************************************
% EDIT BOXES 
% *************************************************************************************************
% *************************************************************************************************

% -------------------------------------------------------------------------------------------------
function Edit_PortNo_Callback(hObject, eventdata, handles)
function Edit_File_Path_Callback(hObject, eventdata, handles)
function Edit_LBCB_IP_1_Callback(hObject, eventdata, handles)
function Edit_LBCB_Port_1_Callback(hObject, eventdata, handles)

function Edit_DLmin_DOF11_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF12_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF13_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF14_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF15_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF16_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF11_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF12_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF13_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF14_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF15_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF16_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF11_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF12_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF13_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF14_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF15_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF16_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF11_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF12_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF13_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF14_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF15_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF16_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF11_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF12_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF13_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF14_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF15_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF16_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF21_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF22_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF23_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF24_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF25_Callback(hObject, eventdata, handles)
function Edit_DLmin_DOF26_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF21_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF22_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF23_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF24_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF25_Callback(hObject, eventdata, handles)
function Edit_DLmax_DOF26_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF21_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF22_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF23_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF24_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF25_Callback(hObject, eventdata, handles)
function Edit_FLmin_DOF26_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF21_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF22_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF23_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF24_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF25_Callback(hObject, eventdata, handles)
function Edit_FLmax_DOF26_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF21_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF22_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF23_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF24_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF25_Callback(hObject, eventdata, handles)
function Edit_DLinc_DOF26_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF21_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF22_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF23_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF24_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF25_Callback(hObject, eventdata, handles)
function Edit_Dtol_DOF26_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF21_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF22_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF23_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF24_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF25_Callback(hObject, eventdata, handles)
function Edit_Dsub_DOF26_Callback(hObject, eventdata, handles)



% status indicator
function Edit_Waiting_CMD_Callback(hObject, eventdata, handles)
function Edit_Disp_Itr_Callback(hObject, eventdata, handles)
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
% --- Executes on selection change in PM_Axis_X1.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X1_Callback(hObject, eventdata, handles)
updatePLOT(handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_X2.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X2_Callback(hObject, eventdata, handles)
updatePLOT(handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_X3.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X3_Callback(hObject, eventdata, handles)
updatePLOT(handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_X4.
% -------------------------------------------------------------------------------------------------
function PM_Axis_X4_Callback(hObject, eventdata, handles)
updatePLOT(handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y1.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y1_Callback(hObject, eventdata, handles)
updatePLOT(handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y2.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y2_Callback(hObject, eventdata, handles)
updatePLOT(handles);

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y3.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y3_Callback(hObject, eventdata, handles)
updatePLOT(handles)

% -------------------------------------------------------------------------------------------------
% --- Executes on selection change in PM_Axis_Y4.
% -------------------------------------------------------------------------------------------------
function PM_Axis_Y4_Callback(hObject, eventdata, handles)
updatePLOT(handles)


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








% --- Executes during object creation, after setting all properties.
function PM_Axis_Y3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PM_Axis_Y3 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function PM_Axis_X3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PM_Axis_X3 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CB_Noise_Compensation.
function CB_Noise_Compensation_Callback(hObject, eventdata, handles)



function Edit_Dtol_DOF11_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF11 (see GCBO)



% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF11 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF12_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF12 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF13_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF13 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF14_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF14 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF15_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF15 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dtol_DOF16_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dtol_DOF16 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF11_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF11 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF12_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF12 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF12 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF12 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF13_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Dsub_DOF13 as text
%        str2double(get(hObject,'String')) returns contents of Edit_Dsub_DOF13 as a double


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF13 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF14_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF14 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF15_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF15 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Dsub_DOF16_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Dsub_DOF16 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Processing_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Edit_Processing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Processing (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function Edit_LBCB_IP_2_Callback(hObject, eventdata, handles)
% 
% 
% % --- Executes during object creation, after setting all properties.
% function Edit_LBCB_IP_2_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to Edit_LBCB_IP_2 (see GCBO)
% 
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



%function Edit_LBCB_Port_2_Callback(hObject, eventdata, handles)




% --- Executes on button press in CB_Disp_Limit2.
function CB_Disp_Limit2_Callback(hObject, eventdata, handles)
% handles.MDL.CheckLimit_DispTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLmin_DOF21, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF22, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF23, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF24, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF25, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmin_DOF26, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF21, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF22, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF23, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF24, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF25, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLmax_DOF26, 'backgroundcolor',[1 1 1]);
end    








% --- Executes on button press in CB_Forc_Limit2.
function CB_Forc_Limit2_Callback(hObject, eventdata, handles)
% handles.MDL.CheckLimit_ForcTot = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_FLmin_DOF21, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF22, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF23, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF24, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF25, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmin_DOF26, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF21, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF22, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF23, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF24, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF25, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_FLmax_DOF26, 'backgroundcolor',[1 1 1]);
end  
% guidata(hObject, handles);





% --- Executes on button press in CB_Disp_Inc2.
function CB_Disp_Inc2_Callback(hObject, eventdata, handles)
% handles.MDL.CheckLimit_DispInc = get(hObject,'Value');
if get(hObject,'Value')

else
	set(handles.Edit_DLinc_DOF21, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF22, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF23, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF24, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF25, 'backgroundcolor',[1 1 1]);
	set(handles.Edit_DLinc_DOF26, 'backgroundcolor',[1 1 1]);
end   


% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmin_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLmax_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmin_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_FLmax_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_DLinc_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function PM_Axis_X4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function PM_Axis_Y4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Edit_LBCB_Port_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dtol_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Edit_Dsub_DOF26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_Max_Itr_Callback(hObject, eventdata, handles)
% hObject    handle to EB_Max_Itr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_Max_Itr as text
%        str2double(get(hObject,'String')) returns contents of EB_Max_Itr as a double


% --- Executes during object creation, after setting all properties.
function EB_Max_Itr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_Max_Itr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_LBCB_Reconnect.
function PB_LBCB_Reconnect_Callback(hObject, eventdata, handles)
% hObject    handle to PB_LBCB_Reconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = Reconnect_LBCB(handles);
guidata(hObject, handles);


function Edit_LBCB_NetworkWaitTime_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_LBCB_NetworkWaitTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_LBCB_NetworkWaitTime as text
%        str2double(get(hObject,'String')) returns contents of Edit_LBCB_NetworkWaitTime as a double

%---------------------------------------------------------------------------------------------------
% AUX Modules
%---------------------------------------------------------------------------------------------------
% --- Executes on button press in PB_AuxModule_Connect.
function PB_AuxModule_Connect_Callback(hObject, eventdata, handles)
% hObject    handle to PB_AuxModule_Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = readGUI(handles);

handles.AUX = open(handles.AUX);    

for i=1:length(handles.AUX)
	AUX_Network_Bool(i)=handles.AUX(i).NetworkConnectionState;
end
set(handles.PB_AuxModule_Connect, 'UserData',AUX_Network_Bool);

if all(AUX_Network_Bool)
	set (handles.PB_AuxModule_Connect,    'enable', 'off');
	%set (handles.PB_AuxModule_Reconnect,  'enable', 'off');
	set (handles.PB_AuxModule_Disconnect, 'enable', 'on');
end

guidata(hObject, handles);

% --- Executes on button press in PB_AuxModule_Disconnect.
function PB_AuxModule_Disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to PB_AuxModule_Disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Disconnect_ID= abs(get(handles.PB_AuxModule_Connect, 'UserData')-1);
close(handles.AUX, Disconnect_ID);

set (handles.PB_AuxModule_Connect,    'enable', 'on');
%set (handles.PB_AuxModule_Reconnect,  'enable', 'off');
set (handles.PB_AuxModule_Disconnect, 'enable', 'off'); 
guidata(hObject, handles);

% --- Executes on button press in PB_AuxModule_Reconnect.
function PB_AuxModule_Reconnect_Callback(hObject, eventdata, handles)
% hObject    handle to PB_AuxModule_Reconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = readGUI(handles);
handles = Reconnect_AUX(handles);
guidata(hObject, handles);
