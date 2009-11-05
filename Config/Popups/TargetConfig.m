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

% Last Modified by GUIDE v2.5 03-Nov-2009 13:11:41

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
idx = 1;
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'cfg'
                cfg = varargin{index+1};
            case 'idx'
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
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.save();
delete(handles.TargetConfig);


% --- Executes when entered data in editable cell(s) in modelControlPoints.
function modelControlPoints_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to modelControlPoints (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCell(eventdata.Indices,eventdata.EditData,eventdata.Error);


% --- Executes on button press in advanced.
function advanced_Callback(hObject, eventdata, handles)
% hObject    handle to advanced (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in modelControlPoints.
function modelControlPoints_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to modelControlPoints (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
