function varargout = FakeOmProperties(varargin)
% FAKEOMPROPERTIES M-file for FakeOmProperties.fig
%      FAKEOMPROPERTIES, by itself, creates a new FAKEOMPROPERTIES or raises the existing
%      singleton*.
%
%      H = FAKEOMPROPERTIES returns the handle to a new FAKEOMPROPERTIES or the handle to
%      the existing singleton*.
%
%      FAKEOMPROPERTIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAKEOMPROPERTIES.M with the given input arguments.
%
%      FAKEOMPROPERTIES('Property','Value',...) creates a new FAKEOMPROPERTIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FakeOmProperties_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FakeOmProperties_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FakeOmProperties

% Last Modified by GUIDE v2.5 06-Jul-2009 13:04:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FakeOmProperties_OpeningFcn, ...
                   'gui_OutputFcn',  @FakeOmProperties_OutputFcn, ...
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


% --- Executes just before FakeOmProperties is made visible.
function FakeOmProperties_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FakeOmProperties (see VARARGIN)

% Choose default command line output for FakeOmProperties
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

handles.actions = FakeOmActions(handles);
handles.actions.initialize(cfg);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FakeOmProperties wait for user response (see UIRESUME)
% uiwait(handles.FakeOmProperties);


% --- Outputs from this function are returned to the command line.
function varargout = FakeOmProperties_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Ok.
function Ok_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.FakeOmProperties);

function DxS1_Callback(hObject, eventdata, handles)
% hObject    handle to DxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxS1 as text
%        str2double(get(hObject,'String')) returns contents of DxS1 as a double
handles.actions.setScale(1,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function DxS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxO1_Callback(hObject, eventdata, handles)
% hObject    handle to DxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxO1 as text
%        str2double(get(hObject,'String')) returns contents of DxO1 as a double
handles.actions.setOffset(1,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function DxO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DxD1.
function DxD1_Callback(hObject, eventdata, handles)
% hObject    handle to DxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DxD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DxD1
handles.actions.setDerived(1,get(hObject,'Value'),0);

% --- Executes during object creation, after setting all properties.
function DxD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyS1_Callback(hObject, eventdata, handles)
% hObject    handle to DyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyS1 as text
%        str2double(get(hObject,'String')) returns contents of DyS1 as a double
handles.actions.setScale(2,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function DyS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyO1_Callback(hObject, eventdata, handles)
% hObject    handle to DyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyO1 as text
%        str2double(get(hObject,'String')) returns contents of DyO1 as a double
handles.actions.setOffset(2,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function DyO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DyD1.
function DyD1_Callback(hObject, eventdata, handles)
% hObject    handle to DyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DyD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DyD1
handles.actions.setDerived(2,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function DyD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzS1_Callback(hObject, eventdata, handles)
% hObject    handle to DzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzS1 as text
%        str2double(get(hObject,'String')) returns contents of DzS1 as a double
handles.actions.setScale(3,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function DzS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzO1_Callback(hObject, eventdata, handles)
% hObject    handle to DzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzO1 as text
%        str2double(get(hObject,'String')) returns contents of DzO1 as a double
handles.actions.setOffset(3,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function DzO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DzD1.
function DzD1_Callback(hObject, eventdata, handles)
% hObject    handle to DzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DzD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DzD1
handles.actions.setDerived(3,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function DzD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxS1_Callback(hObject, eventdata, handles)
% hObject    handle to RxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxS1 as text
%        str2double(get(hObject,'String')) returns contents of RxS1 as a double
handles.actions.setScale(4,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function RxS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxO1_Callback(hObject, eventdata, handles)
% hObject    handle to RxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxO1 as text
%        str2double(get(hObject,'String')) returns contents of RxO1 as a double
handles.actions.setOffset(4,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function RxO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RxD1.
function RxD1_Callback(hObject, eventdata, handles)
% hObject    handle to RxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RxD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RxD1
handles.actions.setDerived(4,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function RxD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyS1_Callback(hObject, eventdata, handles)
% hObject    handle to RyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyS1 as text
%        str2double(get(hObject,'String')) returns contents of RyS1 as a double
handles.actions.setScale(5,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function RyS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyO1_Callback(hObject, eventdata, handles)
% hObject    handle to RyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyO1 as text
%        str2double(get(hObject,'String')) returns contents of RyO1 as a double
handles.actions.setOffset(5,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function RyO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RyD1.
function RyD1_Callback(hObject, eventdata, handles)
% hObject    handle to RyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RyD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RyD1
handles.actions.setDerived(5,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function RyD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzS1_Callback(hObject, eventdata, handles)
% hObject    handle to RzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzS1 as text
%        str2double(get(hObject,'String')) returns contents of RzS1 as a double
handles.actions.setScale(6,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function RzS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzO1_Callback(hObject, eventdata, handles)
% hObject    handle to RzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzO1 as text
%        str2double(get(hObject,'String')) returns contents of RzO1 as a double
handles.actions.setOffset(6,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function RzO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RzD1.
function RzD1_Callback(hObject, eventdata, handles)
% hObject    handle to RzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RzD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RzD1
handles.actions.setDerived(6,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function RzD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxS1_Callback(hObject, eventdata, handles)
% hObject    handle to FxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxS1 as text
%        str2double(get(hObject,'String')) returns contents of FxS1 as a double
handles.actions.setScale(7,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function FxS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxO1_Callback(hObject, eventdata, handles)
% hObject    handle to FxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxO1 as text
%        str2double(get(hObject,'String')) returns contents of FxO1 as a double
handles.actions.setOffset(7,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function FxO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FxD1.
function FxD1_Callback(hObject, eventdata, handles)
% hObject    handle to FxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FxD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FxD1
handles.actions.setDerived(7,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function FxD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyS1_Callback(hObject, eventdata, handles)
% hObject    handle to FyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyS1 as text
%        str2double(get(hObject,'String')) returns contents of FyS1 as a double
handles.actions.setScale(8,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function FyS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyO1_Callback(hObject, eventdata, handles)
% hObject    handle to FyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyO1 as text
%        str2double(get(hObject,'String')) returns contents of FyO1 as a double
handles.actions.setOffset(8,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function FyO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FyD1.
function FyD1_Callback(hObject, eventdata, handles)
% hObject    handle to FyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FyD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FyD1
handles.actions.setDerived(8,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function FyD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzS1_Callback(hObject, eventdata, handles)
% hObject    handle to FzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzS1 as text
%        str2double(get(hObject,'String')) returns contents of FzS1 as a double
handles.actions.setScale(9,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function FzS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzO1_Callback(hObject, eventdata, handles)
% hObject    handle to FzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzO1 as text
%        str2double(get(hObject,'String')) returns contents of FzO1 as a double
handles.actions.setOffset(9,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function FzO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FzD1.
function FzD1_Callback(hObject, eventdata, handles)
% hObject    handle to FzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FzD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FzD1
handles.actions.setDerived(9,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function FzD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxS1_Callback(hObject, eventdata, handles)
% hObject    handle to MxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxS1 as text
%        str2double(get(hObject,'String')) returns contents of MxS1 as a double
handles.actions.setScale(10,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function MxS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxO1_Callback(hObject, eventdata, handles)
% hObject    handle to MxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxO1 as text
%        str2double(get(hObject,'String')) returns contents of MxO1 as a double
handles.actions.setOffset(10,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function MxO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MxD1.
function MxD1_Callback(hObject, eventdata, handles)
% hObject    handle to MxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MxD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MxD1
handles.actions.setDerived(10,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function MxD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyS1_Callback(hObject, eventdata, handles)
% hObject    handle to MyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyS1 as text
%        str2double(get(hObject,'String')) returns contents of MyS1 as a double
handles.actions.setScale(11,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function MyS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyO1_Callback(hObject, eventdata, handles)
% hObject    handle to MyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyO1 as text
%        str2double(get(hObject,'String')) returns contents of MyO1 as a double
handles.actions.setOffset(11,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function MyO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MyD1.
function MyD1_Callback(hObject, eventdata, handles)
% hObject    handle to MyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MyD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MyD1
handles.actions.setDerived(11,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function MyD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzS1_Callback(hObject, eventdata, handles)
% hObject    handle to MzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzS1 as text
%        str2double(get(hObject,'String')) returns contents of MzS1 as a double
handles.actions.setScale(12,get(hObject,'String'),0);

% --- Executes during object creation, after setting all properties.
function MzS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzO1_Callback(hObject, eventdata, handles)
% hObject    handle to MzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzO1 as text
%        str2double(get(hObject,'String')) returns contents of MzO1 as a double
handles.actions.setOffset(12,get(hObject,'String'),0);


% --- Executes during object creation, after setting all properties.
function MzO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MzD1.
function MzD1_Callback(hObject, eventdata, handles)
% hObject    handle to MzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MzD1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MzD1
handles.actions.setDerived(12,get(hObject,'Value'),0);


% --- Executes during object creation, after setting all properties.
function MzD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxS2_Callback(hObject, eventdata, handles)
% hObject    handle to DxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxS2 as text
%        str2double(get(hObject,'String')) returns contents of DxS2 as a double
handles.actions.setScale(1,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function DxS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxO2_Callback(hObject, eventdata, handles)
% hObject    handle to DxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxO2 as text
%        str2double(get(hObject,'String')) returns contents of DxO2 as a double
handles.actions.setOffset(1,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function DxO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DxD2.
function DxD2_Callback(hObject, eventdata, handles)
% hObject    handle to DxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DxD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DxD2
handles.actions.setDerived(1,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function DxD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyS2_Callback(hObject, eventdata, handles)
% hObject    handle to DyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyS2 as text
%        str2double(get(hObject,'String')) returns contents of DyS2 as a double
handles.actions.setScale(2,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function DyS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyO2_Callback(hObject, eventdata, handles)
% hObject    handle to DyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyO2 as text
%        str2double(get(hObject,'String')) returns contents of DyO2 as a double
handles.actions.setOffset(2,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function DyO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DyD2.
function DyD2_Callback(hObject, eventdata, handles)
% hObject    handle to DyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DyD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DyD2
handles.actions.setDerived(2,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function DyD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzS2_Callback(hObject, eventdata, handles)
% hObject    handle to DzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzS2 as text
%        str2double(get(hObject,'String')) returns contents of DzS2 as a double
handles.actions.setScale(3,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function DzS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzO2_Callback(hObject, eventdata, handles)
% hObject    handle to DzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzO2 as text
%        str2double(get(hObject,'String')) returns contents of DzO2 as a double
handles.actions.setOffset(3,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function DzO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DzD2.
function DzD2_Callback(hObject, eventdata, handles)
% hObject    handle to DzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DzD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DzD2
handles.actions.setDerived(3,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function DzD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxS2_Callback(hObject, eventdata, handles)
% hObject    handle to RxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxS2 as text
%        str2double(get(hObject,'String')) returns contents of RxS2 as a double
handles.actions.setScale(4,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RxS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxO2_Callback(hObject, eventdata, handles)
% hObject    handle to RxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxO2 as text
%        str2double(get(hObject,'String')) returns contents of RxO2 as a double
handles.actions.setOffset(4,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RxO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RxD2.
function RxD2_Callback(hObject, eventdata, handles)
% hObject    handle to RxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RxD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RxD2
handles.actions.setDerived(4,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function RxD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyS2_Callback(hObject, eventdata, handles)
% hObject    handle to RyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyS2 as text
%        str2double(get(hObject,'String')) returns contents of RyS2 as a double
handles.actions.setScale(5,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RyS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyO2_Callback(hObject, eventdata, handles)
% hObject    handle to RyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyO2 as text
%        str2double(get(hObject,'String')) returns contents of RyO2 as a double
handles.actions.setOffset(5,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RyO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RyD2.
function RyD2_Callback(hObject, eventdata, handles)
% hObject    handle to RyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RyD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RyD2
handles.actions.setDerived(5,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function RyD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzS2_Callback(hObject, eventdata, handles)
% hObject    handle to RzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzS2 as text
%        str2double(get(hObject,'String')) returns contents of RzS2 as a double
handles.actions.setScale(6,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RzS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzO2_Callback(hObject, eventdata, handles)
% hObject    handle to RzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzO2 as text
%        str2double(get(hObject,'String')) returns contents of RzO2 as a double
handles.actions.setOffset(6,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function RzO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RzD2.
function RzD2_Callback(hObject, eventdata, handles)
% hObject    handle to RzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RzD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RzD2
handles.actions.setDerived(6,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function RzD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxS2_Callback(hObject, eventdata, handles)
% hObject    handle to FxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxS2 as text
%        str2double(get(hObject,'String')) returns contents of FxS2 as a double
handles.actions.setScale(7,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function FxS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxO2_Callback(hObject, eventdata, handles)
% hObject    handle to FxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxO2 as text
%        str2double(get(hObject,'String')) returns contents of FxO2 as a double
handles.actions.setOffset(7,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function FxO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FxD2.
function FxD2_Callback(hObject, eventdata, handles)
% hObject    handle to FxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FxD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FxD2
handles.actions.setDerived(7,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function FxD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyS2_Callback(hObject, eventdata, handles)
% hObject    handle to FyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyS2 as text
%        str2double(get(hObject,'String')) returns contents of FyS2 as a double
handles.actions.setScale(8,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function FyS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyO2_Callback(hObject, eventdata, handles)
% hObject    handle to FyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyO2 as text
%        str2double(get(hObject,'String')) returns contents of FyO2 as a double
handles.actions.setOffset(8,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function FyO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FyD2.
function FyD2_Callback(hObject, eventdata, handles)
% hObject    handle to FyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FyD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FyD2
handles.actions.setDerived(8,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function FyD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzS2_Callback(hObject, eventdata, handles)
% hObject    handle to FzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzS2 as text
%        str2double(get(hObject,'String')) returns contents of FzS2 as a double
handles.actions.setScale(9,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function FzS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzO2_Callback(hObject, eventdata, handles)
% hObject    handle to FzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzO2 as text
%        str2double(get(hObject,'String')) returns contents of FzO2 as a double
handles.actions.setOffset(9,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function FzO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FzD2.
function FzD2_Callback(hObject, eventdata, handles)
% hObject    handle to FzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns FzD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FzD2
handles.actions.setDerived(9,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function FzD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxS2_Callback(hObject, eventdata, handles)
% hObject    handle to MxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxS2 as text
%        str2double(get(hObject,'String')) returns contents of MxS2 as a double
handles.actions.setScale(10,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function MxS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxO2_Callback(hObject, eventdata, handles)
% hObject    handle to MxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxO2 as text
%        str2double(get(hObject,'String')) returns contents of MxO2 as a double
handles.actions.setOffset(10,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function MxO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MxD2.
function MxD2_Callback(hObject, eventdata, handles)
% hObject    handle to MxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MxD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MxD2
handles.actions.setDerived(10,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function MxD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyS2_Callback(hObject, eventdata, handles)
% hObject    handle to MyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyS2 as text
%        str2double(get(hObject,'String')) returns contents of MyS2 as a double
handles.actions.setScale(11,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function MyS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyO2_Callback(hObject, eventdata, handles)
% hObject    handle to MyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyO2 as text
%        str2double(get(hObject,'String')) returns contents of MyO2 as a double
handles.actions.setOffset(11,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function MyO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MyD2.
function MyD2_Callback(hObject, eventdata, handles)
% hObject    handle to MyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MyD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MyD2
handles.actions.setDerived(11,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function MyD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzS2_Callback(hObject, eventdata, handles)
% hObject    handle to MzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzS2 as text
%        str2double(get(hObject,'String')) returns contents of MzS2 as a double
handles.actions.setScale(12,get(hObject,'String'),1);

% --- Executes during object creation, after setting all properties.
function MzS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzO2_Callback(hObject, eventdata, handles)
% hObject    handle to MzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzO2 as text
%        str2double(get(hObject,'String')) returns contents of MzO2 as a double
handles.actions.setOffset(12,get(hObject,'String'),1);


% --- Executes during object creation, after setting all properties.
function MzO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MzD2.
function MzD2_Callback(hObject, eventdata, handles)
% hObject    handle to MzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MzD2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MzD2
handles.actions.setDerived(12,get(hObject,'Value'),1);


% --- Executes during object creation, after setting all properties.
function MzD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExtS1_Callback(hObject, eventdata, handles)
% hObject    handle to ExtS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtS1 as text
%        str2double(get(hObject,'String')) returns contents of ExtS1 as a double


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



function ExtO1_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO1 as text
%        str2double(get(hObject,'String')) returns contents of ExtO1 as a double


% --- Executes during object creation, after setting all properties.
function ExtO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA1.
function ExtA1_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA1


% --- Executes during object creation, after setting all properties.
function ExtA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA1 (see GCBO)
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



function ExtO2_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO2 as text
%        str2double(get(hObject,'String')) returns contents of ExtO2 as a double


% --- Executes during object creation, after setting all properties.
function ExtO2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA2.
function ExtA2_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA2


% --- Executes during object creation, after setting all properties.
function ExtA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA2 (see GCBO)
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



function ExtO3_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO3 as text
%        str2double(get(hObject,'String')) returns contents of ExtO3 as a double


% --- Executes during object creation, after setting all properties.
function ExtO3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA3.
function ExtA3_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA3


% --- Executes during object creation, after setting all properties.
function ExtA3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA3 (see GCBO)
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



function ExtO4_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO4 as text
%        str2double(get(hObject,'String')) returns contents of ExtO4 as a double


% --- Executes during object creation, after setting all properties.
function ExtO4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA4.
function ExtA4_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA4


% --- Executes during object creation, after setting all properties.
function ExtA4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA4 (see GCBO)
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



function ExtO5_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO5 as text
%        str2double(get(hObject,'String')) returns contents of ExtO5 as a double


% --- Executes during object creation, after setting all properties.
function ExtO5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA5.
function ExtA5_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA5


% --- Executes during object creation, after setting all properties.
function ExtA5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA5 (see GCBO)
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



function ExtO6_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO6 as text
%        str2double(get(hObject,'String')) returns contents of ExtO6 as a double


% --- Executes during object creation, after setting all properties.
function ExtO6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA6.
function ExtA6_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA6


% --- Executes during object creation, after setting all properties.
function ExtA6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA6 (see GCBO)
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



function ExtO7_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO7 as text
%        str2double(get(hObject,'String')) returns contents of ExtO7 as a double


% --- Executes during object creation, after setting all properties.
function ExtO7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA7.
function ExtA7_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA7


% --- Executes during object creation, after setting all properties.
function ExtA7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA7 (see GCBO)
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



function ExtO8_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO8 as text
%        str2double(get(hObject,'String')) returns contents of ExtO8 as a double


% --- Executes during object creation, after setting all properties.
function ExtO8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA8.
function ExtA8_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA8


% --- Executes during object creation, after setting all properties.
function ExtA8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA8 (see GCBO)
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



function ExtO9_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO9 as text
%        str2double(get(hObject,'String')) returns contents of ExtO9 as a double


% --- Executes during object creation, after setting all properties.
function ExtO9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA9.
function ExtA9_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA9


% --- Executes during object creation, after setting all properties.
function ExtA9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA9 (see GCBO)
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



function ExtO10_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO10 as text
%        str2double(get(hObject,'String')) returns contents of ExtO10 as a double


% --- Executes during object creation, after setting all properties.
function ExtO10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA10.
function ExtA10_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA10


% --- Executes during object creation, after setting all properties.
function ExtA10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA10 (see GCBO)
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



function ExtO11_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO11 as text
%        str2double(get(hObject,'String')) returns contents of ExtO11 as a double


% --- Executes during object creation, after setting all properties.
function ExtO11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA11.
function ExtA11_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA11


% --- Executes during object creation, after setting all properties.
function ExtA11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA11 (see GCBO)
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



function ExtO12_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO12 as text
%        str2double(get(hObject,'String')) returns contents of ExtO12 as a double


% --- Executes during object creation, after setting all properties.
function ExtO12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA12.
function ExtA12_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA12


% --- Executes during object creation, after setting all properties.
function ExtA12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA12 (see GCBO)
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



function ExtO13_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO13 as text
%        str2double(get(hObject,'String')) returns contents of ExtO13 as a double


% --- Executes during object creation, after setting all properties.
function ExtO13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA13.
function ExtA13_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA13


% --- Executes during object creation, after setting all properties.
function ExtA13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA13 (see GCBO)
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



function ExtO14_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO14 as text
%        str2double(get(hObject,'String')) returns contents of ExtO14 as a double


% --- Executes during object creation, after setting all properties.
function ExtO14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA14.
function ExtA14_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA14


% --- Executes during object creation, after setting all properties.
function ExtA14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA14 (see GCBO)
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



function ExtO15_Callback(hObject, eventdata, handles)
% hObject    handle to ExtO15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExtO15 as text
%        str2double(get(hObject,'String')) returns contents of ExtO15 as a double


% --- Executes during object creation, after setting all properties.
function ExtO15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtO15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExtA15.
function ExtA15_Callback(hObject, eventdata, handles)
% hObject    handle to ExtA15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ExtA15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExtA15


% --- Executes during object creation, after setting all properties.
function ExtA15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExtA15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ConvergenceSteps_Callback(hObject, eventdata, handles)
% hObject    handle to ConvergenceSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConvergenceSteps as text
%        str2double(get(hObject,'String')) returns contents of ConvergenceSteps as a double


% --- Executes during object creation, after setting all properties.
function ConvergenceSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConvergenceSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ConvergenceIncrement_Callback(hObject, eventdata, handles)
% hObject    handle to ConvergenceIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConvergenceIncrement as text
%        str2double(get(hObject,'String')) returns contents of ConvergenceIncrement as a double


% --- Executes during object creation, after setting all properties.
function ConvergenceIncrement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConvergenceIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
