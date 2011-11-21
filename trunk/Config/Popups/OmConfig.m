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

% Last Modified by GUIDE v2.5 30-Aug-2011 11:12:44

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


function varargout = OmConfig_OutputFcn(hObject, eventdata, handles)  %#ok<INUSD>
varargout{1} = 1;


function numLbcbs_Callback(hObject, eventdata, handles)
handles.actions.setNumLbcbs(get(hObject,'Value'));

function ok_Callback(hObject, eventdata, handles) %#ok<*INUSL>
delete(handles.OmConfig);

function sensorTable_CellEditCallback(hObject, eventdata, handles) %#ok<INUSL,*DEFNU>
handles.actions.setCell(eventdata.Indices,eventdata.NewData,eventdata.Error);

function addSensor_Callback(hObject, eventdata, handles)
handles.actions.addSensor();

function removeSensor_Callback(hObject, eventdata, handles)
handles.actions.removeSensor();

function sensorTable_CellSelectionCallback(hObject, eventdata, handles)
handles.actions.selectedRow(eventdata.Indices);

function upSensor_Callback(hObject, eventdata, handles)
handles.actions.upSensor();

function downSensor_Callback(hObject, eventdata, handles)
handles.actions.downSensor();

function maxFunEvals_Callback(hObject, eventdata, handles)
handles.actions.setOptsetMaxFunEvals(get(hObject,'String'));

function maxIter_Callback(hObject, eventdata, handles)
handles.actions.setOptsetMaxIter(get(hObject,'String'));

function tolFun_Callback(hObject, eventdata, handles)
handles.actions.setOptsetTolFun(get(hObject,'String'));

function tolX_Callback(hObject, eventdata, handles)
handles.actions.setOptsetTolX(get(hObject,'String'));

function jacob_Callback(hObject, eventdata, handles)
handles.actions.setOptsetJacob(get(hObject,'String'));


function transPert_Callback(hObject, eventdata, handles)
handles.actions.setTransPert(get(hObject,'String'));


function rotPert_Callback(hObject, eventdata, handles)
handles.actions.setRotPert(get(hObject,'String'));
