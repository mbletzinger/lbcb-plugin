function varargout = ConfigVarsConfig(varargin)
% CORRECTIONSETTINGSCONFIG M-file for CorrectionSettingsConfig.fig
%      CORRECTIONSETTINGSCONFIG, by itself, creates a new CORRECTIONSETTINGSCONFIG or raises the existing
%      singleton*.
%
%      H = CORRECTIONSETTINGSCONFIG returns the handle to a new CORRECTIONSETTINGSCONFIG or the handle to
%      the existing singleton*.
%
%      CORRECTIONSETTINGSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORRECTIONSETTINGSCONFIG.M with the given input arguments.
%
%      CORRECTIONSETTINGSCONFIG('Property','Value',...) creates a new CORRECTIONSETTINGSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CorrectionSettingsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CorrectionSettingsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CorrectionSettingsConfig

% Last Modified by GUIDE v2.5 12-Jul-2010 13:20:16

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


% --- Executes just before CorrectionSettingsConfig is made visible.
function ConfigVarsConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CorrectionSettingsConfig (see VARARGIN)

% Choose default command line output for CorrectionSettingsConfig
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
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


% --- Executes on button press in Ok.
function Ok_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.ConfigVarsConfig);


% --- Executes when entered data in editable cell(s) in CfgSettings.
function CfgSettings_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to CfgSettings (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCell(eventdata.Indices,eventdata.NewData,eventdata.Error);
