function varargout = OffsetsConfig(varargin)
% OFFSETSCONFIG M-file for OffsetsConfig.fig
%      OFFSETSCONFIG, by itself, creates a new OFFSETSCONFIG or raises the existing
%      singleton*.
%
%      H = OFFSETSCONFIG returns the handle to a new OFFSETSCONFIG or the handle to
%      the existing singleton*.
%
%      OFFSETSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OFFSETSCONFIG.M with the given input arguments.
%
%      OFFSETSCONFIG('Property','Value',...) creates a new OFFSETSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OffsetsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OffsetsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OffsetsConfig

% Last Modified by GUIDE v2.5 28-Oct-2011 08:54:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OffsetsConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @OffsetsConfig_OutputFcn, ...
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


% --- Executes just before OffsetsConfig is made visible.
function OffsetsConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OffsetsConfig (see VARARGIN)

% Choose default command line output for OffsetsConfig
handles.output = hObject;
cfg = [];
ocfg = [];
fact = [];
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'cfg'
                cfg = varargin{index+1};
            case 'ocfg'
                ocfg = varargin{index+1};
            case 'fact'
                fact = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.cfg = cfg;
handles.actions = OffsetsConfigActions(ocfg, cfg, fact);
handles.actions.initialize(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OffsetsConfig wait for user response (see UIRESUME)
uiwait(handles.OffsetsConfig);


% --- Outputs from this function are returned to the command line.
function varargout = OffsetsConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ok_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
delete(handles.OffsetsConfig);


function refresh_Callback(hObject, eventdata, handles)
handles.actions.refresh();


function set_Callback(hObject, eventdata, handles)
handles.actions.setLengths();


function import_Callback(hObject, eventdata, handles)
handles.actions.import();


function reload_Callback(hObject, eventdata, handles)
handles.actions.reload();

function offsetsTable_CellEditCallback(hObject, eventdata, handles)
handles.actions.editOffset(eventdata.Indices,eventdata.EditData,0);


function Export_Callback(hObject, eventdata, handles)
handles.actions.export();
