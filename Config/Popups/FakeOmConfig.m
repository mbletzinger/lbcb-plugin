function varargout = FakeOmConfig(varargin)
% FAKEOMCONFIG M-file for FakeOmConfig.fig
%      FAKEOMCONFIG, by itself, creates a new FAKEOMCONFIG or raises the existing
%      singleton*.
%
%      H = FAKEOMCONFIG returns the handle to a new FAKEOMCONFIG or the handle to
%      the existing singleton*.
%
%      FAKEOMCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAKEOMCONFIG.M with the given input arguments.
%
%      FAKEOMCONFIG('Property','Value',...) creates a new FAKEOMCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FakeOmConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FakeOmConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FakeOmConfig

% Last Modified by GUIDE v2.5 18-Jan-2010 11:11:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FakeOmConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @FakeOmConfig_OutputFcn, ...
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


% --- Executes just before FakeOmConfig is made visible.
function FakeOmConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FakeOmConfig (see VARARGIN)

% Choose default command line output for FakeOmConfig
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
handles.actions = FakeOmConfigActions(cfg);
handles.actions.initialize(handles);
set(handles.FakeOmConfig,'WindowStyle','modal')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FakeOmConfig wait for user response (see UIRESUME)
% uiwait(handles.FakeOmConfig);


% --- Outputs from this function are returned to the command line.
function varargout = FakeOmConfig_OutputFcn(hObject, eventdata, handles) 
varargout{1} = 1;



function NumConvergenceSteps_Callback(hObject, eventdata, handles)
% hObject    handle to NumConvergenceSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumConvergenceSteps as text
%        str2double(get(hObject,'String')) returns contents of NumConvergenceSteps as a double
handles.actions.setNumConvergenceSteps(sscanf(get(hObject,'String'),'%d'));


function ConvergenceIncrement_Callback(hObject, eventdata, handles)
% hObject    handle to ConvergenceIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConvergenceIncrement as text
%        str2double(get(hObject,'String')) returns contents of ConvergenceIncrement as a double
handles.actions.setConvergenceIncrement(sscanf(get(hObject,'String'),'%d'));


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.FakeOmConfig);

% --- Executes when entered data in editable cell(s) in LbcbDofTable.
function LbcbDofTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to LbcbDofTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setDofCell(eventdata.Indices,eventdata.NewData,eventdata.Error);

% --- Executes when entered data in editable cell(s) in ExtSensorTable.
function ExtSensorTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to ExtSensorTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setExtSensCell(eventdata.Indices,eventdata.NewData,eventdata.Error);
