function varargout = Dofs6x1(varargin)
% DOFS6X1 M-file for Dofs6x1.fig
%      DOFS6X1, by itself, creates a new DOFS6X1 or raises the existing
%      singleton*.
%
%      H = DOFS6X1 returns the handle to a new DOFS6X1 or the handle to
%      the existing singleton*.
%
%      DOFS6X1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOFS6X1.M with the given input arguments.
%
%      DOFS6X1('Property','Value',...) creates a new DOFS6X1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dofs6x1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dofs6x1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dofs6x1

% Last Modified by GUIDE v2.5 15-Feb-2009 18:49:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dofs6x1_OpeningFcn, ...
                   'gui_OutputFcn',  @Dofs6x1_OutputFcn, ...
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


% --- Executes just before Dofs6x1 is made visible.
function Dofs6x1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dofs6x1 (see VARARGIN)
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'values'
          input = varargin{index+1};
        end
    end
end
handles.default = input;
handles.dofs = input;
handles.output = input;
set(handles.DOF1, 'String', num2str(input(1)));
set(handles.DOF2, 'String', num2str(input(2)));
set(handles.DOF3, 'String', num2str(input(3)));
set(handles.DOF4, 'String', num2str(input(4)));
set(handles.DOF5, 'String', num2str(input(5)));
set(handles.DOF6, 'String', num2str(input(6)));
UpdateDofs(hObject, handles,input);

% Make the GUI modal
set(handles.Dofs6x1,'WindowStyle','modal')

% UIWAIT makes Dofs6x1 wait for user response (see UIRESUME)
uiwait(handles.Dofs6x1);


% --- Outputs from this function are returned to the command line.
function varargout = Dofs6x1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.dofs;
% The figure can be deleted now
delete(handles.Dofs6x1);



function DOF1_Callback(hObject, eventdata, handles)
% hObject    handle to DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF1 as text
%        str2double(get(hObject,'String')) returns contents of DOF1 as a double
dofs = handles.dofs;
dofs(1) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DOF2_Callback(hObject, eventdata, handles)
% hObject    handle to DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF2 as text
%        str2double(get(hObject,'String')) returns contents of DOF2 as a double
dofs = handles.dofs;
dofs(2) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DOF3_Callback(hObject, eventdata, handles)
% hObject    handle to DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF3 as text
%        str2double(get(hObject,'String')) returns contents of DOF3 as a double
dofs = handles.dofs;
dofs(3) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DOF4_Callback(hObject, eventdata, handles)
% hObject    handle to DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF4 as text
%        str2double(get(hObject,'String')) returns contents of DOF4 as a double
dofs = handles.dofs;
dofs(4) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DOF5_Callback(hObject, eventdata, handles)
% hObject    handle to DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF5 as text
%        str2double(get(hObject,'String')) returns contents of DOF5 as a double
dofs = handles.dofs;
dofs(5) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DOF6_Callback(hObject, eventdata, handles)
% hObject    handle to DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DOF6 as text
%        str2double(get(hObject,'String')) returns contents of DOF6 as a double
dofs = handles.dofs;
dofs(6) = str2double(get(hObject,'String'));
UpdateDofs(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function DOF6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DOF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -- Update DOF fields
function UpdateDofs(hObject, handles, dofs)
handles.dofs = dofs;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.dofs; 
% Update handles structure
guidata(hObject, handles);
if isequal(get(handles.Dofs6x1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.Dofs6x1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.Dofs6x1);
end


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% Update handles structure
guidata(hObject, handles);
if isequal(get(handles.Dofs6x1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.Dofs6x1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.Dofs6x1);
end


