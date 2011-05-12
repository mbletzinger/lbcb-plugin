function varargout = IncrementLimitsConfig(varargin)
% INCREMENTLIMITSCONFIG M-file for IncrementLimitsConfig.fig
%      INCREMENTLIMITSCONFIG, by itself, creates a new INCREMENTLIMITSCONFIG or raises the existing
%      singleton*.
%
%      H = INCREMENTLIMITSCONFIG returns the handle to a new INCREMENTLIMITSCONFIG or the handle to
%      the existing singleton*.
%
%      INCREMENTLIMITSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INCREMENTLIMITSCONFIG.M with the given input arguments.
%
%      INCREMENTLIMITSCONFIG('Property','Value',...) creates a new INCREMENTLIMITSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IncrementLimitsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IncrementLimitsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IncrementLimitsConfig

% Last Modified by GUIDE v2.5 12-May-2011 08:29:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IncrementLimitsConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @IncrementLimitsConfig_OutputFcn, ...
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


% --- Executes just before IncrementLimitsConfig is made visible.
function IncrementLimitsConfig_OpeningFcn(hObject, eventdata, handles, varargin)
cfg = [];
pstep = [];
cstep = [];
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'cfg'
                cfg = varargin{index+1};
            case 'pstep'
                pstep = varargin{index+1};
            case 'cstep'
                cstep = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.cfg = cfg;
handles.actions = IncrementLimitsConfigActions(cfg,pstep,cstep);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.IncrementLimitsConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OmConfig wait for user response (see UIRESUME)
uiwait(handles.IncrementLimitsConfig);

function varargout = IncrementLimitsConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


function Lbcb_Callback(hObject, eventdata, handles)
handles.actions.fill();


function Ok_Callback(hObject, eventdata, handles)
delete(handles.IncrementLimitsConfig);


function LimitsTable_CellEditCallback(hObject, eventdata, handles)
handles.actions.setCell(eventdata.Indices,eventdata.NewData);
