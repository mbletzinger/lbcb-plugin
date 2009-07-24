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

% Last Modified by GUIDE v2.5 24-Jul-2009 17:08:21

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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OmConfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OmConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in numLbcbs.
function numLbcbs_Callback(hObject, eventdata, handles)
% hObject    handle to numLbcbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns numLbcbs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numLbcbs


% --- Executes during object creation, after setting all properties.
function numLbcbs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numLbcbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fakeOmProps.
function fakeOmProps_Callback(hObject, eventdata, handles)
% hObject    handle to fakeOmProps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in useFakeOm.
function useFakeOm_Callback(hObject, eventdata, handles)
% hObject    handle to useFakeOm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of useFakeOm


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
