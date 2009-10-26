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

% Last Modified by GUIDE v2.5 26-Oct-2009 02:34:21

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
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TargetConfig wait for user response (see UIRESUME)
% uiwait(handles.TargetConfig);


% --- Outputs from this function are returned to the command line.
function varargout = TargetConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function OffsetDx_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to OffsetDx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDx as text
%        str2double(get(hObject,'String')) returns contents of OffsetDx as a double



function OffsetDy_Callback(hObject, eventdata, handles)
% hObject    handle to OffsetDy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDy as text
%        str2double(get(hObject,'String')) returns contents of OffsetDy as a double


function OffsetDz_Callback(hObject, eventdata, handles)
% hObject    handle to OffsetDz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDz as text
%        str2double(get(hObject,'String')) returns contents of OffsetDz as a double


function Address_Callback(hObject, eventdata, handles)
% hObject    handle to Address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Address as text
%        str2double(get(hObject,'String')) returns contents of Address as a double


% --- Executes on button press in backB.
function backB_Callback(hObject, eventdata, handles)
% hObject    handle to backB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in forwardB.
function forwardB_Callback(hObject, eventdata, handles)
% hObject    handle to forwardB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in deleteB.
function deleteB_Callback(hObject, eventdata, handles)
% hObject    handle to deleteB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in newB.
function newB_Callback(hObject, eventdata, handles)
% hObject    handle to newB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
