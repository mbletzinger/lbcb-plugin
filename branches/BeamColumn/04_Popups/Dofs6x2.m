function varargout = Dofs6x2(varargin)
% Dofs6x2 M-file for Dofs6x2.fig
%      Dofs6x2, by itself, creates a new Dofs6x2 or raises the existing
%      singleton*.
%
%      H = Dofs6x2 returns the handle to a new Dofs6x2 or the handle to
%      the existing singleton*.
%
%      Dofs6x2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Dofs6x2.M with the given input arguments.
%
%      Dofs6x2('Property','Value',...) creates a new Dofs6x2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dofs6x2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dofs6x2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dofs6x2

% Last Modified by GUIDE v2.5 16-Feb-2009 12:19:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dofs6x2_OpeningFcn, ...
                   'gui_OutputFcn',  @Dofs6x2_OutputFcn, ...
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


% --- Executes just before Dofs6x2 is made visible.
function Dofs6x2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dofs6x2 (see VARARGIN)
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
set(handles.Dof1Min, 'String', num2str(input(1,1)));
set(handles.Dof1Max, 'String', num2str(input(1,2)));
set(handles.Dof2Min, 'String', num2str(input(2,1)));
set(handles.Dof2Max, 'String', num2str(input(2,2)));
set(handles.Dof3Min, 'String', num2str(input(3,1)));
set(handles.Dof3Max, 'String', num2str(input(3,2)));
set(handles.Dof4Min, 'String', num2str(input(4,1)));
set(handles.Dof4Max, 'String', num2str(input(4,2)));
set(handles.Dof5Min, 'String', num2str(input(5,1)));
set(handles.Dof5Max, 'String', num2str(input(5,2)));
set(handles.Dof6Min, 'String', num2str(input(6,1)));
set(handles.Dof6Max, 'String', num2str(input(6,2)));
UpdateDofs6x2(hObject, handles,input);

% Make the GUI modal
set(handles.Dofs6x2,'WindowStyle','modal')

% UIWAIT makes Dofs6x2 wait for user response (see UIRESUME)
uiwait(handles.Dofs6x2);


% --- Outputs from this function are returned to the command line.
function varargout = Dofs6x2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.dofs;
% The figure can be deleted now
delete(handles.Dofs6x2);



function Dof1Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof1Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof1Min as text
%        str2double(get(hObject,'String')) returns contents of Dof1Min as a double
dofs = handles.dofs;
dofs(1,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof1Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof1Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof2Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof2Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof2Min as text
%        str2double(get(hObject,'String')) returns contents of Dof2Min as a double
dofs = handles.dofs;
dofs(2,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof2Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof2Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof3Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof3Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof3Min as text
%        str2double(get(hObject,'String')) returns contents of Dof3Min as a double
dofs = handles.dofs;
dofs(3,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof3Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof3Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof4Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof4Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof4Min as text
%        str2double(get(hObject,'String')) returns contents of Dof4Min as a double
dofs = handles.dofs;
dofs(4,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof4Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof4Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof5Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof5Min as text
%        str2double(get(hObject,'String')) returns contents of Dof5Min as a double
dofs = handles.dofs;
dofs(5,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof5Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof6Min_Callback(hObject, eventdata, handles)
% hObject    handle to Dof6Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof6Min as text
%        str2double(get(hObject,'String')) returns contents of Dof6Min as a double
dofs = handles.dofs;
dofs(6,1) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof6Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof6Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -- Update DOF fields
function UpdateDofs6x2(hObject, handles, dofs)
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
if isequal(get(handles.Dofs6x2, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.Dofs6x2);
else
    % The GUI is no longer waiting, just close it
    delete(handles.Dofs6x2);
end


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% Update handles structure
guidata(hObject, handles);
if isequal(get(handles.Dofs6x2, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.Dofs6x2);
else
    % The GUI is no longer waiting, just close it
    delete(handles.Dofs6x2);
end



function Dof1Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof1Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof1Max as text
%        str2double(get(hObject,'String')) returns contents of Dof1Max as a double
dofs = handles.dofs;
dofs(1,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof1Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof1Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof2Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof2Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof2Max as text
%        str2double(get(hObject,'String')) returns contents of Dof2Max as a double
dofs = handles.dofs;
dofs(2,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof2Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof2Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof3Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof3Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof3Max as text
%        str2double(get(hObject,'String')) returns contents of Dof3Max as a double
dofs = handles.dofs;
dofs(3,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof3Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof3Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof4Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof4Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof4Max as text
%        str2double(get(hObject,'String')) returns contents of Dof4Max as a double
dofs = handles.dofs;
dofs(4,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof4Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof4Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof5Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof5Max as text
%        str2double(get(hObject,'String')) returns contents of Dof5Max as a double
dofs = handles.dofs;
dofs(5,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof5Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dof6Max_Callback(hObject, eventdata, handles)
% hObject    handle to Dof6Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dof6Max as text
%        str2double(get(hObject,'String')) returns contents of Dof6Max as a double
dofs = handles.dofs;
dofs(6,2) = str2double(get(hObject,'String'));
UpdateDofs6x2(hObject, handles,dofs);


% --- Executes during object creation, after setting all properties.
function Dof6Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dof6Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


