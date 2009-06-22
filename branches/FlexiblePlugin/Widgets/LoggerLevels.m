function varargout = LoggerLevels(varargin)
% LOGGERLEVELS M-file for LoggerLevels.fig
%      LOGGERLEVELS, by itself, creates a new LOGGERLEVELS or raises the existing
%      singleton*.
%
%      H = LOGGERLEVELS returns the handle to a new LOGGERLEVELS or the handle to
%      the existing singleton*.
%
%      LOGGERLEVELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGGERLEVELS.M with the given input arguments.
%
%      LOGGERLEVELS('Property','Value',...) creates a new LOGGERLEVELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LoggerLevels_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LoggerLevels_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LoggerLevels

% Last Modified by GUIDE v2.5 22-Jun-2009 17:07:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LoggerLevels_OpeningFcn, ...
                   'gui_OutputFcn',  @LoggerLevels_OutputFcn, ...
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


% --- Executes just before LoggerLevels is made visible.
function LoggerLevels_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LoggerLevels (see VARARGIN)

% Choose default command line output for LoggerLevels
handles.output = hObject;
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
log = Logger;
handles.dao = LogLevelsDao(cfg);
popups = StateEnum(log.levelTypes.states);
set(handles.CmdLevel,'String',popups.states');
set(handles.MsgLevel,'String',popups.states');
popups.setState(handles.dao.cmdLevel);
set(handles.CmdLevel,'Value',popups.idx);
popups.setState(handles.dao.msgLevel);
set(handles.MsgLevel,'Value',popups.idx);
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes LoggerLevels wait for user response (see UIRESUME)
% uiwait(handles.LoggerLevels);


% --- Outputs from this function are returned to the command line.
function varargout = LoggerLevels_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in CmdLevel.
function CmdLevel_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to CmdLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
handles.dao.cmdLevel = value;

% Hints: contents = get(hObject,'String') returns CmdLevel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CmdLevel


% --- Executes during object creation, after setting all properties.
function CmdLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CmdLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ok.
function Ok_Callback(hObject, eventdata, handles)
% hObject    handle to Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.LoggerLevels);


% --- Executes on selection change in MsgLevel.
function MsgLevel_Callback(hObject, eventdata, handles)
% hObject    handle to MsgLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MsgLevel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MsgLevel
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
handles.dao.msgLevel = value;


% --- Executes during object creation, after setting all properties.
function MsgLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MsgLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
