function varargout = DerivedDofConfig(varargin)
% DERIVEDDOFCONFIG M-file for DerivedDofConfig.fig
%      DERIVEDDOFCONFIG, by itself, creates a new DERIVEDDOFCONFIG or raises the existing
%      singleton*.
%
%      H = DERIVEDDOFCONFIG returns the handle to a new DERIVEDDOFCONFIG or the handle to
%      the existing singleton*.
%
%      DERIVEDDOFCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DERIVEDDOFCONFIG.M with the given input arguments.
%
%      DERIVEDDOFCONFIG('Property','Value',...) creates a new DERIVEDDOFCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DerivedDofConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DerivedDofConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DerivedDofConfig

% Last Modified by GUIDE v2.5 28-Aug-2009 12:37:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DerivedDofConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @DerivedDofConfig_OutputFcn, ...
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


% --- Executes just before DerivedDofConfig is made visible.
function DerivedDofConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DerivedDofConfig (see VARARGIN)

% Choose default command line output for DerivedDofConfig
handles.output = hObject;
handles.output = hObject;
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
dcfg = DerivedDofDao(cfg);
set(handles.kfactor,'String',sprintf('%f',dcfg.kfactor));
set(handles.fztarget,'String',sprintf('%f',dcfg.Fztarget));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DerivedDofConfig wait for user response (see UIRESUME)
uiwait(handles.DerivedDofs);


% --- Outputs from this function are returned to the command line.
function varargout = DerivedDofConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSD>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;



function kfactor_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to kfactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kfactor as text
%        str2double(get(hObject,'String')) returns contents of kfactor as a double
dcfg = DerivedDofDao(handles.cfg);
val = str2double(get(hObject,'String'));
dcfg.kfactor = val;


function fztarget_Callback(hObject, eventdata, handles) %#ok<INUSL,*DEFNU>
% hObject    handle to fztarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fztarget as text
%        str2double(get(hObject,'String')) returns contents of fztarget as a double
dcfg = DerivedDofDao(handles.cfg);
val = str2double(get(hObject,'String'));
dcfg.Fztarget = val;


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.DerivedDofs);
