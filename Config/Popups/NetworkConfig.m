
% =====================================================================================================================
% Widget which allows the network config to be modified.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
function varargout = NetworkConfig(varargin)
% NETWORKCONFIG M-file for NetworkConfig.fig
%      NETWORKCONFIG, by itself, creates a new NETWORKCONFIG or raises the existing
%      singleton*.
%
%      H = NETWORKCONFIG returns the handle to a new NETWORKCONFIG or the handle to
%      the existing singleton*.
%
%      NETWORKCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NETWORKCONFIG.M with the given input arguments.
%
%      NETWORKCONFIG('Property','Value',...) creates a new NETWORKCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NetworkConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NetworkConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NetworkConfig

% Last Modified by GUIDE v2.5 02-Apr-2010 08:42:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NetworkConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @NetworkConfig_OutputFcn, ...
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


% --- Executes just before NetworkConfig is made visible.
function NetworkConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NetworkConfig (see VARARGIN)

% Choose default command line output for NetworkConfig
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

handles.dao = NetworkConfigDao(cfg);

set(handles.omHost,'String',handles.dao.omHost);
set(handles.OmPort,'String',sprintf('%d',handles.dao.omPort));
set(handles.SimCorPort,'String',sprintf('%d',handles.dao.simcorPort));
set(handles.TriggerPort,'String',sprintf('%d',handles.dao.triggerPort));
set(handles.connectionTimeout,'String',sprintf('%d',handles.dao.connectionTimeout));
set(handles.msgTimeout,'String',sprintf('%d',handles.dao.msgTimeout));
set(handles.executeMsgTimeout,'String',sprintf('%d',handles.dao.executeMsgTimeout));
set(handles.Address,'String',handles.dao.address);
set(handles.systemDescription,'String',handles.dao.systemDescription);
% Make the GUI modal
set(handles.NetworkConfig,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NetworkConfig wait for user response (see UIRESUME)
% uiwait(handles.NetworkConfig);


function varargout = NetworkConfig_OutputFcn(hObject, eventdata, handles)  %#ok<INUSD,*STOUT>



function omHost_Callback(hObject, eventdata, handles) %#ok<*INUSL>
handles.dao.omHost = get(hObject,'String');


function OmPort_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
handles.dao.omPort = sscanf(get(hObject,'String'),'%d');




function TriggerPort_Callback(hObject, eventdata, handles)
handles.dao.triggerPort = sscanf(get(hObject,'String'),'%d');



function connectionTimeout_Callback(hObject, eventdata, handles)
handles.dao.connectionTimeout = sscanf(get(hObject,'String'),'%d');


function SimCorPort_Callback(hObject, eventdata, handles)
handles.dao.simcorPort = sccanf(get(hObject,'String'),'%d');




function OkButton_Callback(hObject, eventdata, handles)
delete(handles.NetworkConfig);



function Address_Callback(hObject, eventdata, handles)
handles.dao.address = get(hObject,'String');

function msgTimeout_Callback(hObject, eventdata, handles)
handles.dao.msgTimeout = sscanf(get(hObject,'String'),'%d');



function executeMsgTimeout_Callback(hObject, eventdata, handles)
handles.dao.executeMsgTimeout = sscanf(get(hObject,'String'),'%d');



function systemDescription_Callback(hObject, eventdata, handles)
handles.dao.systemDescription = get(hObject,'String');



function vampInterval_Callback(hObject, eventdata, handles)
handles.dao.vampInterval = sscanf(get(hObject,'String'),'%d');
