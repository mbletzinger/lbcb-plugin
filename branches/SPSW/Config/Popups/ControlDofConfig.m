function varargout = ControlDofConfig(varargin)
% CONTROLDOFCONFIG MATLAB code for ControlDofConfig.fig
%      CONTROLDOFCONFIG, by itself, creates a new CONTROLDOFCONFIG or raises the existing
%      singleton*.
%
%      H = CONTROLDOFCONFIG returns the handle to a new CONTROLDOFCONFIG or the handle to
%      the existing singleton*.
%
%      CONTROLDOFCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLDOFCONFIG.M with the given input arguments.
%
%      CONTROLDOFCONFIG('Property','Value',...) creates a new CONTROLDOFCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ControlDofConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ControlDofConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ControlDofConfig

% Last Modified by GUIDE v2.5 11-Apr-2012 14:30:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlDofConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlDofConfig_OutputFcn, ...
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


% --- Executes just before ControlDofConfig is made visible.
function ControlDofConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ControlDofConfig (see VARARGIN)

% Choose default command line output for ControlDofConfig
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
handles.actions = ControlDofConfigActions(cfg);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.ControlDofConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CorrectionSettings wait for user response (see UIRESUME)
uiwait(handles.ControlDofConfig);

% --- Outputs from this function are returned to the command line.
function varargout = ControlDofConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSD>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} =1;

% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.ControlDofConfig);


% --- Executes when entered data in editable cell(s) in controlDofTable.
function controlDofTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to controlDofTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setControlDof(eventdata.Indices,eventdata.EditData);
