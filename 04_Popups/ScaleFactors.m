function varargout = ScaleFactors(varargin)
% SCALEFACTORS M-file for ScaleFactors.fig
%      SCALEFACTORS, by itself, creates a new SCALEFACTORS or raises the existing
%      singleton*.
%
%      H = SCALEFACTORS returns the handle to a new SCALEFACTORS or the handle to
%      the existing singleton*.
%
%      SCALEFACTORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCALEFACTORS.M with the given input arguments.
%
%      SCALEFACTORS('Property','Value',...) creates a new SCALEFACTORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ScaleFactors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ScaleFactors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ScaleFactors

% Last Modified by GUIDE v2.5 23-Feb-2009 03:40:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ScaleFactors_OpeningFcn, ...
                   'gui_OutputFcn',  @ScaleFactors_OutputFcn, ...
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


% --- Executes just before ScaleFactors is made visible.
function ScaleFactors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ScaleFactors (see VARARGIN)

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
handles.scaleFactorData = inputData;
handles.output = inputData;
set(handles.DisplacementScaleEdit, 'String', inputData.Displacement);
set(handles.ForceEdit, 'String', inputData.Force);
set(handles.RotationEdit, 'String', inputData.Rotation);
set(handles.MomentEdit, 'String', inputData.Moment);

Update(hObject, handles,inputData);

% Make the GUI modal
set(handles.ScaleFactors,'WindowStyle','modal');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ScaleFactors wait for user response (see UIRESUME)
uiwait(handles.ScaleFactors);


% --- Outputs from this function are returned to the command line.
function varargout = ScaleFactors_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The GUI is no longer waiting, just close it
delete(handles.ScaleFactors);

function DisplacementScaleEdit_Callback(hObject, eventdata, handles)
% hObject    handle to DisplacementScaleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DisplacementScaleEdit as text
%        str2double(get(hObject,'String')) returns contents of DisplacementScaleEdit as a double
scaleFactorData = handles.scaleFactorData;
scaleFactorData.Displacement = str2double(get(hObject,'String'));
Update(hObject, handles,scaleFactorData);


% --- Executes during object creation, after setting all properties.
function DisplacementScaleEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DisplacementScaleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ForceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ForceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ForceEdit as text
%        str2double(get(hObject,'String')) returns contents of ForceEdit as a double
scaleFactorData = handles.scaleFactorData;
scaleFactorData.Force = str2double(get(hObject,'String'));
Update(hObject, handles,scaleFactorData);


% --- Executes during object creation, after setting all properties.
function ForceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ForceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RotationEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RotationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RotationEdit as text
%        str2double(get(hObject,'String')) returns contents of RotationEdit as a double
scaleFactorData = handles.scaleFactorData;
scaleFactorData.Rotation = str2double(get(hObject,'String'));
Update(hObject, handles,scaleFactorData);


% --- Executes during object creation, after setting all properties.
function RotationEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RotationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MomentEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MomentEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MomentEdit as text
%        str2double(get(hObject,'String')) returns contents of MomentEdit as a double
scaleFactorData = handles.scaleFactorData;
scaleFactorData.Moment = str2double(get(hObject,'String'));
Update(hObject, handles,scaleFactorData);


% --- Executes during object creation, after setting all properties.
function MomentEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MomentEdit (see GCBO)
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
handles.output = handles.scaleFactorData; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.ScaleFactors);


% --- Executes on button press in CancelButton.
function CancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.ScaleFactors);

function Update(hObject, handles,scaleFactorData)
handles.scaleFactorData = scaleFactorData;
% Update handles structure
guidata(hObject, handles);


