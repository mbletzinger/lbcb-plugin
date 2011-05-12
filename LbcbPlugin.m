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

% Last Modified by GUIDE v2.5 11-May-2011 21:38:55

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
hfact = {};
handles.notimer = 0;

if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        label = lower(varargin{index});
        switch label
            case 'hfact'
                hfact = varargin{index+1};
            case 'notimer'
                handles.notimer = varargin{index+1};
            otherwise
                str= sprintf('%s not recognized',label);
                disp(str);
        end
    end
end

actions = LbcbPluginActions(handles,hfact);
actions.processArchiveOnOff('on');
ddisp = actions.hfact.ddisp;
log = Logger('LbcbPlugin');
setappdata(hObject,'actions',actions);
setappdata(hObject,'ddisp',ddisp);
setappdata(hObject,'log',log);
% Update handles structure
guidata(hObject, handles);
% h = handles

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
actions = getappdata(getLp(hObject),'actions');
if handles.notimer
    % Used for debugging the software
    disp('no timer execution');
    if actions.currentSimExecute.isState('DONE')
        actions.startSimulation();
    end
    LbcbPluginActions.executeSim([],[],actions);
else
    actions.processRunHold(get(hObject,'Value'));
end

% --- Executes on button press in Connect2Om.
function Connect2Om_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
actions = getappdata(getLp(hObject),'actions');
log = getappdata(getLp(hObject),'log');
if val == false
    if get(handles.RunHold, 'Value')
        log.error(dbstack,'Need to stop the Simulation before disconnecting');
        set(hObject,'Value',true); %#ok<UNRCH>
        return;
    end
end
actions.processConnectOm(val);


% --- Executes on button press in ManualInput.
function ManualInput_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processEditTarget();

% --- Executes on button press in StartTriggering.
function StartTriggering_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
actions = getappdata(getLp(hObject),'actions');
actions.processTriggering(val);

function DxL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(1,1,1,get(hObject,'String'));


function DxU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(1,1,0,get(hObject,'String'));


function DyL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(2,1,1,get(hObject,'String'));

function DyU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(2,1,0,get(hObject,'String'));

function DzL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(3,1,1,get(hObject,'String'));

function DzU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(3,1,0,get(hObject,'String'));

function RxL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(4,1,1,get(hObject,'String'));

function RxU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(4,1,0,get(hObject,'String'));

function RyL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(5,1,1,get(hObject,'String'));

function RyU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(5,1,0,get(hObject,'String'));

function RzL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(6,1,1,get(hObject,'String'));

function RzU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(6,1,0,get(hObject,'String'));

function DxL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(1,2,1,get(hObject,'String'));

function DxU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(1,2,0,get(hObject,'String'));

function DyL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(2,2,1,get(hObject,'String'));

function DyU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(2,2,0,get(hObject,'String'));

function DzL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(3,2,1,get(hObject,'String'));

function DzU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(3,2,0,get(hObject,'String'));

function RxL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(4,2,1,get(hObject,'String'));

function RxU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(4,2,0,get(hObject,'String'));

function RyL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(5,2,1,get(hObject,'String'));

function RyU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(5,2,0,get(hObject,'String'));

function RzL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(6,2,1,get(hObject,'String'));

function RzU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(6,2,0,get(hObject,'String'));

function FxL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(7,1,1,get(hObject,'String'));

function FxU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(7,1,0,get(hObject,'String'));

function FyL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(8,1,1,get(hObject,'String'));

function FyU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(8,1,0,get(hObject,'String'));

function FzL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(9,1,1,get(hObject,'String'));

function FzU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(9,1,0,get(hObject,'String'));

function MxL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(10,1,1,get(hObject,'String'));

function MxU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(10,1,0,get(hObject,'String'));

function MyL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(11,1,1,get(hObject,'String'));

function MyU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(11,1,0,get(hObject,'String'));

function MzL1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(12,1,1,get(hObject,'String'));

function MzU1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(12,1,0,get(hObject,'String'));

function FxL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(7,2,1,get(hObject,'String'));

function FxU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(7,2,0,get(hObject,'String'));

function FyL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(8,2,1,get(hObject,'String'));

function FyU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(8,2,0,get(hObject,'String'));

function FzL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(9,2,1,get(hObject,'String'));

function FzU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(9,2,0,get(hObject,'String'));

function MxL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(10,2,1,get(hObject,'String'));

function MxU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(10,2,0,get(hObject,'String'));

function MyL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(11,2,1,get(hObject,'String'));

function MyU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(11,2,0,get(hObject,'String'));

function MzL2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(12,2,1,get(hObject,'String'));

function MzU2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setCommandLimit(12,2,0,get(hObject,'String'));

function DxT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(1,1,get(hObject,'String'));

function DyT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(2,1,get(hObject,'String'));

function DzT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(3,1,get(hObject,'String'));

function RxT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(4,1,get(hObject,'String'));

function RyT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(5,1,get(hObject,'String'));

function RzT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(6,1,get(hObject,'String'));

function DxT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(1,2,get(hObject,'String'));

function DyT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(2,2,get(hObject,'String'));

function DzT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(3,2,get(hObject,'String'));

function RxT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(4,2,get(hObject,'String'));

function RyT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(5,2,get(hObject,'String'));

function RzT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(6,2,get(hObject,'String'));

function FxT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(7,1,get(hObject,'String'));

function FyT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(8,1,get(hObject,'String'));

function FzT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(9,1,get(hObject,'String'));

function MxT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(10,1,get(hObject,'String'));

function MyT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(11,1,get(hObject,'String'));

function MzT1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(12,1,get(hObject,'String'));

function FxT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(7,2,get(hObject,'String'));

function FyT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(8,2,get(hObject,'String'));

function FzT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(9,2,get(hObject,'String'));

function MxT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(10,2,get(hObject,'String'));

function MyT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(11,2,get(hObject,'String'));

function MzT2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStepTolerance(12,2,get(hObject,'String'));

function DxI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(1,1,get(hObject,'String'));

function DyI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(2,1,get(hObject,'String'));

function DzI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(3,1,get(hObject,'String'));

function RxI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(4,1,get(hObject,'String'));

function RyI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(5,1,get(hObject,'String'));

function RzI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(6,1,get(hObject,'String'));

function DxI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(1,2,get(hObject,'String'));

function DyI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(2,2,get(hObject,'String'));

function DzI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(3,2,get(hObject,'String'));

function RxI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(4,2,get(hObject,'String'));

function RyI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(5,2,get(hObject,'String'));

function RzI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(6,2,get(hObject,'String'));

function FxI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(7,1,get(hObject,'String'));

function FyI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(8,1,get(hObject,'String'));

function FzI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(9,1,get(hObject,'String'));

function MxI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(10,1,get(hObject,'String'));

function MyI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(11,1,get(hObject,'String'));

function MzI1_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(12,1,get(hObject,'String'));

function FxI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(7,2,get(hObject,'String'));

function FyI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(8,2,get(hObject,'String'));

function FzI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(9,2,get(hObject,'String'));

function MxI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(10,2,get(hObject,'String'));

function MyI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(11,2,get(hObject,'String'));

function MzI2_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setIncrementLimit(12,2,get(hObject,'String'));

% --------------------------------------------------------------------
function NetworkConfiguration_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
NetworkConfig('cfg',actions.hfact.cfg);

% --------------------------------------------------------------------
function OmConfiguration_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
OmConfig('cfg',actions.hfact.cfg);

% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processConfig('LOAD');

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processConfig('SAVE');

% --------------------------------------------------------------------
function Import_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processConfig('IMPORT');

% --------------------------------------------------------------------
function Export_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processConfig('EXPORT');

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.LbcbPlugin);


% --- Executes on button press in InputFile.
function InputFile_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setInputFile({});


% --------------------------------------------------------------------
function LoggingLevels_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
LoggerLevels('cfg',actions.hfact.cfg);
actions.setLoggerLevels();


% --- Executes on button press in StartSimCor.
function StartSimCor_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processConnectSimCor(get(hObject,'Value'));


% --- Executes during object deletion, before destroying properties.
function LbcbPlugin_DeleteFcn(hObject, eventdata, handles)
actions = getappdata(hObject,'actions');
ddisp = getappdata(hObject,'ddisp');
disp('Shutting Down');
if isempty(actions) == false
    actions.shutdown();
end
if isempty(ddisp) == false
    ddisp.closeAll();
end


% --------------------------------------------------------------------
function TotalFxVsLbcb1Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('TotalFxVsLbcb1Dx')
    ddisp.closeDisplay('TotalFxVsLbcb1Dx');
else
    ddisp.openDisplay('TotalFxVsLbcb1Dx');
end


% --------------------------------------------------------------------
function TotalFxVsLbcb2Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('TotalFxVsLbcb2Dx')
    ddisp.closeDisplay('TotalFxVsLbcb2Dx');
else
    ddisp.openDisplay('TotalFxVsLbcb2Dx');
end

% --- Executes on button press in l1commandtable.
function AutoAccept_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processAutoAccept(get(hObject,'Value'));


% --- Executes on button press in Accept.
function Accept_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processAccept(get(hObject,'Value'));

% --- Executes on button press in editCommand.
function editCommand_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.processEditTarget();


function startStep_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.setStartStep(get(hObject,'String'));


% --------------------------------------------------------------------
function StepConfig_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
StepConfig('cfg',actions.hfact.cfg);

% --------------------------------------------------------------------
function TargetConfig_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
TargetConfig('cfg',actions.hfact.cfg);


% --------------------------------------------------------------------
function CorrectionSettings_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
CorrectionSettingsConfig('cfg',actions.hfact.cfg);

% --------------------------------------------------------------------
function TotalMyVsLbcb1Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('TotalMyVsLbcb1Dx')
    ddisp.closeDisplay('TotalMyVsLbcb1Dx');
else
    ddisp.openDisplay('TotalMyVsLbcb1Dx');
end


% --------------------------------------------------------------------
function TotalMyVsLbcb2Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('TotalMyVsLbcb2Dx')
    ddisp.closeDisplay('TotalMyVsLbcb2Dx');
else
    ddisp.openDisplay('TotalMyVsLbcb2Dx');
end


% --------------------------------------------------------------------
function MyVsLbcb1Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyVsLbcb1Dx')
    ddisp.closeDisplay('MyVsLbcb1Dx');
else
    ddisp.openDisplay('MyVsLbcb1Dx');
end


% --------------------------------------------------------------------
function MyVsLbcb2Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyVsLbcb2Dx')
    ddisp.closeDisplay('MyVsLbcb2Dx');
else
    ddisp.openDisplay('MyVsLbcb2Dx');
end


% --------------------------------------------------------------------
function RyVsLbcb1Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('RyVsLbcb1Dx')
    ddisp.closeDisplay('RyVsLbcb1Dx');
else
    ddisp.openDisplay('RyVsLbcb1Dx');
end



% --------------------------------------------------------------------
function RyVsLbcb2Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('RyVsLbcb2Dx')
    ddisp.closeDisplay('RyVsLbcb2Dx');
else
    ddisp.openDisplay('RyVsLbcb2Dx');
end


% --- Executes on button press in vamping.
function vamping_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
actions = getappdata(getLp(hObject),'actions');
actions.processVamping(val);


% --------------------------------------------------------------------
function ArchiveOnOff_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
if strcmp(get(hObject, 'Checked'),'on')
    %     actions.processArchiveOnOff(0);
    set(hObject,'Checked','off');
else
    %     actions.processArchiveOnOff(1);
    set(hObject,'Checked','on');
end
actions.processArchiveOnOff(get(hObject,'Checked'));

% --------------------------------------------------------------------
function FxVsLbcb1Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FxVsLbcb1Dx')
    ddisp.closeDisplay('FxVsLbcb1Dx');
else
    ddisp.openDisplay('FxVsLbcb1Dx');
end

% --------------------------------------------------------------------
function FxVsLbcb2Dx_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FxVsLbcb2Dx')
    ddisp.closeDisplay('FxVsLbcb2Dx');
else
    ddisp.openDisplay('FxVsLbcb2Dx');
end

% --------------------------------------------------------------------
function DxStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DxStepL1')
    ddisp.closeDisplay('DxStepL1');
else
    ddisp.openDisplay('DxStepL1');
end


% --------------------------------------------------------------------
function RyStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('RyStepL1')
    ddisp.closeDisplay('RyStepL1');
else
    ddisp.openDisplay('RyStepL1');
end

% --------------------------------------------------------------------
function DzStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DzStepL1')
    ddisp.closeDisplay('DzStepL1');
else
    ddisp.openDisplay('DzStepL1');
end

% --------------------------------------------------------------------
function FzStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FzStepL1')
    ddisp.closeDisplay('FzStepL1');
else
    ddisp.openDisplay('FzStepL1');
end

% --------------------------------------------------------------------
function DxStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DxStepL2')
    ddisp.closeDisplay('DxStepL2');
else
    ddisp.openDisplay('DxStepL2');
end


% --------------------------------------------------------------------
function RyStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('RyStepL2')
    ddisp.closeDisplay('RyStepL2');
else
    ddisp.openDisplay('RyStepL2');
end

% --------------------------------------------------------------------
function DzStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DzStepL2')
    ddisp.closeDisplay('DzStepL2');
else
    ddisp.openDisplay('DzStepL2');
end

% --------------------------------------------------------------------
function FzStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FzStepL2')
    ddisp.closeDisplay('FzStepL2');
else
    ddisp.openDisplay('FzStepL2');
end

% --------------------------------------------------------------------
function L1ResponseTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L1ResponseTable')
    ddisp.closeDisplay('L1ResponseTable');
else
    ddisp.openDisplay('L1ResponseTable');
end


% --------------------------------------------------------------------
function L1CommandTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L1CommandTable')
    ddisp.closeDisplay('L1CommandTable');
else
    ddisp.openDisplay('L1CommandTable');
end


% --------------------------------------------------------------------
function L1SubstepsTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L1SubstepsTable')
    ddisp.closeDisplay('L1SubstepsTable');
else
    ddisp.openDisplay('L1SubstepsTable');
end


% --------------------------------------------------------------------
function DerivedTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DerivedTable')
    ddisp.closeDisplay('DerivedTable');
else
    ddisp.openDisplay('DerivedTable');
end

% --------------------------------------------------------------------
function L1ReadingsTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L1ReadingsTable')
    ddisp.closeDisplay('L1ReadingsTable');
else
    ddisp.openDisplay('L1ReadingsTable');
end


% --------------------------------------------------------------------
function L2ResponseTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L2ResponseTable')
    ddisp.closeDisplay('L2ResponseTable');
else
    ddisp.openDisplay('L2ResponseTable');
end


% --------------------------------------------------------------------
function L2CommandTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L2CommandTable')
    ddisp.closeDisplay('L2CommandTable');
else
    ddisp.openDisplay('L2CommandTable');
end


% --------------------------------------------------------------------
function L2SubstepsTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L2SubstepsTable')
    ddisp.closeDisplay('L2SubstepsTable');
else
    ddisp.openDisplay('L2SubstepsTable');
end

% --------------------------------------------------------------------
function L2ReadingsTable_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('L2ReadingsTable')
    ddisp.closeDisplay('L2ReadingsTable');
else
    ddisp.openDisplay('L2ReadingsTable');
end
function lp = getLp(hObject)
lp = hObject;
tag = get(lp,'Tag');
while strcmp(tag,'LbcbPlugin') == false
    lp = get(lp,'Parent');
    tag = get(lp,'Tag');
end


function MyStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyStepL1')
    ddisp.closeDisplay('MyStepL1');
else
    ddisp.openDisplay('MyStepL1');
end


function MyStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyStepL2')
    ddisp.closeDisplay('MyStepL2');
else
    ddisp.openDisplay('MyStepL2');
end


function DxVsMyBottom_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('DxVsMyBottom')
    ddisp.closeDisplay('DxVsMyBottom');
else
    ddisp.openDisplay('DxVsMyBottom');
end


function CumulativeMoment_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('CumulativeMoment')
    ddisp.closeDisplay('CumulativeMoment');
else
    ddisp.openDisplay('CumulativeMoment');
end


function MyTopVsMyBottom_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyTopVsMyBottom')
    ddisp.closeDisplay('MyTopVsMyBottom');
else
    ddisp.openDisplay('MyTopVsMyBottom');
end


function TopBottomMoment_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('TopBottomMoment')
    ddisp.closeDisplay('TopBottomMoment');
else
    ddisp.openDisplay('TopBottomMoment');
end


function FxStepL1_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FxStepL1')
    ddisp.closeDisplay('FxStepL1');
else
    ddisp.openDisplay('FxStepL1');
end


function FxStepL2_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('FxStepL2')
    ddisp.closeDisplay('FxStepL2');
else
    ddisp.openDisplay('FxStepL2');
end


function AlertList_Callback(hObject, eventdata, handles)


function AlertList_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ToleranceTable_CellEditCallback(hObject, eventdata, handles)


function LbcbChoice_Callback(hObject, eventdata, handles)


function LbcbChoice_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Limits_Callback(hObject, eventdata, handles)
