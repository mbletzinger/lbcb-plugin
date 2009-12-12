function varargout = LbcbPlugin(varargin)
% LBCBPLUGIN M-file for LbcbPlugin.fig
%      LBCBPLUGIN, by itself, creates a new LBCBPLUGIN or raises the existing
%      singleton*.
%
%      H = LBCBPLUGIN returns the handle to a new LBCBPLUGIN or the handle to
%      the existing singleton*.
%
%      LBCBPLUGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LBCBPLUGIN.M with the given input arguments.
%
%      LBCBPLUGIN('Property','Value',...) creates a new LBCBPLUGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LbcbPlugin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LbcbPlugin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LbcbPlugin

% Last Modified by GUIDE v2.5 11-Dec-2009 22:00:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LbcbPlugin_OpeningFcn, ...
                   'gui_OutputFcn',  @LbcbPlugin_OutputFcn, ...
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


% --- Executes just before LbcbPlugin is made visible.
function LbcbPlugin_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LbcbPlugin (see VARARGIN)

% Choose default command line output for LbcbPlugin
handles.output = hObject;
hfact = {};
handles.notimer = 0;

if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'hfact'
                hfact = varargin{index+1};
            case 'notimer'
                handles.notimer = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.actions = LbcbPluginActions(handles,hfact);
% Update handles structure
set(handles.DataTable,'Checked','off');
guidata(hObject, handles);
DataDisplay.setMenuHandle(handles);

% h = handles

% UIWAIT makes LbcbPlugin wait for user response (see UIRESUME)
 uiwait(handles.LbcbPlugin);


% --- Outputs from this function are returned to the command line.
function varargout = LbcbPlugin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


% --- Executes on button press in RunHold.
function RunHold_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to RunHold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.notimer
    % Used for debugging the software
    disp('no timer execution');
    handles.actions.startSimulation();
    LbcbPluginActions.execute([],[],handles.actions);

else
    handles.actions.processRunHold(get(hObject,'Value'));
end

% --- Executes on button press in Connect2Om.
function Connect2Om_Callback(hObject, eventdata, handles)
handles.actions.processConnectOm(get(hObject,'Value'));


% --- Executes on button press in ManualInput.
function ManualInput_Callback(hObject, eventdata, handles)
handles.actions.processEditTarget();

% --- Executes on button press in StartTriggering.
function StartTriggering_Callback(hObject, eventdata, handles)
disp('Not Implemented');

function DxL1_Callback(hObject, eventdata, handles)
% hObject    handle to DxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxL1 as text
%        str2double(get(hObject,'String')) returns contents of DxL1 as a double
handles.actions.setCommandLimit(1,1,1,get(hObject,'String'));


function DxU1_Callback(hObject, eventdata, handles)
% hObject    handle to DxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxU1 as text
%        str2double(get(hObject,'String')) returns contents of DxU1 as a double
handles.actions.setCommandLimit(1,1,0,get(hObject,'String'));


function DyL1_Callback(hObject, eventdata, handles)
% hObject    handle to DyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyL1 as text
%        str2double(get(hObject,'String')) returns contents of DyL1 as a double
handles.actions.setCommandLimit(2,1,1,get(hObject,'String'));

function DyU1_Callback(hObject, eventdata, handles)
% hObject    handle to DyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyU1 as text
%        str2double(get(hObject,'String')) returns contents of DyU1 as a double
handles.actions.setCommandLimit(2,1,0,get(hObject,'String'));

function DzL1_Callback(hObject, eventdata, handles)
% hObject    handle to DzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzL1 as text
%        str2double(get(hObject,'String')) returns contents of DzL1 as a double
handles.actions.setCommandLimit(3,1,1,get(hObject,'String'));

function DzU1_Callback(hObject, eventdata, handles)
% hObject    handle to DzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzU1 as text
%        str2double(get(hObject,'String')) returns contents of DzU1 as a double
handles.actions.setCommandLimit(3,1,0,get(hObject,'String'));

function RxL1_Callback(hObject, eventdata, handles)
% hObject    handle to RxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxL1 as text
%        str2double(get(hObject,'String')) returns contents of RxL1 as a double
handles.actions.setCommandLimit(4,1,1,get(hObject,'String'));

function RxU1_Callback(hObject, eventdata, handles)
% hObject    handle to RxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxU1 as text
%        str2double(get(hObject,'String')) returns contents of RxU1 as a double
handles.actions.setCommandLimit(4,1,0,get(hObject,'String'));

function RyL1_Callback(hObject, eventdata, handles)
% hObject    handle to RyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyL1 as text
%        str2double(get(hObject,'String')) returns contents of RyL1 as a double
handles.actions.setCommandLimit(5,1,1,get(hObject,'String'));

function RyU1_Callback(hObject, eventdata, handles)
% hObject    handle to RyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyU1 as text
%        str2double(get(hObject,'String')) returns contents of RyU1 as a double
handles.actions.setCommandLimit(5,1,0,get(hObject,'String'));

function RzL1_Callback(hObject, eventdata, handles)
% hObject    handle to RzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCommandLimit(6,1,1,get(hObject,'String'));

function RzU1_Callback(hObject, eventdata, handles)
% hObject    handle to RzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzU1 as text
%        str2double(get(hObject,'String')) returns contents of RzU1 as a double
handles.actions.setCommandLimit(6,1,0,get(hObject,'String'));

function DxL2_Callback(hObject, eventdata, handles)
% hObject    handle to DxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxL2 as text
%        str2double(get(hObject,'String')) returns contents of DxL2 as a double
handles.actions.setCommandLimit(1,2,1,get(hObject,'String'));

function DxU2_Callback(hObject, eventdata, handles)
% hObject    handle to DxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxU2 as text
%        str2double(get(hObject,'String')) returns contents of DxU2 as a double
handles.actions.setCommandLimit(1,2,0,get(hObject,'String'));

function DyL2_Callback(hObject, eventdata, handles)
% hObject    handle to DyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyL2 as text
%        str2double(get(hObject,'String')) returns contents of DyL2 as a double
handles.actions.setCommandLimit(2,2,1,get(hObject,'String'));

function DyU2_Callback(hObject, eventdata, handles)
% hObject    handle to DyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyU2 as text
%        str2double(get(hObject,'String')) returns contents of DyU2 as a double
handles.actions.setCommandLimit(2,2,0,get(hObject,'String'));

function DzL2_Callback(hObject, eventdata, handles)
% hObject    handle to DzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzL2 as text
%        str2double(get(hObject,'String')) returns contents of DzL2 as a double
handles.actions.setCommandLimit(3,2,1,get(hObject,'String'));

function DzU2_Callback(hObject, eventdata, handles)
% hObject    handle to DzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzU2 as text
%        str2double(get(hObject,'String')) returns contents of DzU2 as a double
handles.actions.setCommandLimit(3,2,0,get(hObject,'String'));

function RxL2_Callback(hObject, eventdata, handles)
% hObject    handle to RxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxL2 as text
%        str2double(get(hObject,'String')) returns contents of RxL2 as a double
handles.actions.setCommandLimit(4,2,1,get(hObject,'String'));

function RxU2_Callback(hObject, eventdata, handles)
% hObject    handle to RxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxU2 as text
%        str2double(get(hObject,'String')) returns contents of RxU2 as a double
handles.actions.setCommandLimit(4,2,0,get(hObject,'String'));

function RyL2_Callback(hObject, eventdata, handles)
% hObject    handle to RyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyL2 as text
%        str2double(get(hObject,'String')) returns contents of RyL2 as a double
handles.actions.setCommandLimit(5,2,1,get(hObject,'String'));

function RyU2_Callback(hObject, eventdata, handles)
% hObject    handle to RyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyU2 as text
%        str2double(get(hObject,'String')) returns contents of RyU2 as a double
handles.actions.setCommandLimit(5,2,0,get(hObject,'String'));

function RzL2_Callback(hObject, eventdata, handles)
% hObject    handle to RzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzL2 as text
%        str2double(get(hObject,'String')) returns contents of RzL2 as a double
handles.actions.setCommandLimit(6,2,1,get(hObject,'String'));

function RzU2_Callback(hObject, eventdata, handles)
% hObject    handle to RzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzU2 as text
%        str2double(get(hObject,'String')) returns contents of RzU2 as a double
handles.actions.setCommandLimit(6,2,0,get(hObject,'String'));

function FxL1_Callback(hObject, eventdata, handles)
% hObject    handle to FxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxL1 as text
%        str2double(get(hObject,'String')) returns contents of FxL1 as a double
handles.actions.setCommandLimit(7,1,1,get(hObject,'String'));

function FxU1_Callback(hObject, eventdata, handles)
% hObject    handle to FxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxU1 as text
%        str2double(get(hObject,'String')) returns contents of FxU1 as a double
handles.actions.setCommandLimit(7,1,0,get(hObject,'String'));

function FyL1_Callback(hObject, eventdata, handles)
% hObject    handle to FyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyL1 as text
%        str2double(get(hObject,'String')) returns contents of FyL1 as a double
handles.actions.setCommandLimit(8,1,1,get(hObject,'String'));

function FyU1_Callback(hObject, eventdata, handles)
% hObject    handle to FyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyU1 as text
%        str2double(get(hObject,'String')) returns contents of FyU1 as a double
handles.actions.setCommandLimit(8,1,0,get(hObject,'String'));

function FzL1_Callback(hObject, eventdata, handles)
% hObject    handle to FzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzL1 as text
%        str2double(get(hObject,'String')) returns contents of FzL1 as a double
handles.actions.setCommandLimit(9,1,1,get(hObject,'String'));

function FzU1_Callback(hObject, eventdata, handles)
% hObject    handle to FzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzU1 as text
%        str2double(get(hObject,'String')) returns contents of FzU1 as a double
handles.actions.setCommandLimit(9,1,0,get(hObject,'String'));

function MxL1_Callback(hObject, eventdata, handles)
% hObject    handle to MxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxL1 as text
%        str2double(get(hObject,'String')) returns contents of MxL1 as a double
handles.actions.setCommandLimit(10,1,1,get(hObject,'String'));

function MxU1_Callback(hObject, eventdata, handles)
% hObject    handle to MxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxU1 as text
%        str2double(get(hObject,'String')) returns contents of MxU1 as a double
handles.actions.setCommandLimit(10,1,0,get(hObject,'String'));

function MyL1_Callback(hObject, eventdata, handles)
% hObject    handle to MyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyL1 as text
%        str2double(get(hObject,'String')) returns contents of MyL1 as a double
handles.actions.setCommandLimit(11,1,1,get(hObject,'String'));

function MyU1_Callback(hObject, eventdata, handles)
% hObject    handle to MyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyU1 as text
%        str2double(get(hObject,'String')) returns contents of MyU1 as a double
handles.actions.setCommandLimit(11,1,0,get(hObject,'String'));

function MzL1_Callback(hObject, eventdata, handles)
% hObject    handle to MzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzL1 as text
%        str2double(get(hObject,'String')) returns contents of MzL1 as a double
handles.actions.setCommandLimit(12,1,1,get(hObject,'String'));

function MzU1_Callback(hObject, eventdata, handles)
% hObject    handle to MzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzU1 as text
%        str2double(get(hObject,'String')) returns contents of MzU1 as a double
handles.actions.setCommandLimit(12,1,0,get(hObject,'String'));

function FxL2_Callback(hObject, eventdata, handles)
% hObject    handle to FxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxL2 as text
%        str2double(get(hObject,'String')) returns contents of FxL2 as a double
handles.actions.setCommandLimit(7,2,1,get(hObject,'String'));

function FxU2_Callback(hObject, eventdata, handles)
% hObject    handle to FxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxU2 as text
%        str2double(get(hObject,'String')) returns contents of FxU2 as a double
handles.actions.setCommandLimit(7,2,0,get(hObject,'String'));

function FyL2_Callback(hObject, eventdata, handles)
% hObject    handle to FyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyL2 as text
%        str2double(get(hObject,'String')) returns contents of FyL2 as a double
handles.actions.setCommandLimit(8,2,1,get(hObject,'String'));

function FyU2_Callback(hObject, eventdata, handles)
% hObject    handle to FyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyU2 as text
%        str2double(get(hObject,'String')) returns contents of FyU2 as a double
handles.actions.setCommandLimit(8,2,0,get(hObject,'String'));

function FzL2_Callback(hObject, eventdata, handles)
% hObject    handle to FzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzL2 as text
%        str2double(get(hObject,'String')) returns contents of FzL2 as a double
handles.actions.setCommandLimit(9,2,1,get(hObject,'String'));

function FzU2_Callback(hObject, eventdata, handles)
% hObject    handle to FzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzU2 as text
%        str2double(get(hObject,'String')) returns contents of FzU2 as a double
handles.actions.setCommandLimit(9,2,0,get(hObject,'String'));

function MxL2_Callback(hObject, eventdata, handles)
% hObject    handle to MxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCommandLimit(10,2,1,get(hObject,'String'));

function MxU2_Callback(hObject, eventdata, handles)
% hObject    handle to MxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxU2 as text
%        str2double(get(hObject,'String')) returns contents of MxU2 as a double
handles.actions.setCommandLimit(10,2,0,get(hObject,'String'));

function MyL2_Callback(hObject, eventdata, handles)
% hObject    handle to MyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyL2 as text
%        str2double(get(hObject,'String')) returns contents of MyL2 as a double
handles.actions.setCommandLimit(11,2,1,get(hObject,'String'));

function MyU2_Callback(hObject, eventdata, handles)
% hObject    handle to MyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyU2 as text
%        str2double(get(hObject,'String')) returns contents of MyU2 as a double
handles.actions.setCommandLimit(1,2,0,get(hObject,'String'));

function MzL2_Callback(hObject, eventdata, handles)
% hObject    handle to MzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzL2 as text
%        str2double(get(hObject,'String')) returns contents of MzL2 as a double
handles.actions.setCommandLimit(12,2,1,get(hObject,'String'));

function MzU2_Callback(hObject, eventdata, handles)
% hObject    handle to MzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzU2 as text
%        str2double(get(hObject,'String')) returns contents of MzU2 as a double
handles.actions.setCommandLimit(12,2,0,get(hObject,'String'));

function DxT1_Callback(hObject, eventdata, handles)
% hObject    handle to DxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxT1 as text
%        str2double(get(hObject,'String')) returns contents of DxT1 as a double
handles.actions.setStepTolerance(1,1,get(hObject,'String'));

function DyT1_Callback(hObject, eventdata, handles)
% hObject    handle to DyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyT1 as text
%        str2double(get(hObject,'String')) returns contents of DyT1 as a double
handles.actions.setStepTolerance(2,1,get(hObject,'String'));

function DzT1_Callback(hObject, eventdata, handles)
% hObject    handle to DzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzT1 as text
%        str2double(get(hObject,'String')) returns contents of DzT1 as a double
handles.actions.setStepTolerance(3,1,get(hObject,'String'));

function RxT1_Callback(hObject, eventdata, handles)
% hObject    handle to RxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxT1 as text
%        str2double(get(hObject,'String')) returns contents of RxT1 as a double
handles.actions.setStepTolerance(4,1,get(hObject,'String'));

function RyT1_Callback(hObject, eventdata, handles)
% hObject    handle to RyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyT1 as text
%        str2double(get(hObject,'String')) returns contents of RyT1 as a double
handles.actions.setStepTolerance(5,1,get(hObject,'String'));

function RzT1_Callback(hObject, eventdata, handles)
% hObject    handle to RzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzT1 as text
%        str2double(get(hObject,'String')) returns contents of RzT1 as a double
handles.actions.setStepTolerance(6,1,get(hObject,'String'));

function DxT2_Callback(hObject, eventdata, handles)
% hObject    handle to DxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxT2 as text
%        str2double(get(hObject,'String')) returns contents of DxT2 as a double
handles.actions.setStepTolerance(1,2,get(hObject,'String'));

function DyT2_Callback(hObject, eventdata, handles)
% hObject    handle to DyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyT2 as text
%        str2double(get(hObject,'String')) returns contents of DyT2 as a double
handles.actions.setStepTolerance(2,2,get(hObject,'String'));

function DzT2_Callback(hObject, eventdata, handles)
% hObject    handle to DzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzT2 as text
%        str2double(get(hObject,'String')) returns contents of DzT2 as a double
handles.actions.setStepTolerance(3,2,get(hObject,'String'));

function RxT2_Callback(hObject, eventdata, handles)
% hObject    handle to RxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxT2 as text
%        str2double(get(hObject,'String')) returns contents of RxT2 as a double
handles.actions.setStepTolerance(4,2,get(hObject,'String'));

function RyT2_Callback(hObject, eventdata, handles)
% hObject    handle to RyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyT2 as text
%        str2double(get(hObject,'String')) returns contents of RyT2 as a double
handles.actions.setStepTolerance(5,2,get(hObject,'String'));

function RzT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(6,2,get(hObject,'String'));

function FxT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(7,1,get(hObject,'String'));

function FyT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(8,1,get(hObject,'String'));

function FzT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(9,1,get(hObject,'String'));

function MxT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(10,1,get(hObject,'String'));


function MyT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(11,1,get(hObject,'String'));


function MzT1_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(12,1,get(hObject,'String'));


function FxT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(7,2,get(hObject,'String'));

function FyT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(8,2,get(hObject,'String'));

function FzT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(9,2,get(hObject,'String'));

function MxT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(10,2,get(hObject,'String'));

function MyT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(11,2,get(hObject,'String'));

function MzT2_Callback(hObject, eventdata, handles)
handles.actions.setStepTolerance(12,2,get(hObject,'String'));

function DxI1_Callback(hObject, eventdata, handles)
% hObject    handle to DxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxI1 as text
%        str2double(get(hObject,'String')) returns contents of DxI1 as a double
handles.actions.setIncrementLimit(1,1,get(hObject,'String'));

function DyI1_Callback(hObject, eventdata, handles)
% hObject    handle to DyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyI1 as text
%        str2double(get(hObject,'String')) returns contents of DyI1 as a double
handles.actions.setIncrementLimit(2,1,get(hObject,'String'));

function DzI1_Callback(hObject, eventdata, handles)
% hObject    handle to DzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzI1 as text
%        str2double(get(hObject,'String')) returns contents of DzI1 as a double
handles.actions.setIncrementLimit(3,1,get(hObject,'String'));

function RxI1_Callback(hObject, eventdata, handles)
% hObject    handle to RxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxI1 as text
%        str2double(get(hObject,'String')) returns contents of RxI1 as a double
handles.actions.setIncrementLimit(4,1,get(hObject,'String'));

function RyI1_Callback(hObject, eventdata, handles)
% hObject    handle to RyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyI1 as text
%        str2double(get(hObject,'String')) returns contents of RyI1 as a double
handles.actions.setIncrementLimit(5,1,get(hObject,'String'));

function RzI1_Callback(hObject, eventdata, handles)
% hObject    handle to RzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzI1 as text
%        str2double(get(hObject,'String')) returns contents of RzI1 as a double
handles.actions.setIncrementLimit(6,1,get(hObject,'String'));

function DxI2_Callback(hObject, eventdata, handles)
% hObject    handle to DxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxI2 as text
%        str2double(get(hObject,'String')) returns contents of DxI2 as a double
handles.actions.setIncrementLimit(1,2,get(hObject,'String'));

function DyI2_Callback(hObject, eventdata, handles)
% hObject    handle to DyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyI2 as text
%        str2double(get(hObject,'String')) returns contents of DyI2 as a double
handles.actions.setIncrementLimit(2,2,get(hObject,'String'));

function DzI2_Callback(hObject, eventdata, handles)
% hObject    handle to DzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzI2 as text
%        str2double(get(hObject,'String')) returns contents of DzI2 as a double
handles.actions.setIncrementLimit(3,2,get(hObject,'String'));

function RxI2_Callback(hObject, eventdata, handles)
% hObject    handle to RxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxI2 as text
%        str2double(get(hObject,'String')) returns contents of RxI2 as a double
handles.actions.setIncrementLimit(4,2,get(hObject,'String'));

function RyI2_Callback(hObject, eventdata, handles)
% hObject    handle to RyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyI2 as text
%        str2double(get(hObject,'String')) returns contents of RyI2 as a double
handles.actions.setIncrementLimit(5,2,get(hObject,'String'));

function RzI2_Callback(hObject, eventdata, handles)
% hObject    handle to RzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzI2 as text
%        str2double(get(hObject,'String')) returns contents of RzI2 as a double
handles.actions.setIncrementLimit(6,2,get(hObject,'String'));

function FxI1_Callback(hObject, eventdata, handles)
% hObject    handle to FxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxI1 as text
%        str2double(get(hObject,'String')) returns contents of FxI1 as a double
handles.actions.setIncrementLimit(7,1,get(hObject,'String'));

function FyI1_Callback(hObject, eventdata, handles)
% hObject    handle to FyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyI1 as text
%        str2double(get(hObject,'String')) returns contents of FyI1 as a double
handles.actions.setIncrementLimit(8,1,get(hObject,'String'));

function FzI1_Callback(hObject, eventdata, handles)
% hObject    handle to FzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzI1 as text
%        str2double(get(hObject,'String')) returns contents of FzI1 as a double
handles.actions.setIncrementLimit(9,1,get(hObject,'String'));

function MxI1_Callback(hObject, eventdata, handles)
% hObject    handle to MxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxI1 as text
%        str2double(get(hObject,'String')) returns contents of MxI1 as a double
handles.actions.setIncrementLimit(10,1,get(hObject,'String'));

function MyI1_Callback(hObject, eventdata, handles)
% hObject    handle to MyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyI1 as text
%        str2double(get(hObject,'String')) returns contents of MyI1 as a double
handles.actions.setIncrementLimit(11,1,get(hObject,'String'));

function MzI1_Callback(hObject, eventdata, handles)
% hObject    handle to MzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzI1 as text
%        str2double(get(hObject,'String')) returns contents of MzI1 as a double
handles.actions.setIncrementLimit(12,1,get(hObject,'String'));

function FxI2_Callback(hObject, eventdata, handles)
% hObject    handle to FxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxI2 as text
%        str2double(get(hObject,'String')) returns contents of FxI2 as a double
handles.actions.setIncrementLimit(7,2,get(hObject,'String'));

function FyI2_Callback(hObject, eventdata, handles)
% hObject    handle to FyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyI2 as text
%        str2double(get(hObject,'String')) returns contents of FyI2 as a double
handles.actions.setIncrementLimit(8,2,get(hObject,'String'));

function FzI2_Callback(hObject, eventdata, handles)
% hObject    handle to FzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzI2 as text
%        str2double(get(hObject,'String')) returns contents of FzI2 as a double
handles.actions.setIncrementLimit(9,2,get(hObject,'String'));

function MxI2_Callback(hObject, eventdata, handles)
% hObject    handle to MxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxI2 as text
%        str2double(get(hObject,'String')) returns contents of MxI2 as a double
handles.actions.setIncrementLimit(10,2,get(hObject,'String'));

function MyI2_Callback(hObject, eventdata, handles)
% hObject    handle to MyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyI2 as text
%        str2double(get(hObject,'String')) returns contents of MyI2 as a double
handles.actions.setIncrementLimit(11,2,get(hObject,'String'));

function MzI2_Callback(hObject, eventdata, handles)
% hObject    handle to MzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzI2 as text
%        str2double(get(hObject,'String')) returns contents of MzI2 as a double
handles.actions.setIncrementLimit(12,2,get(hObject,'String'));

% --------------------------------------------------------------------
function NetworkConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to NetworkConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NetworkConfig('cfg',handles.actions.hfact.cfg);

% --------------------------------------------------------------------
function OmConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to OmConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OmConfig('cfg',handles.actions.hfact.cfg);

% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.hfact.cfg.load()

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.hfact.cfg.save()

% --------------------------------------------------------------------
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.hfact.cfg.import()

% --------------------------------------------------------------------
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.hfact.cfg.export()


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.LbcbPlugin);


% --- Executes on button press in InputFile.
function InputFile_Callback(hObject, eventdata, handles)
handles.actions.setInputFile({});


% --------------------------------------------------------------------
function LoggingLevels_Callback(hObject, eventdata, handles)
% hObject    handle to LoggingLevels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LoggerLevels('cfg',handles.actions.hfact.cfg);
handles.actions.setLoggerLevels();


% --- Executes on button press in StartSimCor.
function StartSimCor_Callback(hObject, eventdata, handles)
% hObject    handle to StartSimCor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.processConnectSimCor(get(hObject,'Value'));


% --------------------------------------------------------------------
function DataTable_Callback(hObject, eventdata, handles)
% hObject    handle to DataTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    handles.actions.dd.stopDataTable();
else 
    handles.actions.dd.startDataTable();
    set(hObject,'Checked','on');
end


% --- Executes during object deletion, before destroying properties.
function LbcbPlugin_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to LbcbPlugin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles,'actions')
    disp('Shutting Down');
end


% --------------------------------------------------------------------
function TotalFxVsLbcb1Dx_Callback(hObject, eventdata, handles)
% hObject    handle to TotalFxVsLbcb1Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    handles.actions.dd.stopTotalFxVsLbcbDx(1);
else 
    handles.actions.dd.startTotalFxVsLbcbDx(1);
    set(hObject,'Checked','on');
end


% --------------------------------------------------------------------
function TotalFxVsLbcb2Dx_Callback(hObject, eventdata, handles)
% hObject    handle to TotalFxVsLbcb2Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    handles.actions.dd.stopTotalFxVsLbcbDx(0);
else 
    handles.actions.dd.startTotalFxVsLbcbDx(0);
    set(hObject,'Checked','on');
end

% --- Executes on button press in commandtable.
function AutoAccept_Callback(hObject, eventdata, handles)
% hObject    handle to commandtable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.processAutoAccept(get(hObject,'Value'));


% --- Executes on button press in Accept.
function Accept_Callback(hObject, eventdata, handles)
% hObject    handle to Accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.processAccept(get(hObject,'Value'));

% --- Executes on button press in editCommand.
function editCommand_Callback(hObject, eventdata, handles)
% hObject    handle to editCommand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.processEditTarget();

% --------------------------------------------------------------------
function ArchiveOnOff_Callback(hObject, eventdata, handles)
% hObject    handle to ArchiveOnOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'Checked'),'on')
    set(hObject,'Checked','off');
else 
    set(hObject,'Checked','on');
end
handles.actions.processArchiveOnOff(get(hObject,'Checked'));



function startStep_Callback(hObject, eventdata, handles)
% hObject    handle to startStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startStep as text
%        str2double(get(hObject,'String')) returns contents of startStep as a double
handles.actions.setStartStep(get(hObject,'String'));


% --------------------------------------------------------------------
function StepConfig_Callback(hObject, eventdata, handles)
% hObject    handle to StepConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StepConfig('cfg',handles.actions.hfact.cfg);

% --------------------------------------------------------------------
function TargetConfig_Callback(hObject, eventdata, handles)
% hObject    handle to TargetConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TargetConfig('cfg',handles.actions.hfact.cfg);


% --------------------------------------------------------------------
function DerivedDofFactors_Callback(hObject, eventdata, handles)
% hObject    handle to DerivedDofFactors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DerivedDofConfig('cfg',handles.actions.hfact.cfg);
