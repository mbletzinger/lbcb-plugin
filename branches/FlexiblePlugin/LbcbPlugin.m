function varargout = LbcbPlugin(varargin)
% LBCBPLUGIN M-file for LbcbPlugin.fig
%      LBCBPLUGIN, by itself, creates a new LBCBPLUGIN or raises the existing
%      singleton*.
%
%      H = LBCBPLUGIN returns the handle to a new LBCBPLUGIN or the handle to
%      the existing singleton*.
%
%      LBCBPLUGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LBCBPLUGIN.M with the given input arguments.
%
%      LBCBPLUGIN('Property','Value',...) creates a new LBCBPLUGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LbcbPlugin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LbcbPlugin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LbcbPlugin

% Last Modified by GUIDE v2.5 22-Jun-2009 18:05:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LbcbPlugin_OpeningFcn, ...
                   'gui_OutputFcn',  @LbcbPlugin_OutputFcn, ...
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


% --- Executes just before LbcbPlugin is made visible.
function LbcbPlugin_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LbcbPlugin (see VARARGIN)

% Choose default command line output for LbcbPlugin
handles.output = hObject;
cfg = {};
infile = {};
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'cfg'
                cfg = varargin{index+1};
            case 'infile'
                infile = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end

handles.actions = LbcbPluginActions(handles,cfg);
handles.actions.initialize();
if isempty(infile) == 0
    handles.actions.setInputFile(infile);
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LbcbPlugin wait for user response (see UIRESUME)
 uiwait(handles.LbcbPlugin);


% --- Outputs from this function are returned to the command line.
function varargout = LbcbPlugin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;


% --- Executes on button press in RunHold.
function RunHold_Callback(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
% hObject    handle to RunHold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.actions.running = get(hObject,'Value');
% handles.actions.nxtTgt.start();
% handles.actions.currentAction.setState('NEXT TARGET');
% LbcbPluginActions.execute([],[],handles.actions);
handles.actions.setRunButton(get(hObject,'Value'));

% --- Executes on selection change in Messages.
function Messages_Callback(hObject, eventdata, handles)
% hObject    handle to Messages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Messages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Messages


% --- Executes during object creation, after setting all properties.
function Messages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Messages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Connect2Om.
function Connect2Om_Callback(hObject, eventdata, handles)
% hObject    handle to Connect2Om (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ManualInput.
function ManualInput_Callback(hObject, eventdata, handles)
% hObject    handle to ManualInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StartTriggering.
function StartTriggering_Callback(hObject, eventdata, handles)
% hObject    handle to StartTriggering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function DxL1_Callback(hObject, eventdata, handles)
% hObject    handle to DxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxL1 as text
%        str2double(get(hObject,'String')) returns contents of DxL1 as a double
handles.actions.setCommandLimit(1,1,1,get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function DxL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxU1_Callback(hObject, eventdata, handles)
% hObject    handle to DxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxU1 as text
%        str2double(get(hObject,'String')) returns contents of DxU1 as a double
handles.actions.setCommandLimit(1,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DxU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxCV1 as text
%        str2double(get(hObject,'String')) returns contents of DxCV1 as a double


% --- Executes during object creation, after setting all properties.
function DxCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyL1_Callback(hObject, eventdata, handles)
% hObject    handle to DyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyL1 as text
%        str2double(get(hObject,'String')) returns contents of DyL1 as a double
handles.actions.setCommandLimit(2,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DyL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyU1_Callback(hObject, eventdata, handles)
% hObject    handle to DyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyU1 as text
%        str2double(get(hObject,'String')) returns contents of DyU1 as a double
handles.actions.setCommandLimit(2,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DyU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyCV1 as text
%        str2double(get(hObject,'String')) returns contents of DyCV1 as a double


% --- Executes during object creation, after setting all properties.
function DyCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzL1_Callback(hObject, eventdata, handles)
% hObject    handle to DzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzL1 as text
%        str2double(get(hObject,'String')) returns contents of DzL1 as a double
handles.actions.setCommandLimit(3,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DzL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzU1_Callback(hObject, eventdata, handles)
% hObject    handle to DzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzU1 as text
%        str2double(get(hObject,'String')) returns contents of DzU1 as a double
handles.actions.setCommandLimit(3,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DzU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzCV1 as text
%        str2double(get(hObject,'String')) returns contents of DzCV1 as a double


% --- Executes during object creation, after setting all properties.
function DzCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxL1_Callback(hObject, eventdata, handles)
% hObject    handle to RxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxL1 as text
%        str2double(get(hObject,'String')) returns contents of RxL1 as a double
handles.actions.setCommandLimit(4,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RxL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxU1_Callback(hObject, eventdata, handles)
% hObject    handle to RxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxU1 as text
%        str2double(get(hObject,'String')) returns contents of RxU1 as a double
handles.actions.setCommandLimit(4,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RxU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxCV1 as text
%        str2double(get(hObject,'String')) returns contents of RxCV1 as a double


% --- Executes during object creation, after setting all properties.
function RxCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyL1_Callback(hObject, eventdata, handles)
% hObject    handle to RyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyL1 as text
%        str2double(get(hObject,'String')) returns contents of RyL1 as a double
handles.actions.setCommandLimit(5,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RyL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyU1_Callback(hObject, eventdata, handles)
% hObject    handle to RyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyU1 as text
%        str2double(get(hObject,'String')) returns contents of RyU1 as a double
handles.actions.setCommandLimit(5,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RyU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyCV1 as text
%        str2double(get(hObject,'String')) returns contents of RyCV1 as a double


% --- Executes during object creation, after setting all properties.
function RyCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzL1_Callback(hObject, eventdata, handles)
% hObject    handle to RzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCommandLimit(6,1,1,get(hObject,'String'));

% Hints: get(hObject,'String') returns contents of RzL1 as text
%        str2double(get(hObject,'String')) returns contents of RzL1 as a double


% --- Executes during object creation, after setting all properties.
function RzL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzU1_Callback(hObject, eventdata, handles)
% hObject    handle to RzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzU1 as text
%        str2double(get(hObject,'String')) returns contents of RzU1 as a double
handles.actions.setCommandLimit(6,1,0,get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function RzU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzCV1 as text
%        str2double(get(hObject,'String')) returns contents of RzCV1 as a double


% --- Executes during object creation, after setting all properties.
function RzCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxL2_Callback(hObject, eventdata, handles)
% hObject    handle to DxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxL2 as text
%        str2double(get(hObject,'String')) returns contents of DxL2 as a double
handles.actions.setCommandLimit(1,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DxL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxU2_Callback(hObject, eventdata, handles)
% hObject    handle to DxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxU2 as text
%        str2double(get(hObject,'String')) returns contents of DxU2 as a double
handles.actions.setCommandLimit(1,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DxU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxCV2 as text
%        str2double(get(hObject,'String')) returns contents of DxCV2 as a double


% --- Executes during object creation, after setting all properties.
function DxCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyL2_Callback(hObject, eventdata, handles)
% hObject    handle to DyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyL2 as text
%        str2double(get(hObject,'String')) returns contents of DyL2 as a double
handles.actions.setCommandLimit(2,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DyL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyU2_Callback(hObject, eventdata, handles)
% hObject    handle to DyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyU2 as text
%        str2double(get(hObject,'String')) returns contents of DyU2 as a double
handles.actions.setCommandLimit(2,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DyU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyCV2 as text
%        str2double(get(hObject,'String')) returns contents of DyCV2 as a double


% --- Executes during object creation, after setting all properties.
function DyCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzL2_Callback(hObject, eventdata, handles)
% hObject    handle to DzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzL2 as text
%        str2double(get(hObject,'String')) returns contents of DzL2 as a double
handles.actions.setCommandLimit(3,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DzL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzU2_Callback(hObject, eventdata, handles)
% hObject    handle to DzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzU2 as text
%        str2double(get(hObject,'String')) returns contents of DzU2 as a double
handles.actions.setCommandLimit(3,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function DzU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzCV2 as text
%        str2double(get(hObject,'String')) returns contents of DzCV2 as a double


% --- Executes during object creation, after setting all properties.
function DzCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxL2_Callback(hObject, eventdata, handles)
% hObject    handle to RxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxL2 as text
%        str2double(get(hObject,'String')) returns contents of RxL2 as a double
handles.actions.setCommandLimit(4,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RxL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxU2_Callback(hObject, eventdata, handles)
% hObject    handle to RxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxU2 as text
%        str2double(get(hObject,'String')) returns contents of RxU2 as a double
handles.actions.setCommandLimit(4,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RxU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxCV2 as text
%        str2double(get(hObject,'String')) returns contents of RxCV2 as a double


% --- Executes during object creation, after setting all properties.
function RxCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyL2_Callback(hObject, eventdata, handles)
% hObject    handle to RyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyL2 as text
%        str2double(get(hObject,'String')) returns contents of RyL2 as a double
handles.actions.setCommandLimit(5,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RyL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyU2_Callback(hObject, eventdata, handles)
% hObject    handle to RyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyU2 as text
%        str2double(get(hObject,'String')) returns contents of RyU2 as a double
handles.actions.setCommandLimit(5,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RyU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyCV2 as text
%        str2double(get(hObject,'String')) returns contents of RyCV2 as a double


% --- Executes during object creation, after setting all properties.
function RyCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzL2_Callback(hObject, eventdata, handles)
% hObject    handle to RzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzL2 as text
%        str2double(get(hObject,'String')) returns contents of RzL2 as a double
handles.actions.setCommandLimit(6,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RzL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzU2_Callback(hObject, eventdata, handles)
% hObject    handle to RzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzU2 as text
%        str2double(get(hObject,'String')) returns contents of RzU2 as a double
handles.actions.setCommandLimit(6,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RzU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzCV2 as text
%        str2double(get(hObject,'String')) returns contents of RzCV2 as a double


% --- Executes during object creation, after setting all properties.
function RzCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxL1_Callback(hObject, eventdata, handles)
% hObject    handle to FxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxL1 as text
%        str2double(get(hObject,'String')) returns contents of FxL1 as a double
handles.actions.setCommandLimit(7,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FxL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxU1_Callback(hObject, eventdata, handles)
% hObject    handle to FxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxU1 as text
%        str2double(get(hObject,'String')) returns contents of FxU1 as a double
handles.actions.setCommandLimit(7,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FxU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxCV1 as text
%        str2double(get(hObject,'String')) returns contents of FxCV1 as a double


% --- Executes during object creation, after setting all properties.
function FxCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyL1_Callback(hObject, eventdata, handles)
% hObject    handle to FyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyL1 as text
%        str2double(get(hObject,'String')) returns contents of FyL1 as a double
handles.actions.setCommandLimit(8,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FyL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FyU1_Callback(hObject, eventdata, handles)
% hObject    handle to FyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyU1 as text
%        str2double(get(hObject,'String')) returns contents of FyU1 as a double
handles.actions.setCommandLimit(8,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FyU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyCV1 as text
%        str2double(get(hObject,'String')) returns contents of FyCV1 as a double


% --- Executes during object creation, after setting all properties.
function FyCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzL1_Callback(hObject, eventdata, handles)
% hObject    handle to FzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzL1 as text
%        str2double(get(hObject,'String')) returns contents of FzL1 as a double
handles.actions.setCommandLimit(9,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FzL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzU1_Callback(hObject, eventdata, handles)
% hObject    handle to FzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzU1 as text
%        str2double(get(hObject,'String')) returns contents of FzU1 as a double
handles.actions.setCommandLimit(9,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FzU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzCV1 as text
%        str2double(get(hObject,'String')) returns contents of FzCV1 as a double


% --- Executes during object creation, after setting all properties.
function FzCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxL1_Callback(hObject, eventdata, handles)
% hObject    handle to MxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxL1 as text
%        str2double(get(hObject,'String')) returns contents of MxL1 as a double
handles.actions.setCommandLimit(10,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MxL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxU1_Callback(hObject, eventdata, handles)
% hObject    handle to MxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxU1 as text
%        str2double(get(hObject,'String')) returns contents of MxU1 as a double
handles.actions.setCommandLimit(10,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MxU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxCV1 as text
%        str2double(get(hObject,'String')) returns contents of MxCV1 as a double


% --- Executes during object creation, after setting all properties.
function MxCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyL1_Callback(hObject, eventdata, handles)
% hObject    handle to MyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyL1 as text
%        str2double(get(hObject,'String')) returns contents of MyL1 as a double
handles.actions.setCommandLimit(11,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MyL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyU1_Callback(hObject, eventdata, handles)
% hObject    handle to MyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyU1 as text
%        str2double(get(hObject,'String')) returns contents of MyU1 as a double
handles.actions.setCommandLimit(11,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MyU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyCV1 as text
%        str2double(get(hObject,'String')) returns contents of MyCV1 as a double


% --- Executes during object creation, after setting all properties.
function MyCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzL1_Callback(hObject, eventdata, handles)
% hObject    handle to MzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzL1 as text
%        str2double(get(hObject,'String')) returns contents of MzL1 as a double
handles.actions.setCommandLimit(12,1,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MzL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzU1_Callback(hObject, eventdata, handles)
% hObject    handle to MzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzU1 as text
%        str2double(get(hObject,'String')) returns contents of MzU1 as a double
handles.actions.setCommandLimit(12,1,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MzU1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzU1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzCV1 as text
%        str2double(get(hObject,'String')) returns contents of MzCV1 as a double


% --- Executes during object creation, after setting all properties.
function MzCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxL2_Callback(hObject, eventdata, handles)
% hObject    handle to FxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxL2 as text
%        str2double(get(hObject,'String')) returns contents of FxL2 as a double
handles.actions.setCommandLimit(7,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FxL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxU2_Callback(hObject, eventdata, handles)
% hObject    handle to FxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxU2 as text
%        str2double(get(hObject,'String')) returns contents of FxU2 as a double
handles.actions.setCommandLimit(7,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FxU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxCV2 as text
%        str2double(get(hObject,'String')) returns contents of FxCV2 as a double


% --- Executes during object creation, after setting all properties.
function FxCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyL2_Callback(hObject, eventdata, handles)
% hObject    handle to FyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyL2 as text
%        str2double(get(hObject,'String')) returns contents of FyL2 as a double
handles.actions.setCommandLimit(8,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FyL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyU2_Callback(hObject, eventdata, handles)
% hObject    handle to FyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyU2 as text
%        str2double(get(hObject,'String')) returns contents of FyU2 as a double
handles.actions.setCommandLimit(8,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FyU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyCV2 as text
%        str2double(get(hObject,'String')) returns contents of FyCV2 as a double


% --- Executes during object creation, after setting all properties.
function FyCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzL2_Callback(hObject, eventdata, handles)
% hObject    handle to FzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzL2 as text
%        str2double(get(hObject,'String')) returns contents of FzL2 as a double
handles.actions.setCommandLimit(9,2,1,get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function FzL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzU2_Callback(hObject, eventdata, handles)
% hObject    handle to FzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzU2 as text
%        str2double(get(hObject,'String')) returns contents of FzU2 as a double
handles.actions.setCommandLimit(9,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function FzU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzCV2 as text
%        str2double(get(hObject,'String')) returns contents of FzCV2 as a double


% --- Executes during object creation, after setting all properties.
function FzCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxL2_Callback(hObject, eventdata, handles)
% hObject    handle to MxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setCommandLimit(10,2,1,get(hObject,'String'));

% Hints: get(hObject,'String') returns contents of MxL2 as text
%        str2double(get(hObject,'String')) returns contents of MxL2 as a double


% --- Executes during object creation, after setting all properties.
function MxL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxU2_Callback(hObject, eventdata, handles)
% hObject    handle to MxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxU2 as text
%        str2double(get(hObject,'String')) returns contents of MxU2 as a double
handles.actions.setCommandLimit(10,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MxU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxCV2 as text
%        str2double(get(hObject,'String')) returns contents of MxCV2 as a double


% --- Executes during object creation, after setting all properties.
function MxCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyL2_Callback(hObject, eventdata, handles)
% hObject    handle to MyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyL2 as text
%        str2double(get(hObject,'String')) returns contents of MyL2 as a double
handles.actions.setCommandLimit(11,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MyL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyU2_Callback(hObject, eventdata, handles)
% hObject    handle to MyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyU2 as text
%        str2double(get(hObject,'String')) returns contents of MyU2 as a double
handles.actions.setCommandLimit(1,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MyU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyCV2 as text
%        str2double(get(hObject,'String')) returns contents of MyCV2 as a double


% --- Executes during object creation, after setting all properties.
function MyCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzL2_Callback(hObject, eventdata, handles)
% hObject    handle to MzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzL2 as text
%        str2double(get(hObject,'String')) returns contents of MzL2 as a double
handles.actions.setCommandLimit(12,2,1,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MzL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzU2_Callback(hObject, eventdata, handles)
% hObject    handle to MzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzU2 as text
%        str2double(get(hObject,'String')) returns contents of MzU2 as a double
handles.actions.setCommandLimit(12,2,0,get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function MzU2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzU2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzCV2 as text
%        str2double(get(hObject,'String')) returns contents of MzCV2 as a double


% --- Executes during object creation, after setting all properties.
function MzCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxT1_Callback(hObject, eventdata, handles)
% hObject    handle to DxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxT1 as text
%        str2double(get(hObject,'String')) returns contents of DxT1 as a double


% --- Executes during object creation, after setting all properties.
function DxT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxTCV1 as text
%        str2double(get(hObject,'String')) returns contents of DxTCV1 as a double


% --- Executes during object creation, after setting all properties.
function DxTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyT1_Callback(hObject, eventdata, handles)
% hObject    handle to DyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyT1 as text
%        str2double(get(hObject,'String')) returns contents of DyT1 as a double


% --- Executes during object creation, after setting all properties.
function DyT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyTCV1 as text
%        str2double(get(hObject,'String')) returns contents of DyTCV1 as a double


% --- Executes during object creation, after setting all properties.
function DyTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzT1_Callback(hObject, eventdata, handles)
% hObject    handle to DzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzT1 as text
%        str2double(get(hObject,'String')) returns contents of DzT1 as a double


% --- Executes during object creation, after setting all properties.
function DzT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to DzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzTCV1 as text
%        str2double(get(hObject,'String')) returns contents of DzTCV1 as a double


% --- Executes during object creation, after setting all properties.
function DzTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxT1_Callback(hObject, eventdata, handles)
% hObject    handle to RxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxT1 as text
%        str2double(get(hObject,'String')) returns contents of RxT1 as a double


% --- Executes during object creation, after setting all properties.
function RxT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxTCV1 as text
%        str2double(get(hObject,'String')) returns contents of RxTCV1 as a double


% --- Executes during object creation, after setting all properties.
function RxTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyT1_Callback(hObject, eventdata, handles)
% hObject    handle to RyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyT1 as text
%        str2double(get(hObject,'String')) returns contents of RyT1 as a double


% --- Executes during object creation, after setting all properties.
function RyT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyTCV1 as text
%        str2double(get(hObject,'String')) returns contents of RyTCV1 as a double


% --- Executes during object creation, after setting all properties.
function RyTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzT1_Callback(hObject, eventdata, handles)
% hObject    handle to RzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzT1 as text
%        str2double(get(hObject,'String')) returns contents of RzT1 as a double


% --- Executes during object creation, after setting all properties.
function RzT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to RzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzTCV1 as text
%        str2double(get(hObject,'String')) returns contents of RzTCV1 as a double


% --- Executes during object creation, after setting all properties.
function RzTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxT2_Callback(hObject, eventdata, handles)
% hObject    handle to DxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxT2 as text
%        str2double(get(hObject,'String')) returns contents of DxT2 as a double


% --- Executes during object creation, after setting all properties.
function DxT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxTCV2 as text
%        str2double(get(hObject,'String')) returns contents of DxTCV2 as a double


% --- Executes during object creation, after setting all properties.
function DxTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyT2_Callback(hObject, eventdata, handles)
% hObject    handle to DyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyT2 as text
%        str2double(get(hObject,'String')) returns contents of DyT2 as a double


% --- Executes during object creation, after setting all properties.
function DyT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyTCV2 as text
%        str2double(get(hObject,'String')) returns contents of DyTCV2 as a double


% --- Executes during object creation, after setting all properties.
function DyTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzT2_Callback(hObject, eventdata, handles)
% hObject    handle to DzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzT2 as text
%        str2double(get(hObject,'String')) returns contents of DzT2 as a double


% --- Executes during object creation, after setting all properties.
function DzT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to DzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzTCV2 as text
%        str2double(get(hObject,'String')) returns contents of DzTCV2 as a double


% --- Executes during object creation, after setting all properties.
function DzTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxT2_Callback(hObject, eventdata, handles)
% hObject    handle to RxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxT2 as text
%        str2double(get(hObject,'String')) returns contents of RxT2 as a double


% --- Executes during object creation, after setting all properties.
function RxT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxTCV2 as text
%        str2double(get(hObject,'String')) returns contents of RxTCV2 as a double


% --- Executes during object creation, after setting all properties.
function RxTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyT2_Callback(hObject, eventdata, handles)
% hObject    handle to RyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyT2 as text
%        str2double(get(hObject,'String')) returns contents of RyT2 as a double


% --- Executes during object creation, after setting all properties.
function RyT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyTCV2 as text
%        str2double(get(hObject,'String')) returns contents of RyTCV2 as a double


% --- Executes during object creation, after setting all properties.
function RyTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzT2_Callback(hObject, eventdata, handles)
% hObject    handle to RzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzT2 as text
%        str2double(get(hObject,'String')) returns contents of RzT2 as a double


% --- Executes during object creation, after setting all properties.
function RzT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to RzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzTCV2 as text
%        str2double(get(hObject,'String')) returns contents of RzTCV2 as a double


% --- Executes during object creation, after setting all properties.
function RzTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxT1_Callback(hObject, eventdata, handles)
% hObject    handle to FxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxT1 as text
%        str2double(get(hObject,'String')) returns contents of FxT1 as a double


% --- Executes during object creation, after setting all properties.
function FxT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxTCV1 as text
%        str2double(get(hObject,'String')) returns contents of FxTCV1 as a double


% --- Executes during object creation, after setting all properties.
function FxTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyT1_Callback(hObject, eventdata, handles)
% hObject    handle to FyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyT1 as text
%        str2double(get(hObject,'String')) returns contents of FyT1 as a double


% --- Executes during object creation, after setting all properties.
function FyT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyTCV1 as text
%        str2double(get(hObject,'String')) returns contents of FyTCV1 as a double


% --- Executes during object creation, after setting all properties.
function FyTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzT1_Callback(hObject, eventdata, handles)
% hObject    handle to FzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzT1 as text
%        str2double(get(hObject,'String')) returns contents of FzT1 as a double


% --- Executes during object creation, after setting all properties.
function FzT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to FzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzTCV1 as text
%        str2double(get(hObject,'String')) returns contents of FzTCV1 as a double


% --- Executes during object creation, after setting all properties.
function FzTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxT1_Callback(hObject, eventdata, handles)
% hObject    handle to MxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxT1 as text
%        str2double(get(hObject,'String')) returns contents of MxT1 as a double


% --- Executes during object creation, after setting all properties.
function MxT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxTCV1 as text
%        str2double(get(hObject,'String')) returns contents of MxTCV1 as a double


% --- Executes during object creation, after setting all properties.
function MxTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyT1_Callback(hObject, eventdata, handles)
% hObject    handle to MyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyT1 as text
%        str2double(get(hObject,'String')) returns contents of MyT1 as a double


% --- Executes during object creation, after setting all properties.
function MyT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyTCV1 as text
%        str2double(get(hObject,'String')) returns contents of MyTCV1 as a double


% --- Executes during object creation, after setting all properties.
function MyTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzT1_Callback(hObject, eventdata, handles)
% hObject    handle to MzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzT1 as text
%        str2double(get(hObject,'String')) returns contents of MzT1 as a double


% --- Executes during object creation, after setting all properties.
function MzT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzTCV1_Callback(hObject, eventdata, handles)
% hObject    handle to MzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzTCV1 as text
%        str2double(get(hObject,'String')) returns contents of MzTCV1 as a double


% --- Executes during object creation, after setting all properties.
function MzTCV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzTCV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxT2_Callback(hObject, eventdata, handles)
% hObject    handle to FxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxT2 as text
%        str2double(get(hObject,'String')) returns contents of FxT2 as a double


% --- Executes during object creation, after setting all properties.
function FxT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxTCV2 as text
%        str2double(get(hObject,'String')) returns contents of FxTCV2 as a double


% --- Executes during object creation, after setting all properties.
function FxTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyT2_Callback(hObject, eventdata, handles)
% hObject    handle to FyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyT2 as text
%        str2double(get(hObject,'String')) returns contents of FyT2 as a double


% --- Executes during object creation, after setting all properties.
function FyT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyTCV2 as text
%        str2double(get(hObject,'String')) returns contents of FyTCV2 as a double


% --- Executes during object creation, after setting all properties.
function FyTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzT2_Callback(hObject, eventdata, handles)
% hObject    handle to FzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzT2 as text
%        str2double(get(hObject,'String')) returns contents of FzT2 as a double


% --- Executes during object creation, after setting all properties.
function FzT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to FzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzTCV2 as text
%        str2double(get(hObject,'String')) returns contents of FzTCV2 as a double


% --- Executes during object creation, after setting all properties.
function FzTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxT2_Callback(hObject, eventdata, handles)
% hObject    handle to MxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxT2 as text
%        str2double(get(hObject,'String')) returns contents of MxT2 as a double


% --- Executes during object creation, after setting all properties.
function MxT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxTCV2 as text
%        str2double(get(hObject,'String')) returns contents of MxTCV2 as a double


% --- Executes during object creation, after setting all properties.
function MxTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyT2_Callback(hObject, eventdata, handles)
% hObject    handle to MyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyT2 as text
%        str2double(get(hObject,'String')) returns contents of MyT2 as a double


% --- Executes during object creation, after setting all properties.
function MyT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyTCV2 as text
%        str2double(get(hObject,'String')) returns contents of MyTCV2 as a double


% --- Executes during object creation, after setting all properties.
function MyTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzT2_Callback(hObject, eventdata, handles)
% hObject    handle to MzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzT2 as text
%        str2double(get(hObject,'String')) returns contents of MzT2 as a double


% --- Executes during object creation, after setting all properties.
function MzT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzTCV2_Callback(hObject, eventdata, handles)
% hObject    handle to MzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzTCV2 as text
%        str2double(get(hObject,'String')) returns contents of MzTCV2 as a double


% --- Executes during object creation, after setting all properties.
function MzTCV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzTCV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxI1_Callback(hObject, eventdata, handles)
% hObject    handle to DxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxI1 as text
%        str2double(get(hObject,'String')) returns contents of DxI1 as a double


% --- Executes during object creation, after setting all properties.
function DxI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxICV1_Callback(hObject, eventdata, handles)
% hObject    handle to DxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxICV1 as text
%        str2double(get(hObject,'String')) returns contents of DxICV1 as a double


% --- Executes during object creation, after setting all properties.
function DxICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyI1_Callback(hObject, eventdata, handles)
% hObject    handle to DyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyI1 as text
%        str2double(get(hObject,'String')) returns contents of DyI1 as a double


% --- Executes during object creation, after setting all properties.
function DyI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyICV1_Callback(hObject, eventdata, handles)
% hObject    handle to DyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyICV1 as text
%        str2double(get(hObject,'String')) returns contents of DyICV1 as a double


% --- Executes during object creation, after setting all properties.
function DyICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzI1_Callback(hObject, eventdata, handles)
% hObject    handle to DzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzI1 as text
%        str2double(get(hObject,'String')) returns contents of DzI1 as a double


% --- Executes during object creation, after setting all properties.
function DzI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzICV1_Callback(hObject, eventdata, handles)
% hObject    handle to DzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzICV1 as text
%        str2double(get(hObject,'String')) returns contents of DzICV1 as a double


% --- Executes during object creation, after setting all properties.
function DzICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxI1_Callback(hObject, eventdata, handles)
% hObject    handle to RxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxI1 as text
%        str2double(get(hObject,'String')) returns contents of RxI1 as a double


% --- Executes during object creation, after setting all properties.
function RxI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxICV1_Callback(hObject, eventdata, handles)
% hObject    handle to RxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxICV1 as text
%        str2double(get(hObject,'String')) returns contents of RxICV1 as a double


% --- Executes during object creation, after setting all properties.
function RxICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyI1_Callback(hObject, eventdata, handles)
% hObject    handle to RyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyI1 as text
%        str2double(get(hObject,'String')) returns contents of RyI1 as a double


% --- Executes during object creation, after setting all properties.
function RyI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyICV1_Callback(hObject, eventdata, handles)
% hObject    handle to RyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyICV1 as text
%        str2double(get(hObject,'String')) returns contents of RyICV1 as a double


% --- Executes during object creation, after setting all properties.
function RyICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzI1_Callback(hObject, eventdata, handles)
% hObject    handle to RzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzI1 as text
%        str2double(get(hObject,'String')) returns contents of RzI1 as a double


% --- Executes during object creation, after setting all properties.
function RzI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzICV1_Callback(hObject, eventdata, handles)
% hObject    handle to RzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzICV1 as text
%        str2double(get(hObject,'String')) returns contents of RzICV1 as a double


% --- Executes during object creation, after setting all properties.
function RzICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxI2_Callback(hObject, eventdata, handles)
% hObject    handle to DxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxI2 as text
%        str2double(get(hObject,'String')) returns contents of DxI2 as a double


% --- Executes during object creation, after setting all properties.
function DxI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DxICV2_Callback(hObject, eventdata, handles)
% hObject    handle to DxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DxICV2 as text
%        str2double(get(hObject,'String')) returns contents of DxICV2 as a double


% --- Executes during object creation, after setting all properties.
function DxICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyI2_Callback(hObject, eventdata, handles)
% hObject    handle to DyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyI2 as text
%        str2double(get(hObject,'String')) returns contents of DyI2 as a double


% --- Executes during object creation, after setting all properties.
function DyI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DyICV2_Callback(hObject, eventdata, handles)
% hObject    handle to DyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DyICV2 as text
%        str2double(get(hObject,'String')) returns contents of DyICV2 as a double


% --- Executes during object creation, after setting all properties.
function DyICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzI2_Callback(hObject, eventdata, handles)
% hObject    handle to DzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzI2 as text
%        str2double(get(hObject,'String')) returns contents of DzI2 as a double


% --- Executes during object creation, after setting all properties.
function DzI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DzICV2_Callback(hObject, eventdata, handles)
% hObject    handle to DzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DzICV2 as text
%        str2double(get(hObject,'String')) returns contents of DzICV2 as a double


% --- Executes during object creation, after setting all properties.
function DzICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxI2_Callback(hObject, eventdata, handles)
% hObject    handle to RxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxI2 as text
%        str2double(get(hObject,'String')) returns contents of RxI2 as a double


% --- Executes during object creation, after setting all properties.
function RxI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RxICV2_Callback(hObject, eventdata, handles)
% hObject    handle to RxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxICV2 as text
%        str2double(get(hObject,'String')) returns contents of RxICV2 as a double


% --- Executes during object creation, after setting all properties.
function RxICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyI2_Callback(hObject, eventdata, handles)
% hObject    handle to RyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyI2 as text
%        str2double(get(hObject,'String')) returns contents of RyI2 as a double


% --- Executes during object creation, after setting all properties.
function RyI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RyICV2_Callback(hObject, eventdata, handles)
% hObject    handle to RyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RyICV2 as text
%        str2double(get(hObject,'String')) returns contents of RyICV2 as a double


% --- Executes during object creation, after setting all properties.
function RyICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzI2_Callback(hObject, eventdata, handles)
% hObject    handle to RzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzI2 as text
%        str2double(get(hObject,'String')) returns contents of RzI2 as a double


% --- Executes during object creation, after setting all properties.
function RzI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RzICV2_Callback(hObject, eventdata, handles)
% hObject    handle to RzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RzICV2 as text
%        str2double(get(hObject,'String')) returns contents of RzICV2 as a double


% --- Executes during object creation, after setting all properties.
function RzICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxI1_Callback(hObject, eventdata, handles)
% hObject    handle to FxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxI1 as text
%        str2double(get(hObject,'String')) returns contents of FxI1 as a double


% --- Executes during object creation, after setting all properties.
function FxI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxICV1_Callback(hObject, eventdata, handles)
% hObject    handle to FxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxICV1 as text
%        str2double(get(hObject,'String')) returns contents of FxICV1 as a double


% --- Executes during object creation, after setting all properties.
function FxICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyI1_Callback(hObject, eventdata, handles)
% hObject    handle to FyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyI1 as text
%        str2double(get(hObject,'String')) returns contents of FyI1 as a double


% --- Executes during object creation, after setting all properties.
function FyI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyICV1_Callback(hObject, eventdata, handles)
% hObject    handle to FyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyICV1 as text
%        str2double(get(hObject,'String')) returns contents of FyICV1 as a double


% --- Executes during object creation, after setting all properties.
function FyICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzI1_Callback(hObject, eventdata, handles)
% hObject    handle to FzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzI1 as text
%        str2double(get(hObject,'String')) returns contents of FzI1 as a double


% --- Executes during object creation, after setting all properties.
function FzI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzICV1_Callback(hObject, eventdata, handles)
% hObject    handle to FzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzICV1 as text
%        str2double(get(hObject,'String')) returns contents of FzICV1 as a double


% --- Executes during object creation, after setting all properties.
function FzICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxI1_Callback(hObject, eventdata, handles)
% hObject    handle to MxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxI1 as text
%        str2double(get(hObject,'String')) returns contents of MxI1 as a double


% --- Executes during object creation, after setting all properties.
function MxI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxICV1_Callback(hObject, eventdata, handles)
% hObject    handle to MxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxICV1 as text
%        str2double(get(hObject,'String')) returns contents of MxICV1 as a double


% --- Executes during object creation, after setting all properties.
function MxICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyI1_Callback(hObject, eventdata, handles)
% hObject    handle to MyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyI1 as text
%        str2double(get(hObject,'String')) returns contents of MyI1 as a double


% --- Executes during object creation, after setting all properties.
function MyI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyICV1_Callback(hObject, eventdata, handles)
% hObject    handle to MyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyICV1 as text
%        str2double(get(hObject,'String')) returns contents of MyICV1 as a double


% --- Executes during object creation, after setting all properties.
function MyICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzI1_Callback(hObject, eventdata, handles)
% hObject    handle to MzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzI1 as text
%        str2double(get(hObject,'String')) returns contents of MzI1 as a double


% --- Executes during object creation, after setting all properties.
function MzI1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzI1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzICV1_Callback(hObject, eventdata, handles)
% hObject    handle to MzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzICV1 as text
%        str2double(get(hObject,'String')) returns contents of MzICV1 as a double


% --- Executes during object creation, after setting all properties.
function MzICV1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzICV1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxI2_Callback(hObject, eventdata, handles)
% hObject    handle to FxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxI2 as text
%        str2double(get(hObject,'String')) returns contents of FxI2 as a double


% --- Executes during object creation, after setting all properties.
function FxI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FxICV2_Callback(hObject, eventdata, handles)
% hObject    handle to FxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FxICV2 as text
%        str2double(get(hObject,'String')) returns contents of FxICV2 as a double


% --- Executes during object creation, after setting all properties.
function FxICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyI2_Callback(hObject, eventdata, handles)
% hObject    handle to FyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyI2 as text
%        str2double(get(hObject,'String')) returns contents of FyI2 as a double


% --- Executes during object creation, after setting all properties.
function FyI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FyICV2_Callback(hObject, eventdata, handles)
% hObject    handle to FyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FyICV2 as text
%        str2double(get(hObject,'String')) returns contents of FyICV2 as a double


% --- Executes during object creation, after setting all properties.
function FyICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzI2_Callback(hObject, eventdata, handles)
% hObject    handle to FzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzI2 as text
%        str2double(get(hObject,'String')) returns contents of FzI2 as a double


% --- Executes during object creation, after setting all properties.
function FzI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FzICV2_Callback(hObject, eventdata, handles)
% hObject    handle to FzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FzICV2 as text
%        str2double(get(hObject,'String')) returns contents of FzICV2 as a double


% --- Executes during object creation, after setting all properties.
function FzICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxI2_Callback(hObject, eventdata, handles)
% hObject    handle to MxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxI2 as text
%        str2double(get(hObject,'String')) returns contents of MxI2 as a double


% --- Executes during object creation, after setting all properties.
function MxI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MxICV2_Callback(hObject, eventdata, handles)
% hObject    handle to MxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MxICV2 as text
%        str2double(get(hObject,'String')) returns contents of MxICV2 as a double


% --- Executes during object creation, after setting all properties.
function MxICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MxICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyI2_Callback(hObject, eventdata, handles)
% hObject    handle to MyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyI2 as text
%        str2double(get(hObject,'String')) returns contents of MyI2 as a double


% --- Executes during object creation, after setting all properties.
function MyI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MyICV2_Callback(hObject, eventdata, handles)
% hObject    handle to MyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MyICV2 as text
%        str2double(get(hObject,'String')) returns contents of MyICV2 as a double


% --- Executes during object creation, after setting all properties.
function MyICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzI2_Callback(hObject, eventdata, handles)
% hObject    handle to MzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzI2 as text
%        str2double(get(hObject,'String')) returns contents of MzI2 as a double


% --- Executes during object creation, after setting all properties.
function MzI2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MzICV2_Callback(hObject, eventdata, handles)
% hObject    handle to MzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MzICV2 as text
%        str2double(get(hObject,'String')) returns contents of MzICV2 as a double


% --- Executes during object creation, after setting all properties.
function MzICV2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MzICV2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NetworkConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to NetworkConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NetworkConfig('cfg',handles.actions.cfg);

% --------------------------------------------------------------------
function OmConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to OmConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OmConfig('cfg',handles.actions.cfg);

% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.cfg.load()

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.cfg.save()

% --------------------------------------------------------------------
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.cfg.import()

% --------------------------------------------------------------------
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.cfg.export()


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.LbcbPlugin);


% --- Executes on button press in InputFile.
function InputFile_Callback(hObject, eventdata, handles)
% hObject    handle to InputFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.actions.setInputFile({});


% --------------------------------------------------------------------
function LoggingLevels_Callback(hObject, eventdata, handles)
% hObject    handle to LoggingLevels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LoggerLevels('cfg',handles.actions.cfg);
handles.actions.setLoggerLevels();