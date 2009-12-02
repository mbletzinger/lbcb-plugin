function varargout = TargetConfig(varargin)
% TARGETCONFIG M-file for TargetConfig.fig
%      TARGETCONFIG, by itself, creates a new TARGETCONFIG or raises the existing
%      singleton*.
%
%      H = TARGETCONFIG returns the handle to a new TARGETCONFIG or the handle to
%      the existing singleton*.
%
%      TARGETCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TARGETCONFIG.M with the given input arguments.
%
%      TARGETCONFIG('Property','Value',...) creates a new TARGETCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TargetConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TargetConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TargetConfig

% Last Modified by GUIDE v2.5 02-Dec-2009 13:14:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TargetConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @TargetConfig_OutputFcn, ...
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


% --- Executes just before TargetConfig is made visible.
function TargetConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TargetConfig (see VARARGIN)

% Choose default command line output for TargetConfig
cfg = [];
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'cfg'
                cfg = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.cfg = cfg;
handles.actions = TargetConfigActions(cfg);
handles.actions.init(handles);

handles.output = hObject;
% Make the GUI modal
set(handles.TargetConfig,'WindowStyle','modal')


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TargetConfig wait for user response (see UIRESUME)
uiwait(handles.TargetConfig);


% --- Outputs from this function are returned to the command line.
function varargout = TargetConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.TargetConfig);

% --- Executes on selection change in s2lFunction.
function s2lFunction_Callback(hObject, eventdata, handles)
% hObject    handle to s2lFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns s2lFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from s2lFunction
handles.actions.setSimCor2LbcbFunction(get(hObject,'Value'));

% --- Executes on selection change in l2sFunction.
function l2sFunction_Callback(hObject, eventdata, handles)
% hObject    handle to l2sFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l2sFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l2sFunction
handles.actions.setLbcb2SimCorFunction(get(hObject,'Value'));


% --- Executes on selection change in modelControlPoints.
function modelControlPoints_Callback(hObject, eventdata, handles)
% hObject    handle to modelControlPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns modelControlPoints contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modelControlPoints


% --- Executes on button press in upCps.
function upCps_Callback(hObject, eventdata, handles)
% hObject    handle to upCps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.upCps();


% --- Executes on button press in dwnCps.
function dwnCps_Callback(hObject, eventdata, handles)
% hObject    handle to dwnCps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.downCps();

% --- Executes on button press in edCps.
function edCps_Callback(hObject, eventdata, handles)
% hObject    handle to edCps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.edCps();


% --- Executes on button press in addCps.
function addCps_Callback(hObject, eventdata, handles)
% hObject    handle to addCps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.newCps();


% --- Executes on button press in removeCps.
function removeCps_Callback(hObject, eventdata, handles)
% hObject    handle to removeCps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.removeCps();
