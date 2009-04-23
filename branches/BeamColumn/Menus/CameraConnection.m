function varargout = CameraConnection(varargin)
% CAMERACONNECTION M-file for CameraConnection.fig
%      CAMERACONNECTION, by itself, creates a new CAMERACONNECTION or raises the existing
%      singleton*.
%
%      H = CAMERACONNECTION returns the handle to a new CAMERACONNECTION or the handle to
%      the existing singleton*.
%
%      CAMERACONNECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERACONNECTION.M with the given input arguments.
%
%      CAMERACONNECTION('Property','Value',...) creates a new CAMERACONNECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CameraConnection_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CameraConnection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CameraConnection

% Last Modified by GUIDE v2.5 17-Feb-2009 14:57:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CameraConnection_OpeningFcn, ...
                   'gui_OutputFcn',  @CameraConnection_OutputFcn, ...
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


% --- Executes just before CameraConnection is made visible.
function CameraConnection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CameraConnection (see VARARGIN)
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'values'
          inputData = varargin{index+1};
        end
    end
end
set(hObject, 'Name','Camera Controller Connections');
handles.default = inputData;
handles.connectionData = inputData;
handles.output = inputData;
set(handles.editHost, 'String', inputData.Host);
set(handles.editPort, 'String', inputData.Port);

Update(hObject, handles,inputData);

% Make the GUI modal
set(handles.CameraConnection,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CameraConnection wait for user response (see UIRESUME)
uiwait(handles.CameraConnection);


% --- Outputs from this function are returned to the command line.
function varargout = CameraConnection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.CameraConnection);

% --- Executes when user attempts to close figure1.
function CameraConnection_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


function editHost_Callback(hObject, eventdata, handles)
% hObject    handle to editHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHost as text
%        str2double(get(hObject,'String')) returns contents of editHost as a double
connectionData = handles.connectionData;
connectionData.Host = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function editHost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPort_Callback(hObject, eventdata, handles)
% hObject    handle to editPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPort as text
%        str2double(get(hObject,'String')) returns contents of editPort as a double
connectionData = handles.connectionData;
connectionData.Port = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function editPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.connectionData; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.CameraConnection);


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.CameraConnection);

function Update(hObject, handles,connectionData)
handles.connectionData = connectionData;
% Update handles structure
guidata(hObject, handles);


