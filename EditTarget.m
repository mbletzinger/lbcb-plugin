function varargout = EditTarget(varargin)
% EDITTARGET M-file for EditTarget.fig
%      EDITTARGET, by itself, creates a new EDITTARGET or raises the existing
%      singleton*.
%
%      H = EDITTARGET returns the handle to a new EDITTARGET or the handle to
%      the existing singleton*.
%
%      EDITTARGET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITTARGET.M with the given input arguments.
%
%      EDITTARGET('Property','Value',...) creates a new EDITTARGET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EditTarget_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EditTarget_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EditTarget

% Last Modified by GUIDE v2.5 08-Dec-2009 00:05:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EditTarget_OpeningFcn, ...
                   'gui_OutputFcn',  @EditTarget_OutputFcn, ...
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


% --- Executes just before EditTarget is made visible.
function EditTarget_OpeningFcn(hObject, eventdata, handles, varargin)  %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EditTarget (see VARARGIN)

% Choose default command line output for EditTarget
handles.output = hObject;
targets = cell(2,1);

if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'targets'
                targets = varargin{index+1};
            otherwise
            str= sprintf('%s not recognized',label);
            disp(str);
        end
    end
end
handles.actions = EditTargetActions(targets);
handles.actions.init(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EditTarget wait for user response (see UIRESUME)
uiwait(handles.EditTarget);


% --- Outputs from this function are returned to the command line.
function varargout = EditTarget_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSD>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1;



function dx1_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to dx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dx1 as text
%        str2double(get(hObject,'String')) returns contents of dx1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),1,1);


function dy1_Callback(hObject, eventdata, handles)
% hObject    handle to dy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dy1 as text
%        str2double(get(hObject,'String')) returns contents of dy1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),2,1);



function dz1_Callback(hObject, eventdata, handles)
% hObject    handle to dz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dz1 as text
%        str2double(get(hObject,'String')) returns contents of dz1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),3,1);



function rx1_Callback(hObject, eventdata, handles)
% hObject    handle to rx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx1 as text
%        str2double(get(hObject,'String')) returns contents of rx1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),4,1);



function ry1_Callback(hObject, eventdata, handles)
% hObject    handle to ry1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ry1 as text
%        str2double(get(hObject,'String')) returns contents of ry1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),5,1);



function rz1_Callback(hObject, eventdata, handles)
% hObject    handle to rz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rz1 as text
%        str2double(get(hObject,'String')) returns contents of rz1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),6,1);



function fx1_Callback(hObject, eventdata, handles)
% hObject    handle to fx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fx1 as text
%        str2double(get(hObject,'String')) returns contents of fx1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),1,2);



function fy1_Callback(hObject, eventdata, handles)
% hObject    handle to fy1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fy1 as text
%        str2double(get(hObject,'String')) returns contents of fy1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),2,2);



function fz1_Callback(hObject, eventdata, handles)
% hObject    handle to fz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fz1 as text
%        str2double(get(hObject,'String')) returns contents of fz1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),3,2);



function mx1_Callback(hObject, eventdata, handles)
% hObject    handle to mx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mx1 as text
%        str2double(get(hObject,'String')) returns contents of mx1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),4,2);



function my1_Callback(hObject, eventdata, handles)
% hObject    handle to my1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of my1 as text
%        str2double(get(hObject,'String')) returns contents of my1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),5,2);



function mz1_Callback(hObject, eventdata, handles)
% hObject    handle to mz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mz1 as text
%        str2double(get(hObject,'String')) returns contents of mz1 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),6,2);



function dx2_Callback(hObject, eventdata, handles)
% hObject    handle to dx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dx2 as text
%        str2double(get(hObject,'String')) returns contents of dx2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),1,3);



function dy2_Callback(hObject, eventdata, handles)
% hObject    handle to dy2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dy2 as text
%        str2double(get(hObject,'String')) returns contents of dy2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),2,3);



function dz2_Callback(hObject, eventdata, handles)
% hObject    handle to dz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dz2 as text
%        str2double(get(hObject,'String')) returns contents of dz2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),3,3);



function rx2_Callback(hObject, eventdata, handles)
% hObject    handle to rx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx2 as text
%        str2double(get(hObject,'String')) returns contents of rx2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),4,3);



function ry2_Callback(hObject, eventdata, handles)
% hObject    handle to ry2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ry2 as text
%        str2double(get(hObject,'String')) returns contents of ry2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),5,3);



function rz2_Callback(hObject, eventdata, handles)
% hObject    handle to rz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rz2 as text
%        str2double(get(hObject,'String')) returns contents of rz2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),6,3);



function fx2_Callback(hObject, eventdata, handles)
% hObject    handle to fx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fx2 as text
%        str2double(get(hObject,'String')) returns contents of fx2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),1,4);



function fy2_Callback(hObject, eventdata, handles)
% hObject    handle to fy2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fy2 as text
%        str2double(get(hObject,'String')) returns contents of fy2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),2,4);



function fz2_Callback(hObject, eventdata, handles)
% hObject    handle to fz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fz2 as text
%        str2double(get(hObject,'String')) returns contents of fz2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),3,4);



function mx2_Callback(hObject, eventdata, handles)
% hObject    handle to mx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mx2 as text
%        str2double(get(hObject,'String')) returns contents of mx2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),4,4);



function my2_Callback(hObject, eventdata, handles)
% hObject    handle to my2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of my2 as text
%        str2double(get(hObject,'String')) returns contents of my2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),5,4);



function mz2_Callback(hObject, eventdata, handles)
% hObject    handle to mz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mz2 as text
%        str2double(get(hObject,'String')) returns contents of mz2 as a double
handles.actions.setCommand(str2double(get(hObject,'String')),6,4);


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.EditTarget);