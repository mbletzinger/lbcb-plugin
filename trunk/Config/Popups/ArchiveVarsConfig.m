function varargout = ArchiveVarsConfig(varargin)
% ARCHIVEVARSCONFIG MATLAB code for ArchiveVarsConfig.fig
%      ARCHIVEVARSCONFIG, by itself, creates a new ARCHIVEVARSCONFIG or raises the existing
%      singleton*.
%
%      H = ARCHIVEVARSCONFIG returns the handle to a new ARCHIVEVARSCONFIG or the handle to
%      the existing singleton*.
%
%      ARCHIVEVARSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARCHIVEVARSCONFIG.M with the given input arguments.
%
%      ARCHIVEVARSCONFIG('Property','Value',...) creates a new ARCHIVEVARSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ArchiveVarsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ArchiveVarsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ArchiveVarsConfig

% Last Modified by GUIDE v2.5 09-Apr-2012 13:59:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ArchiveVarsConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @ArchiveVarsConfig_OutputFcn, ...
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


% --- Executes just before ArchiveVarsConfig is made visible.
function ArchiveVarsConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ArchiveVarsConfig (see VARARGIN)

% Choose default command line output for ArchiveVarsConfig
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
handles.actions = ArchiveVarsConfigActions(cfg);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.ArchiveVarsConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CorrectionSettings wait for user response (see UIRESUME)
uiwait(handles.ArchiveVarsConfig);


% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ArchiveVarsConfig_OutputFcn(hObject, eventdata, handles) 
varargout{1} = 1;

% --- Executes on selection change in varList.
function varList_Callback(hObject, eventdata, handles)

% --- Executes on button press in addVar.
function addVar_Callback(hObject, eventdata, handles)

% --- Executes on button press in removeVar.
function removeVar_Callback(hObject, eventdata, handles)

% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
