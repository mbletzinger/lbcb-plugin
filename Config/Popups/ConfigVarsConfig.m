function varargout = ConfigVarsConfig(varargin)
% CONFIGVARSCONFIG M-file for ConfigVarsConfig.fig
%      CONFIGVARSCONFIG, by itself, creates a new CONFIGVARSCONFIG or raises the existing
%      singleton*.
%
%      H = CONFIGVARSCONFIG returns the handle to a new CONFIGVARSCONFIG or the handle to
%      the existing singleton*.
%
%      CONFIGVARSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGVARSCONFIG.M with the given input arguments.
%
%      CONFIGVARSCONFIG('Property','Value',...) creates a new CONFIGVARSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ConfigVarsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ConfigVarsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ConfigVarsConfig

% Last Modified by GUIDE v2.5 01-May-2012 02:10:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConfigVarsConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @ConfigVarsConfig_OutputFcn, ...
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


% --- Executes just before ConfigVarsConfig is made visible.
function ConfigVarsConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ConfigVarsConfig (see VARARGIN)

% Choose default command line output for ConfigVarsConfig
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
handles.actions = ConfigVarsConfigActions(cfg);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.ConfigVarsConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CorrectionSettings wait for user response (see UIRESUME)
uiwait(handles.ConfigVarsConfig);


% --- Outputs from this function are returned to the command line.
function varargout = ConfigVarsConfig_OutputFcn(hObject, eventdata, handles) 
varargout{1} = 1;


% --- Executes on button press in Ok.
function Ok_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
delete(handles.ConfigVarsConfig);


% --- Executes when entered data in editable cell(s) in CfgSettings.
function CfgSettings_CellEditCallback(hObject, eventdata, handles)
handles.actions.setCell(eventdata.Indices,eventdata.NewData,eventdata.Error);
