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

% Last Modified by GUIDE v2.5 29-Jan-2012 14:27:17

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
delete(handles.LbcbPlugin);


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

function ToleranceTable_CellEditCallback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.tolerances.setCell(eventdata.Indices,eventdata.NewData);

function LbcbChoice_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
actions.tolerances.fill();

function CommandLimits_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
CommandLimitsConfig('step',actions.hfact.dat.nextStepData,...
    'limits',actions.hfact.cl); 


function IncrementLimits_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
IncrementLimitsConfig('cstep',actions.hfact.dat.nextStepData,...
    'pstep',actions.hfact.dat.curStepData,...
    'limits',actions.hfact.il);

function MessageArchive_Callback(hObject, eventdata, handles)
if strcmp(get(hObject, 'Checked'),'on')
    set(hObject,'Checked','off'); 
else
    set(hObject,'Checked','on');
end
Logger.setRecord(get(hObject,'Checked'));

% --------------------------------------------------------------------
function OutOfPlaneRotations_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('OutOfPlaneRotations')
    ddisp.closeDisplay('OutOfPlaneRotations');
else
    ddisp.openDisplay('OutOfPlaneRotations');
end


% --------------------------------------------------------------------
function OutOfPlaneTranslations_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('OutOfPlaneTranslations')
    ddisp.closeDisplay('OutOfPlaneTranslations');
else
    ddisp.openDisplay('OutOfPlaneTranslations');
end


% --------------------------------------------------------------------
function Forces_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('Forces')
    ddisp.closeDisplay('Forces');
else
    ddisp.openDisplay('Forces');
end


% --------------------------------------------------------------------
function Moments_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('Moments')
    ddisp.closeDisplay('Moments');
else
    ddisp.openDisplay('Moments');
end


% --------------------------------------------------------------------
function SensorInitialLength_Callback(hObject, eventdata, handles)
actions = getappdata(getLp(hObject),'actions');
OffsetsConfig('cfg',actions.hfact.cfg,'ocfg',actions.hfact.offstcfg,'fact',actions.hfact);


% --------------------------------------------------------------------
function MyCorrections_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('MyCorrections')
    ddisp.closeDisplay('MyCorrections');
else
    ddisp.openDisplay('MyCorrections');
end


% --------------------------------------------------------------------
function Eccentricities_Callback(hObject, eventdata, handles)
ddisp = getappdata(getLp(hObject),'ddisp');
if ddisp.isDisplaying('Moment2Shear')
    ddisp.closeDisplay('Moment2Shear');
else
    ddisp.openDisplay('Moment2Shear');
end
