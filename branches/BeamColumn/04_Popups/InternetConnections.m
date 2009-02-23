function varargout = InternetConnections(varargin)
% INTERNETCONNECTIONS M-file for InternetConnections.fig
%      INTERNETCONNECTIONS, by itself, creates a new INTERNETCONNECTIONS or raises the existing
%      singleton*.
%
%      H = INTERNETCONNECTIONS returns the handle to a new INTERNETCONNECTIONS or the handle to
%      the existing singleton*.
%
%      INTERNETCONNECTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERNETCONNECTIONS.M with the given input arguments.
%
%      INTERNETCONNECTIONS('Property','Value',...) creates a new INTERNETCONNECTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InternetConnections_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InternetConnections_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InternetConnections

% Last Modified by GUIDE v2.5 17-Feb-2009 14:39:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InternetConnections_OpeningFcn, ...
                   'gui_OutputFcn',  @InternetConnections_OutputFcn, ...
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


% --- Executes just before InternetConnections is made visible.
function InternetConnections_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InternetConnections (see VARARGIN)
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'values'
          inputData = varargin{index+1};
        end
    end
end
handles.default = inputData;
handles.connectionData = inputData;
handles.output = inputData;
set(handles.LbcbOmHost, 'String', inputData.LbcbOmHost);
set(handles.LbcbOmPort, 'String', inputData.LbcbOmPort);
set(handles.SimCorHost, 'String', inputData.SimCorHost);
set(handles.SimCorPort, 'String', inputData.SimCorPort);
set(handles.DaqHost, 'String', inputData.DaqHost);
set(handles.DaqPort, 'String', inputData.DaqPort);
set(handles.CameraHosts,'String', inputData.CameraHosts,'Value',1);
set(handles.CameraPorts,'String', inputData.CameraPorts,'Value',1);

Update(hObject, handles,inputData);

% Make the GUI modal
set(handles.InternetConnections,'WindowStyle','modal');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InternetConnections wait for user response (see UIRESUME)
 uiwait(handles.InternetConnections);


% --- Outputs from this function are returned to the command line.
function varargout = InternetConnections_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The GUI is no longer waiting, just close it
delete(handles.InternetConnections);



function LbcbOmHost_Callback(hObject, eventdata, handles)
% hObject    handle to LbcbOmHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LbcbOmHost as text
%        str2double(get(hObject,'String')) returns contents of LbcbOmHost as a double
connectionData = handles.connectionData;
connectionData.LbcbOmHost = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function LbcbOmHost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LbcbOmHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LbcbOmPort_Callback(hObject, eventdata, handles)
% hObject    handle to LbcbOmPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LbcbOmPort as text
%        str2double(get(hObject,'String')) returns contents of LbcbOmPort as a double
connectionData = handles.connectionData;
connectionData.LbcbOmPort = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function LbcbOmPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LbcbOmPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SimCorHost_Callback(hObject, eventdata, handles)
% hObject    handle to SimCorHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SimCorHost as text
%        str2double(get(hObject,'String')) returns contents of SimCorHost as a double
connectionData = handles.connectionData;
connectionData.SimCorHost = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function SimCorHost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SimCorHost (see GCBO)
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
connectionData = handles.connectionData;
connectionData.SimCorPort = get(hObject,'String');
Update(hObject, handles,connectionData);


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



function DaqHost_Callback(hObject, eventdata, handles)
% hObject    handle to DaqHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DaqHost as text
%        str2double(get(hObject,'String')) returns contents of DaqHost as a double
connectionData = handles.connectionData;
connectionData.DaqHost = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function DaqHost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DaqHost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DaqPort_Callback(hObject, eventdata, handles)
% hObject    handle to DaqPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DaqPort as text
%        str2double(get(hObject,'String')) returns contents of DaqPort as a double
connectionData = handles.connectionData;
connectionData.DaqPort = get(hObject,'String');
Update(hObject, handles,connectionData);


% --- Executes during object creation, after setting all properties.
function DaqPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DaqPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CameraHosts.
function CameraHosts_Callback(hObject, eventdata, handles)
% hObject    handle to CameraHosts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns CameraHosts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CameraHosts


% --- Executes during object creation, after setting all properties.
function CameraHosts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraHosts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CameraPorts.
function CameraPorts_Callback(hObject, eventdata, handles)
% hObject    handle to CameraPorts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns CameraPorts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CameraPorts


% --- Executes during object creation, after setting all properties.
function CameraPorts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraPorts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
uiresume(handles.InternetConnections);


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.InternetConnections);

function Update(hObject, handles,connectionData)
handles.connectionData = connectionData;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in editCamera.
function editCamera_Callback(hObject, eventdata, handles)
% hObject    handle to editCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V = get(handles.CameraHosts, 'Value');
hosts = get(handles.CameraHosts, 'String');
cam.Host = hosts{V};
ports = get(handles.CameraPorts, 'String');
cam.Port = ports{V};
cam = CameraConnection('values',cam);
hosts{V} = cam.Host;
ports{V} = cam.Port;
set(handles.CameraHosts, 'String',hosts);
set(handles.CameraPorts, 'String',ports);
connectionData = handles.connectionData;
connectionData.CameraPorts = ports;
connectionData.CameraHosts = hosts;
Update(hObject, handles,connectionData);


% --- Executes on button press in newCamera.
function newCamera_Callback(hObject, eventdata, handles)
% hObject    handle to newCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hosts = get(handles.CameraHosts, 'String');
ports = get(handles.CameraPorts, 'String');
cam.Host = '127.0.0.1';
cam.Port = '1000';
cam = CameraConnection('values',cam);
hosts{size(hosts,1) + 1} = cam.Host;
ports{size(ports,1) + 1} = cam.Port;
set(handles.CameraHosts, 'String',hosts);
set(handles.CameraPorts, 'String',ports);
connectionData = handles.connectionData;
connectionData.CameraPorts = ports;
connectionData.CameraHosts = hosts;
Update(hObject, handles,connectionData);

% --- Executes on button press in deleteCamera.
function deleteCamera_Callback(hObject, eventdata, handles)
% hObject    handle to deleteCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V = get(handles.CameraHosts, 'Value');
hosts = get(handles.CameraHosts, 'String');
ports = get(handles.CameraPorts, 'String');
hosts(V) = [];
ports(V) = [];
if V > 1
    V = V-1;
end;
set(handles.CameraHosts, 'String',hosts);
set(handles.CameraPorts, 'String',ports);
set(handles.CameraHosts, 'Value',V);
set(handles.CameraPorts, 'Value',V);
connectionData = handles.connectionData;
connectionData.CameraPorts = ports;
connectionData.CameraHosts = hosts;
Update(hObject, handles,connectionData);


