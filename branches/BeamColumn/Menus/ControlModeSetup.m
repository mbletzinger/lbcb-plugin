function varargout = ControlModeSetup(varargin)
% CONTROLMODESETUP M-file for ControlModeSetup.fig
%      CONTROLMODESETUP, by itself, creates a new CONTROLMODESETUP or raises the existing
%      singleton*.
%
%      H = CONTROLMODESETUP returns the handle to a new CONTROLMODESETUP or the handle to
%      the existing singleton*.
%
%      CONTROLMODESETUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLMODESETUP.M with the given input arguments.
%
%      CONTROLMODESETUP('Property','Value',...) creates a new CONTROLMODESETUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ControlModeSetup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ControlModeSetup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ControlModeSetup

% Last Modified by GUIDE v2.5 22-Feb-2009 15:46:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlModeSetup_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlModeSetup_OutputFcn, ...
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


% --- Executes just before ControlModeSetup is made visible.
function ControlModeSetup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ControlModeSetup (see VARARGIN)

% Choose default command line output for ControlModeSetup
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
handles.output = inputData;
handles.controlModeData.DisplacementMeasurement.Lbcb = inputData.DisplacementMeasurement.Lbcb;
handles.controlModeData.DisplacementMeasurement.ExternalTransducers = ...
    inputData.DisplacementMeasurement.ExternalTransducers;
handles.controlModeData.ControlMode.DisplacementControl = inputData.ControlMode.DisplacementControl;
handles.controlModeData.ControlMode.MixedModeControlPsd = inputData.ControlMode.MixedModeControlPsd;
handles.controlModeData.ControlMode.MixedModeControlStatic = inputData.ControlMode.MixedModeControlStatic;
handles.controlModeData.ForceControlDof=inputData.ForceControlDof;
handles.controlModeData.LowerBound = inputData.LowerBound;
handles.controlModeData.KsecEvaluationIterator = inputData.KsecEvaluationIterator;
handles.controlModeData.KsecFactor = inputData.KsecFactor;
handles.controlModeData.MixedModeControlStatic.Fx = inputData.MixedModeControlStatic.Fx;
handles.controlModeData.MixedModeControlStatic.Fy = inputData.MixedModeControlStatic.Fy;
handles.controlModeData.MixedModeControlStatic.Fz = inputData.MixedModeControlStatic.Fz;
handles.controlModeData.MixedModeControlStatic.Mx = inputData.MixedModeControlStatic.Mx;
handles.controlModeData.MixedModeControlStatic.My = inputData.MixedModeControlStatic.My;
handles.controlModeData.MixedModeControlStatic.Mz = inputData.MixedModeControlStatic.Mz;
handles.controlModeData.MaxIterations = inputData.MaxIterations;

enableMixedControl(hObject, handles,inputData);
Update(hObject, handles,inputData);

% UIWAIT makes ControlModeSetup wait for user response (see UIRESUME)
 uiwait(handles.ControlModeSetup);


% --- Outputs from this function are returned to the command line.
function varargout = ControlModeSetup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The GUI is no longer waiting, just close it
delete(handles.ControlModeSetup);



% --- Executes on selection change in MixedModeControlDofPopup.
function MixedModeControlDofPopup_Callback(hObject, eventdata, handles)
% hObject    handle to MixedModeControlDofPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MixedModeControlDofPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MixedModeControlDofPopup
controlModeData = handles.controlModeData;
controlModeData.ForceControlDof = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes during object creation, after setting all properties.
function MixedModeControlDofPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MixedModeControlDofPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LowerBoundEdit_Callback(hObject, eventdata, handles)
% hObject    handle to LowerBoundEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LowerBoundEdit as text
%        str2double(get(hObject,'String')) returns contents of LowerBoundEdit as a double
controlModeData = handles.controlModeData;
controlModeData.LowerBound = str2double(get(hObject,'String'));
Update(hObject, handles,controlModeData);


% --- Executes during object creation, after setting all properties.
function LowerBoundEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LowerBoundEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KsecEvalIteratorEdit_Callback(hObject, eventdata, handles)
% hObject    handle to KsecEvalIteratorEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KsecEvalIteratorEdit as text
%        str2double(get(hObject,'String')) returns contents of KsecEvalIteratorEdit as a double
controlModeData = handles.controlModeData;
controlModeData.KsecEvaluationIterator = str2double(get(hObject,'String'));
Update(hObject, handles,controlModeData);


% --- Executes during object creation, after setting all properties.
function KsecEvalIteratorEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KsecEvalIteratorEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KsecFacterEdit_Callback(hObject, eventdata, handles)
% hObject    handle to KsecFacterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KsecFacterEdit as text
%        str2double(get(hObject,'String')) returns contents of KsecFacterEdit as a double
controlModeData = handles.controlModeData;
controlModeData.KsecFactor = str2double(get(hObject,'String'));
Update(hObject, handles,controlModeData);


% --- Executes during object creation, after setting all properties.
function KsecFacterEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KsecFacterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FxCheck.
function FxCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FxCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FxCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.Fx = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes on button press in FyCheck.
function FyCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FyCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FyCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.Fy = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes on button press in FzCheck.
function FzCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FzCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FzCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.Fz = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes on button press in MxCheck.
function MxCheck_Callback(hObject, eventdata, handles)
% hObject    handle to MxCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MxCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.Mx = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes on button press in MyCheck.
function MyCheck_Callback(hObject, eventdata, handles)
% hObject    handle to MyCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MyCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.My = get(hObject,'Value');
Update(hObject, handles,controlModeData);


% --- Executes on button press in MzCheck.
function MzCheck_Callback(hObject, eventdata, handles)
% hObject    handle to MzCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MzCheck
controlModeData = handles.controlModeData;
controlModeData.MixedModeControlStatic.Mz = get(hObject,'Value');
Update(hObject, handles,controlModeData);



function MaxIterationEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MaxIterationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxIterationEdit as text
%        str2double(get(hObject,'String')) returns contents of MaxIterationEdit as a double
controlModeData = handles.controlModeData;
controlModeData.MaxIterations = str2double(get(hObject,'String'));
Update(hObject, handles,controlModeData);


% --- Executes during object creation, after setting all properties.
function MaxIterationEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxIterationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in DisplacementMeasurementPanel.
function DisplacementMeasurementPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in DisplacementMeasurementPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
controlModeData = handles.controlModeData;
controlModeData.DisplacementMeasurement.Lbcb = 0;
controlModeData.DisplacementMeasurement.ExternalTransducers = 0;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'LbcbButton'
    controlModeData.DisplacementMeasurement.Lbcb = get(hObject,'Value');
        % Code for when radiobutton2 is selected.
    case 'ExternalTransducersButton'
        controlModeData.DisplacementMeasurement.ExternalTransducers = get(hObject,'Value');
    otherwise
       errorMsg = strcat('Tag [ ',get(eventdata.NewValue,'Tag'),'] not recognized')
end
Update(hObject, handles,controlModeData);

% --- Executes when selected object is changed in ControlModePanel.
function ControlModePanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ControlModePanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
controlModeData = handles.controlModeData;
controlModeData.ControlMode.DisplacementControl = 0;
controlModeData.ControlMode.MixedModeControlPsd = 0;
controlModeData.ControlMode.MixedModeControlStatic = 0;

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'DisplacmentControlButton'
        controlModeData.ControlMode.DisplacementControl = get(hObject,'Value');
    case 'MixedControl1Psd'
        controlModeData.ControlMode.MixedModeControlPsd = get(hObject,'Value');
    case 'MixedControl2StaticButton'
        controlModeData.ControlMode.MixedModeControlStatic = get(hObject,'Value');
    otherwise
        errorMsg = strcat('Tag [ ',get(eventdata.NewValue,'Tag'),'] not recognized')
end
enableMixedControl(hObject, handles,controlModeData);
Update(hObject, handles,controlModeData);


% --- Executes on button press in OkButton.
function OkButton_Callback(hObject, eventdata, handles)
% hObject    handle to OkButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.controlModeData; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.ControlModeSetup);


% --- Executes on button press in CancelButton.
function CancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = handles.default; 
% Update handles structure
guidata(hObject, handles);
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.ControlModeSetup);


function Update(hObject, handles,controlModeData)
handles.controlModeData = controlModeData;
% Update handles structure
guidata(hObject, handles);

function enableMixedControl(hObject, handles,controlModeData)
cmd = controlModeData.ControlMode;
if(cmd.DisplacementControl)
    set(handles.MixedModeControlDofPopup,'enable','off');
    set(handles.LowerBoundEdit,'enable','off');
    set(handles.KsecEvalIteratorEdit,'enable','off');
    set(handles.KsecFacterEdit,'enable','off');
    set(handles.FxCheck,'enable','off');
    set(handles.FyCheck,'enable','off');
    set(handles.FzCheck,'enable','off');
    set(handles.MxCheck,'enable','off');
    set(handles.MyCheck,'enable','off');
    set(handles.MzCheck,'enable','off');
    guidata(hObject, handles);
    return;
end
if(cmd.MixedModeControlPsd)
    set(handles.MixedModeControlDofPopup,'enable','on');
    set(handles.LowerBoundEdit,'enable','on');
    set(handles.KsecEvalIteratorEdit,'enable','on');
    set(handles.KsecFacterEdit,'enable','on');
    set(handles.FxCheck,'enable','off');
    set(handles.FyCheck,'enable','off');
    set(handles.FzCheck,'enable','off');
    set(handles.MxCheck,'enable','off');
    set(handles.MyCheck,'enable','off');
    set(handles.MzCheck,'enable','off');
    guidata(hObject, handles);
    return;
end
if(cmd.MixedModeControlStatic)
    set(handles.MixedModeControlDofPopup,'enable','off');
    set(handles.LowerBoundEdit,'enable','off');
    set(handles.KsecEvalIteratorEdit,'enable','off');
    set(handles.KsecFacterEdit,'enable','off');
    set(handles.FxCheck,'enable','on');
    set(handles.FyCheck,'enable','on');
    set(handles.FzCheck,'enable','on');
    set(handles.MxCheck,'enable','on');
    set(handles.MyCheck,'enable','on');
    set(handles.MzCheck,'enable','on');
    guidata(hObject, handles);
    return;
end

