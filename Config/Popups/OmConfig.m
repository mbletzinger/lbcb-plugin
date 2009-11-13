function varargout = OmConfig(varargin)
% OMCONFIG M-file for OmConfig.fig
%      OMCONFIG, by itself, creates a new OMCONFIG or raises the existing
%      singleton*.
%
%      H = OMCONFIG returns the handle to a new OMCONFIG or the handle to
%      the existing singleton*.
%
%      OMCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OMCONFIG.M with the given input arguments.
%
%      OMCONFIG('Property','Value',...) creates a new OMCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OmConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OmConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OmConfig

% Last Modified by GUIDE v2.5 12-Nov-2009 21:50:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OmConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @OmConfig_OutputFcn, ...
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


% --- Executes just before OmConfig is made visible.
function OmConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OmConfig (see VARARGIN)

% Choose default command line output for OmConfig
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
handles.actions = OmConfigActions(cfg);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.OmConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OmConfig wait for user response (see UIRESUME)
uiwait(handles.OmConfig);


% --- Outputs from this function are returned to the command line.
function varargout = OmConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


% --- Executes on selection change in numLbcbs.
function numLbcbs_Callback(hObject, eventdata, handles)
% hObject    handle to numLbcbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns numLbcbs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numLbcbs
handles.actions.setNumLbcbs(get(hObject,'Value'));

% --- Executes on button press in fakeOmProps.
function fakeOmProps_Callback(hObject, eventdata, handles)
% hObject    handle to fakeOmProps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FakeOmProperties('cfg',handles.cfg)

% --- Executes on button press in useFakeOm.
function useFakeOm_Callback(hObject, eventdata, handles)
% hObject    handle to useFakeOm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of useFakeOm
handles.actions.setUseFakeOm(get(hObject,'Value'));

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.OmConfig);

% --- Executes when entered data in editable cell(s) in sensorTable.
function sensorTable_CellEditCallback(hObject, eventdata, handles) %#ok<INUSL,*DEFNU>
% hObject    handle to sensorTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCell(eventdata.Indices,eventdata.NewData,eventdata.Error);


% --- Executes when entered data in editable cell(s) in pertTable.
function pertTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to pertTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setPertCell(eventdata.Indices,eventdata.EditData);


% --- Executes on button press in addSensor.
function addSensor_Callback(hObject, eventdata, handles)
% hObject    handle to addSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.addSensor(1);


% --- Executes on button press in removeSensor.
function removeSensor_Callback(hObject, eventdata, handles)
% hObject    handle to removeSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.removeSensor(1);

% --- Executes when selected cell(s) is changed in sensorTable.
function sensorTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to sensorTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.actions.selectedRow(eventdata.Indices);
