function varargout = CommandLimitsConfig(varargin)
% COMMANDLIMITSCONFIG M-file for CommandLimitsConfig.fig
%      COMMANDLIMITSCONFIG, by itself, creates a new COMMANDLIMITSCONFIG or raises the existing
%      singleton*.
%
%      H = COMMANDLIMITSCONFIG returns the handle to a new COMMANDLIMITSCONFIG or the handle to
%      the existing singleton*.
%
%      COMMANDLIMITSCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMMANDLIMITSCONFIG.M with the given input arguments.
%
%      COMMANDLIMITSCONFIG('Property','Value',...) creates a new COMMANDLIMITSCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CommandLimitsConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CommandLimitsConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CommandLimitsConfig

% Last Modified by GUIDE v2.5 12-May-2011 00:34:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CommandLimitsConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @CommandLimitsConfig_OutputFcn, ...
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


function CommandLimitsConfig_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
cfg = [];
step = [];
cl = [];
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'step'
                step = varargin{index+1};
            case 'limits'
                cl = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.cfg = cfg;
handles.actions = CommandLimitsConfigActions(cl,step);
handles.actions.initialize(handles);

% Make the GUI modal
set(handles.CommandLimitsConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OmConfig wait for user response (see UIRESUME)
uiwait(handles.CommandLimitsConfig);

function varargout = CommandLimitsConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSD>
varargout{1} = 1;

function Lbcb_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
handles.actions.fill();

function Ok_Callback(hObject, eventdata, handles)
delete(handles.CommandLimitsConfig);

function LimitsTable_CellEditCallback(hObject, eventdata, handles)
handles.actions.setCell(eventdata.Indices,eventdata.NewData);
