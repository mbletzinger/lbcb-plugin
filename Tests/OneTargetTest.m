function varargout = OneTargetTest(varargin)
% ONETARGETTEST M-file for OneTargetTest.fig
%      ONETARGETTEST, by itself, creates a new ONETARGETTEST or raises the existing
%      singleton*.
%
%      H = ONETARGETTEST returns the handle to a new ONETARGETTEST or the handle to
%      the existing singleton*.
%
%      ONETARGETTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONETARGETTEST.M with the given input arguments.
%
%      ONETARGETTEST('Property','Value',...) creates a new ONETARGETTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OneTargetTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OneTargetTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OneTargetTest

% Last Modified by GUIDE v2.5 03-Jun-2009 12:53:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OneTargetTest_OpeningFcn, ...
                   'gui_OutputFcn',  @OneTargetTest_OutputFcn, ...
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


% --- Executes just before OneTargetTest is made visible.
function OneTargetTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OneTargetTest (see VARARGIN)

% Choose default command line output for OneTargetTest
handles.output = hObject;

javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary'));

handles.cfg = Configuration;
handles.cfg.load();
handles.actions = OneTargetActions(handles.cfg);

handles.utimer = timer('Period',1, 'TasksToExecute',100000,'ExecutionMode','fixedSpacing', 'Name','SimulationTimer');
handles.utimer.TimerFcn = { @executeSimulation,hObject,handles};
start(handles.utimer);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OneTargetTest wait for user response (see UIRESUME)
% uiwait(handles.OneTarget);


% --- Outputs from this function are returned to the command line.
function varargout = OneTargetTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function L1Dx_Callback(hObject, eventdata, handles)
% hObject    handle to L1Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Dx as text
%        str2double(get(hObject,'String')) returns contents of L1Dx as a double


% --- Executes during object creation, after setting all properties.
function L1Dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L1Rx_Callback(hObject, eventdata, handles)
% hObject    handle to L1Rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Rx as text
%        str2double(get(hObject,'String')) returns contents of L1Rx as a double


% --- Executes during object creation, after setting all properties.
function L1Rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L1Dy_Callback(hObject, eventdata, handles)
% hObject    handle to L1Dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Dy as text
%        str2double(get(hObject,'String')) returns contents of L1Dy as a double


% --- Executes during object creation, after setting all properties.
function L1Dy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L1Ry_Callback(hObject, eventdata, handles)
% hObject    handle to L1Ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Ry as text
%        str2double(get(hObject,'String')) returns contents of L1Ry as a double


% --- Executes during object creation, after setting all properties.
function L1Ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L1Dz_Callback(hObject, eventdata, handles)
% hObject    handle to L1Dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Dz as text
%        str2double(get(hObject,'String')) returns contents of L1Dz as a double


% --- Executes during object creation, after setting all properties.
function L1Dz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L1Rz_Callback(hObject, eventdata, handles)
% hObject    handle to L1Rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L1Rz as text
%        str2double(get(hObject,'String')) returns contents of L1Rz as a double


% --- Executes during object creation, after setting all properties.
function L1Rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1Rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function OmConfig_Callback(hObject, eventdata, handles)
% hObject    handle to OmConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OmConfig('cfg',handles.cfg);

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cfg.export();

% --- Executes on button press in ExecuteButton.
function ExecuteButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExecuteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NetworkConfig_Callback(hObject, eventdata, handles)
% hObject    handle to NetworkConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NetworkConfig('cfg',handles.cfg);

% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = handles.cfg.load();
if(result == 0)
    disp(handles.cfg.error);
end

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = handles.cfg.save();
if(result == 0)
    disp(handles.cfg.error);
end


% --------------------------------------------------------------------
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cfg.import();


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.OneTarget);
handles.utimer.stop()
delete(handles.utimer);

% --- Executes on button press in ConnectButton.
function ConnectButton_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 done = handles.actions.execute();
if done
    handles.action.setAction('');
end


function L2Dx_Callback(hObject, eventdata, handles)
% hObject    handle to L2Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Dx as text
%        str2double(get(hObject,'String')) returns contents of L2Dx as a double


% --- Executes during object creation, after setting all properties.
function L2Dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L2Rx_Callback(hObject, eventdata, handles)
% hObject    handle to L2Rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Rx as text
%        str2double(get(hObject,'String')) returns contents of L2Rx as a double


% --- Executes during object creation, after setting all properties.
function L2Rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L2Dy_Callback(hObject, eventdata, handles)
% hObject    handle to L2Dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Dy as text
%        str2double(get(hObject,'String')) returns contents of L2Dy as a double


% --- Executes during object creation, after setting all properties.
function L2Dy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L2Ry_Callback(hObject, eventdata, handles)
% hObject    handle to L2Ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Ry as text
%        str2double(get(hObject,'String')) returns contents of L2Ry as a double


% --- Executes during object creation, after setting all properties.
function L2Ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L2Dz_Callback(hObject, eventdata, handles)
% hObject    handle to L2Dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Dz as text
%        str2double(get(hObject,'String')) returns contents of L2Dz as a double


% --- Executes during object creation, after setting all properties.
function L2Dz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function L2Rz_Callback(hObject, eventdata, handles)
% hObject    handle to L2Rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L2Rz as text
%        str2double(get(hObject,'String')) returns contents of L2Rz as a double


% --- Executes during object creation, after setting all properties.
function L2Rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2Rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LbcbSelect.
function LbcbSelect_Callback(hObject, eventdata, handles)
% hObject    handle to LbcbSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LbcbSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LbcbSelect


% --- Executes during object creation, after setting all properties.
function LbcbSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LbcbSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function executeSimulation(obj,event,hObject,handles)
    done = handles.actions.execute();
    if done
        updateTable(handles);
        guidata(hObject, handles);
    end
    
function updateTable(handles)
lbcbS = get(handles.LbcbSelect,'Value');
tData = {};
if lbcbS == 1
    tData = handles.actions.lbcb1Table;
else
    tData = handles.actions.lbcb1Table;
end
set(handles.LbcbTable,'Data',tData);
 
