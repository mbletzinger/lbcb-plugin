% =====================================================================================================================
% Widget which allows the network config to be modified.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
function varargout = NetworkConfig(varargin)
% NETWORKCONFIG M-file for NetworkConfig.fig
%      NETWORKCONFIG, by itself, creates a new NETWORKCONFIG or raises the existing
%      singleton*.
%
%      H = NETWORKCONFIG returns the handle to a new NETWORKCONFIG or the handle to
%      the existing singleton*.
%
%      NETWORKCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NETWORKCONFIG.M with the given input arguments.
%
%      NETWORKCONFIG('Property','Value',...) creates a new NETWORKCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NetworkConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NetworkConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NetworkConfig

% Last Modified by GUIDE v2.5 02-Jun-2009 16:51:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NetworkConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @NetworkConfig_OutputFcn, ...
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


% --- Executes just before NetworkConfig is made visible.
function NetworkConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NetworkConfig (see VARARGIN)

% Choose default command line output for NetworkConfig
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

handles.dao = NetworkConfigDao(cfg);

set(handles.omHost,'String',handles.dao.omHost);
set(handles.OmPort,'String',handles.dao.omPort);
set(handles.SimCorPort,'String',handles.dao.simcorPort);
set(handles.TriggerPort,'String',handles.dao.triggerPort);
set(handles.timeout,'String',handles.dao.timeout);

% Make the GUI modal
set(handles.NetworkConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NetworkConfig wait for user response (see UIRESUME)
% uiwait(handles.NetworkConfig);


% --- Outputs from this function are returned to the command line.
function varargout = NetworkConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

% if isequal(get(handles.NetworkConfig, 'waitstatus'), 'waiting')
%     % The GUI is still in UIWAIT, us UIRESUME
%     uiresume(handles.NetworkConfig);
% else
%     % The GUI is no longer waiting, just close it
%     delete(handles.NetworkConfig);
% end
% 
% varargout{1} = handles.output;



function omHost_Callback(hObject, eventdata, handles)
% hObject    handle to omHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of omHost as text
%        str2double(get(hObject,'String')) returns contents of omHost as a double
handles.dao.omHost = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function omHost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to omHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OmPort_Callback(hObject, eventdata, handles)
% hObject    handle to OmPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dao.omPort = get(hObject,'String');

% Hints: get(hObject,'String') returns contents of OmPort as text
%        str2double(get(hObject,'String')) returns contents of OmPort as a double


% --- Executes during object creation, after setting all properties.
function OmPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OmPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TriggerPort_Callback(hObject, eventdata, handles)
% hObject    handle to TriggerPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TriggerPort as text
%        str2double(get(hObject,'String')) returns contents of TriggerPort as a double
handles.dao.triggerPort = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function TriggerPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TriggerPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeout_Callback(hObject, eventdata, handles)
% hObject    handle to timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeout as text
%        str2double(get(hObject,'String')) returns contents of timeout as a double
handles.dao.timeout = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function timeout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SimCorPort_Callback(hObject, eventdata, handles)
% hObject    handle to SimCorPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SimCorPort as text
%        str2double(get(hObject,'String')) returns contents of SimCorPort as a double
handles.dao.simcorPort = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function SimCorPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SimCorPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OkButton.
function OkButton_Callback(hObject, eventdata, handles)
% hObject    handle to OkButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.NetworkConfig);
