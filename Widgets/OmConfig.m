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

% Last Modified by GUIDE v2.5 16-Jun-2009 18:08:10

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

handles.dao = OmConfigDao(cfg);
handles.cfg = cfg;
handles.numTypes = StateEnum(get(handles.NumberOfLbcbsMenu,'String'));
handles.appliedTypes = StateEnum(get(handles.Applied2Lbcb1,'String'));

current = handles.dao.numLbcbs;
if isempty(current) == 0
    handles.numTypes.setState(current);
    set(handles.NumberOfLbcbsMenu,'Value',handles.numTypes.idx);
end

if isempty(handles.dao.sensorNames) == 0
    fillPopups(handles);
end

on = handles.dao.useFakeOm;
if isempty(on)
    on = 0;
end
set(handles.UseFakeOm,'Value',on);
setToggleButtonColor(handles.UseFakeOm,on);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OmConfig wait for user response (see UIRESUME)
% uiwait(handles.OmConfig);


% --- Outputs from this function are returned to the command line.
function varargout = OmConfig_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in NumberOfLbcbsMenu.
function NumberOfLbcbsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfLbcbsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns NumberOfLbcbsMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumberOfLbcbsMenu
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
handles.dao.numLbcbs = value;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function NumberOfLbcbsMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfLbcbsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OkButton.
function OkButton_Callback(hObject, eventdata, handles)
% hObject    handle to OkButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.OmConfig);

function ExtS1_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS1 as text
%        str2double(get(hObject,'String')) returns contents of ExtS1 as a double
value = get(hObject,'String');
updateSensorNames(hObject,1,value,handles);
Applied2Lbcb1_Callback(handles.Applied2Lbcb1,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function ExtS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb1.
function Applied2Lbcb1_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb1
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,1,value,handles);

% --- Executes during object creation, after setting all properties.
function Applied2Lbcb1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ExtS2_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS2 as text
%        str2double(get(hObject,'String')) returns contents of ExtS2 as a double
value = get(hObject,'String');
updateSensorNames(hObject,2,value,handles);
Applied2Lbcb2_Callback(handles.Applied2Lbcb2,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb2.
function Applied2Lbcb2_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb2
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,2,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS3_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS3 as text
%        str2double(get(hObject,'String')) returns contents of ExtS3 as a double
value = get(hObject,'String');
updateSensorNames(hObject,3,value,handles);
Applied2Lbcb3_Callback(handles.Applied2Lbcb3,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb3.
function Applied2Lbcb3_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb3
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,3,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS4_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS4 as text
%        str2double(get(hObject,'String')) returns contents of ExtS4 as a double
value = get(hObject,'String');
updateSensorNames(hObject,4,value,handles);
Applied2Lbcb4_Callback(handles.Applied2Lbcb4,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb4.
function Applied2Lbcb4_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb4
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,4,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS5_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS5 as text
%        str2double(get(hObject,'String')) returns contents of ExtS5 as a double
value = get(hObject,'String');
updateSensorNames(hObject,5,value,handles);
Applied2Lbcb5_Callback(handles.Applied2Lbcb5,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb5.
function Applied2Lbcb5_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb5
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,5,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS6_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS6 as text
%        str2double(get(hObject,'String')) returns contents of ExtS6 as a double
value = get(hObject,'String');
updateSensorNames(hObject,6,value,handles);
Applied2Lbcb6_Callback(handles.Applied2Lbcb6,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb6.
function Applied2Lbcb6_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb6
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,6,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS7_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS7 as text
%        str2double(get(hObject,'String')) returns contents of ExtS7 as a double
value = get(hObject,'String');
updateSensorNames(hObject,7,value,handles);
Applied2Lbcb7_Callback(handles.Applied2Lbcb7,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb7.
function Applied2Lbcb7_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb7
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,7,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS8_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS8 as text
%        str2double(get(hObject,'String')) returns contents of ExtS8 as a double
value = get(hObject,'String');
updateSensorNames(hObject,8,value,handles);
Applied2Lbcb8_Callback(handles.Applied2Lbcb8,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb8.
function Applied2Lbcb8_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb8
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,8,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS9_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS9 as text
%        str2double(get(hObject,'String')) returns contents of ExtS9 as a double
value = get(hObject,'String');
updateSensorNames(hObject,9,value,handles);
Applied2Lbcb9_Callback(handles.Applied2Lbcb9,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb9.
function Applied2Lbcb9_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb9
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,9,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS10_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS10 as text
%        str2double(get(hObject,'String')) returns contents of ExtS10 as a double
value = get(hObject,'String');
updateSensorNames(hObject,10,value,handles);
Applied2Lbcb10_Callback(handles.Applied2Lbcb10,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb10.
function Applied2Lbcb10_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb10
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,10,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS11_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS11 as text
%        str2double(get(hObject,'String')) returns contents of ExtS11 as a double
value = get(hObject,'String');
updateSensorNames(hObject,11,value,handles);
Applied2Lbcb11_Callback(handles.Applied2Lbcb11,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb11.
function Applied2Lbcb11_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb11
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,11,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS12_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS12 as text
%        str2double(get(hObject,'String')) returns contents of ExtS12 as a double
value = get(hObject,'String');
updateSensorNames(hObject,1,value,handles);
Applied2Lbcb12_Callback(handles.Applied2Lbcb12,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb12.
function Applied2Lbcb12_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb12
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,12,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS13_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS13 as text
%        str2double(get(hObject,'String')) returns contents of ExtS13 as a double
value = get(hObject,'String');
updateSensorNames(hObject,13,value,handles);
Applied2Lbcb13_Callback(handles.Applied2Lbcb13,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb13.
function Applied2Lbcb13_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb13
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,13,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS14_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS14 as text
%        str2double(get(hObject,'String')) returns contents of ExtS14 as a double
value = get(hObject,'String');
updateSensorNames(hObject,14,value,handles);
Applied2Lbcb14_Callback(handles.Applied2Lbcb14,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb14.
function Applied2Lbcb14_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb14
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,14,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS15_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS15 as text
%        str2double(get(hObject,'String')) returns contents of ExtS15 as a double
value = get(hObject,'String');
updateSensorNames(hObject,15,value,handles);
Applied2Lbcb15_Callback(handles.Applied2Lbcb15,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function ExtS15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtS15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Applied2Lbcb15.
function Applied2Lbcb15_Callback(hObject, eventdata, handles)
% hObject    handle to Applied2Lbcb15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Applied2Lbcb15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Applied2Lbcb15
contents = get(hObject,'String');
value = contents{get(hObject,'Value')};
updateApplied2Lbcb(hObject,15,value,handles);


% --- Executes during object creation, after setting all properties.
function Applied2Lbcb15_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to Applied2Lbcb15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function updateApplied2Lbcb(hObject,idx, value, handles)
values = handles.dao.apply2Lbcb;
if isempty(values)
    values = cell(15,1);
end
values{idx} = value;
handles.dao.apply2Lbcb = values;
guidata(hObject, handles);

function updateSensitivities(hObject,idx, value, handles)
values = handles.dao.sensitivities;
if isempty(values)
    values = ones(15,1);
end
values(idx) = value;
handles.dao.sensitivities = values;
guidata(hObject, handles);

function updateSensorNames(hObject,idx,value,handles)
names = handles.dao.sensorNames;
if isempty(names)
    names = cell(15,1);
end
names{idx} = value;
handles.dao.sensorNames = names;
guidata(hObject, handles);

function fillPopups(handles)
values = handles.dao.apply2Lbcb;
if isempty(values)
    values = repmat({[]},15,1);
end
names = handles.dao.sensorNames;
sens = handles.dao.sensitivities;
for m = 1:15
    if isempty(values{m})
        idx = 1;
    else
        handles.appliedTypes.setState(values(m));
        idx = handles.appliedTypes.idx;
    end
    switch m
        case 1
            set(handles.Applied2Lbcb1,'Value',idx);    
            set(handles.ExtS1,'String',names(m));    
            set(handles.sens1,'String',sprintf('%f',sens(m)));
        case 2
            set(handles.Applied2Lbcb2,'Value',idx);    
            set(handles.ExtS2,'String',names(m));    
            set(handles.sens2,'String',sprintf('%f',sens(m)));
        case 3
            set(handles.Applied2Lbcb3,'Value',idx);    
            set(handles.ExtS3,'String',names(m));    
            set(handles.sens3,'String',sprintf('%f',sens(m)));
        case 4
            set(handles.Applied2Lbcb4,'Value',idx);    
            set(handles.ExtS4,'String',names(m));    
            set(handles.sens4,'String',sprintf('%f',sens(m)));
        case 5
            set(handles.Applied2Lbcb5,'Value',idx);    
            set(handles.ExtS5,'String',names(m));    
            set(handles.sens5,'String',sprintf('%f',sens(m)));
        case 6
            set(handles.Applied2Lbcb6,'Value',idx);    
            set(handles.ExtS6,'String',names(m));    
            set(handles.sens6,'String',sprintf('%f',sens(m)));
        case 7
            set(handles.Applied2Lbcb7,'Value',idx);    
            set(handles.ExtS7,'String',names(m));    
            set(handles.sens7,'String',sprintf('%f',sens(m)));
        case 8
            set(handles.Applied2Lbcb8,'Value',idx);    
            set(handles.ExtS8,'String',names(m));    
            set(handles.sens8,'String',sprintf('%f',sens(m)));
        case 9
            set(handles.Applied2Lbcb9,'Value',idx);    
            set(handles.ExtS9,'String',names(m));    
            set(handles.sens9,'String',sprintf('%f',sens(m)));
        case 10
            set(handles.Applied2Lbcb10,'Value',idx);    
            set(handles.ExtS10,'String',names(m));    
            set(handles.sens10,'String',sprintf('%f',sens(m)));
        case 11
            set(handles.Applied2Lbcb11,'Value',idx);    
            set(handles.ExtS11,'String',names(m));    
            set(handles.sens11,'String',sprintf('%f',sens(m)));
        case 12
            set(handles.Applied2Lbcb12,'Value',idx);    
            set(handles.ExtS12,'String',names(m));    
            set(handles.sens12,'String',sprintf('%f',sens(m)));
        case 13
            set(handles.Applied2Lbcb13,'Value',idx);    
            set(handles.ExtS13,'String',names(m));    
            set(handles.sens13,'String',sprintf('%f',sens(m)));
        case 14
            set(handles.Applied2Lbcb14,'Value',idx);    
            set(handles.ExtS14,'String',names(m));    
            set(handles.sens14,'String',sprintf('%f',sens(m)));
        case 15
            set(handles.Applied2Lbcb15,'Value',idx);    
            set(handles.ExtS15,'String',names(m));    
            set(handles.sens15,'String',sprintf('%f',sens(m)));
    end
end



function sens1_Callback(hObject, eventdata, handles)
% hObject    handle to sens1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens1 as text
%        str2double(get(hObject,'String')) returns contents of sens1 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,1,value,handles);


% --- Executes during object creation, after setting all properties.
function sens1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens2_Callback(hObject, eventdata, handles)
% hObject    handle to sens2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens2 as text
%        str2double(get(hObject,'String')) returns contents of sens2 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,2,value,handles);


% --- Executes during object creation, after setting all properties.
function sens2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens3_Callback(hObject, eventdata, handles)
% hObject    handle to sens3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens3 as text
%        str2double(get(hObject,'String')) returns contents of sens3 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,3,value,handles);


% --- Executes during object creation, after setting all properties.
function sens3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens4_Callback(hObject, eventdata, handles)
% hObject    handle to sens4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens4 as text
%        str2double(get(hObject,'String')) returns contents of sens4 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,4,value,handles);


% --- Executes during object creation, after setting all properties.
function sens4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens5_Callback(hObject, eventdata, handles)
% hObject    handle to sens5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens5 as text
%        str2double(get(hObject,'String')) returns contents of sens5 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,5,value,handles);


% --- Executes during object creation, after setting all properties.
function sens5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens6_Callback(hObject, eventdata, handles)
% hObject    handle to sens6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens6 as text
%        str2double(get(hObject,'String')) returns contents of sens6 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,6,value,handles);


% --- Executes during object creation, after setting all properties.
function sens6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens7_Callback(hObject, eventdata, handles)
% hObject    handle to sens7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens7 as text
%        str2double(get(hObject,'String')) returns contents of sens7 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,7,value,handles);


% --- Executes during object creation, after setting all properties.
function sens7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens8_Callback(hObject, eventdata, handles)
% hObject    handle to sens8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens8 as text
%        str2double(get(hObject,'String')) returns contents of sens8 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,8,value,handles);


% --- Executes during object creation, after setting all properties.
function sens8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens9_Callback(hObject, eventdata, handles)
% hObject    handle to sens9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens9 as text
%        str2double(get(hObject,'String')) returns contents of sens9 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,9,value,handles);


% --- Executes during object creation, after setting all properties.
function sens9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens10_Callback(hObject, eventdata, handles)
% hObject    handle to sens10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens10 as text
%        str2double(get(hObject,'String')) returns contents of sens10 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,10,value,handles);


% --- Executes during object creation, after setting all properties.
function sens10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens11_Callback(hObject, eventdata, handles)
% hObject    handle to sens11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens11 as text
%        str2double(get(hObject,'String')) returns contents of sens11 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,11,value,handles);


% --- Executes during object creation, after setting all properties.
function sens11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens12_Callback(hObject, eventdata, handles)
% hObject    handle to sens12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens12 as text
%        str2double(get(hObject,'String')) returns contents of sens12 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,12,value,handles);


% --- Executes during object creation, after setting all properties.
function sens12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens13_Callback(hObject, eventdata, handles)
% hObject    handle to sens13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens13 as text
%        str2double(get(hObject,'String')) returns contents of sens13 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,13,value,handles);


% --- Executes during object creation, after setting all properties.
function sens13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens14_Callback(hObject, eventdata, handles)
% hObject    handle to sens14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens14 as text
%        str2double(get(hObject,'String')) returns contents of sens14 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,14,value,handles);


% --- Executes during object creation, after setting all properties.
function sens14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sens15_Callback(hObject, eventdata, handles)
% hObject    handle to sens15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sens15 as text
%        str2double(get(hObject,'String')) returns contents of sens15 as a double
contents = get(hObject,'String');
value = sscanf(contents,'%f');
updateSensitivities(hObject,15,value,handles);


% --- Executes during object creation, after setting all properties.
function sens15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sens15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseFakeOm.
function UseFakeOm_Callback(hObject, eventdata, handles)
% hObject    handle to UseFakeOm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseFakeOm
on = get(hObject,'Value');
handles.dao.useFakeOm = on;
setToggleButtonColor(hObject,on);

% --- Executes on button press in FakeOmProperties.
function FakeOmProperties_Callback(hObject, eventdata, handles)
% hObject    handle to FakeOmProperties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FakeOmProperties('cfg',handles.cfg);

function setToggleButtonColor(hObject,on)
if on
    set(hObject,'BackgroundColor',[0.925, 0.914, 0.847]);
else
    set(hObject,'BackgroundColor',[0.933,0.933,0.933]);
end
