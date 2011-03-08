function varargout = StepConfig(varargin)
% STEPCONFIG M-file for StepConfig.fig
%      STEPCONFIG, by itself, creates a new STEPCONFIG or raises the existing
%      singleton*.
%
%      H = STEPCONFIG returns the handle to a new STEPCONFIG or the handle to
%      the existing singleton*.
%
%      STEPCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEPCONFIG.M with the given input arguments.
%
%      STEPCONFIG('Property','Value',...) creates a new STEPCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StepConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StepConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StepConfig

% Last Modified by GUIDE v2.5 04-Feb-2011 11:48:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StepConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @StepConfig_OutputFcn, ...
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


% --- Executes just before StepConfig is made visible.
function StepConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StepConfig (see VARARGIN)

% Choose default command line output for StepConfig
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
handles.actions = StepConfigActions(cfg);
handles.actions.initialize(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StepConfig wait for user response (see UIRESUME)
% uiwait(handles.StepConfig);


% --- Outputs from this function are returned to the command line.
function varargout = StepConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function DoStepSplitting_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
handles.actions.setDoStepSplitting(get(hObject,'Value'));

% --- Executes when entered data in editable cell(s) in SubStepIncrements.
function SubStepIncrements_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to SubStepIncrements (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setSsICell(eventdata.Indices,eventdata.EditData);

function CorrectionPerSubstep_Callback(hObject, eventdata, handles)
handles.actions.setCorrectionPerSubstep(get(hObject,'String'));

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
delete(handles.StepConfig);


% --- Executes on button press in doSubstepCorrection.
function doSubstepCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to doSubstepCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of doSubstepCorrection
if get(hObject,'Value') 
    return;
end
handles.actions.setCorrectionPerSubstep('0');


function substepTriggering_Callback(hObject, eventdata, handles)
handles.actions.setTriggeringPerSubstep(get(hObject,'String'));


% --- Executes on button press in doSubstepTriggering.
function doSubstepTriggering_Callback(hObject, eventdata, handles)
if get(hObject,'Value') 
    return;
end
handles.actions.setTriggeringPerSubstep('0');


% --- Executes when entered data in editable cell(s) in CorrectionTable.
function CorrectionTable_CellEditCallback(hObject, eventdata, handles)
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCorrectionCell(eventdata.Indices,eventdata.EditData);


% --- Executes on selection change in edPrelimAdjust.
function edPrelimAdjust_Callback(hObject, eventdata, handles)
handles.actions.setPrelimAdjust(get(hObject,'Value'),1);


% --- Executes on selection change in ddPrelimAdjust.
function ddPrelimAdjust_Callback(hObject, eventdata, handles)
handles.actions.setPrelimAdjust(get(hObject,'Value'),2);



function triggerDelay_Callback(hObject, eventdata, handles)
handles.actions.setTriggeringDelay(get(hObject,'String'));

