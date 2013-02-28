function varargout = AdvancedTargetConfig(varargin)
% ADVANCEDTARGETCONFIG M-file for AdvancedTargetConfig.fig
%      ADVANCEDTARGETCONFIG, by itself, creates a new ADVANCEDTARGETCONFIG or raises the existing
%      singleton*.
%
%      H = ADVANCEDTARGETCONFIG returns the handle to a new ADVANCEDTARGETCONFIG or the handle to
%      the existing singleton*.
%
%      ADVANCEDTARGETCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADVANCEDTARGETCONFIG.M with the given input arguments.
%
%      ADVANCEDTARGETCONFIG('Property','Value',...) creates a new ADVANCEDTARGETCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AdvancedTargetConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AdvancedTargetConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AdvancedTargetConfig

% Last Modified by GUIDE v2.5 03-Nov-2009 14:54:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AdvancedTargetConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @AdvancedTargetConfig_OutputFcn, ...
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


% --- Executes just before AdvancedTargetConfig is made visible.
function AdvancedTargetConfig_OpeningFcn(hObject, eventdata, handles, varargin) 
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AdvancedTargetConfig (see VARARGIN)

% Choose default command line output for AdvancedTargetConfig
handles.output = hObject;
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
                idx = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.cfg = cfg;
handles.actions = AdvancedTargetConfigActions(cfg);
handles.actions.init(handles);

% Make the GUI modal
set(handles.AdvancedTargetConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AdvancedTargetConfig wait for user response (see UIRESUME)
 uiwait(handles.AdvancedTargetConfig);


% --- Outputs from this function are returned to the command line.
function varargout = AdvancedTargetConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;



function OffsetDx_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to OffsetDx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDx as text
%        str2double(get(hObject,'String')) returns contents of OffsetDx as a double
handles.actions.setOffset(1,get(hObject,'String'));



function OffsetDy_Callback(hObject, eventdata, handles)
% hObject    handle to OffsetDy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDy as text
%        str2double(get(hObject,'String')) returns contents of OffsetDy as a double
handles.actions.setOffset(2,get(hObject,'String'));


function OffsetDz_Callback(hObject, eventdata, handles)
% hObject    handle to OffsetDz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffsetDz as text
%        str2double(get(hObject,'String')) returns contents of OffsetDz as a double
handles.actions.setOffset(3,get(hObject,'String'));


function Address_Callback(hObject, eventdata, handles)
% hObject    handle to Address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Address as text
%        str2double(get(hObject,'String')) returns contents of Address as a double
handles.actions.setAddress(get(hObject,'String'));

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.AdvancedTargetConfig);


% --- Executes when entered data in editable cell(s) in Xform.
function Xform_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Xform (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCell(eventdata.Indices,eventdata.NewData,eventdata.Error);
