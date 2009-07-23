classdef LbcbPluginActions < handle
    properties
        handles = [];
        cfg = [];
        %text box handles 1 = LBCB1, 2 = LBCB 2
        commandLimitsHandles1 = {};
        commandLimitsHandles2 = {};
        commandTolerancesHandles1 = {};
        commandTolerancesHandles2 = {};
        incrementLimitsHandles1 = {};
        incrementLimitsHandles2 = {};
        
        commandCurrentValueHandles1 = {};
        commandCurrentValueHandles2 = {};
        toleranceCurrentValueHandles1 = {};
        toleranceCurrentValueHandles2 = {};
        incrementCurrentValueHandles1 = {};
        incrementCurrentValueHandles2 = {};
        stepHandles = cell(2,1);
        
        cl = []; % CommandLimits object
        st = []; % StepTolerances object
        il = []; % IncrementLimits object
        
        oc = OpenClose;
        peOm = ProposeExecuteOm;
        gcpOm = GetControlPointsOm;
        nxtTgt = NextTarget;
%        sndTrig = SendTrigger;

        dd = DataDisplay;
        
        log = Logger;
        currentAction = StateEnum({...
            'OPEN CONNECTION',...
            'CLOSE CONNECTION',...
            'NEXT TARGET',...
            'OM PROPOSE EXECUTE',...
            'OM GET CONTROL POINTS',...
            'CHECK LIMITS'...
            'READY'
            });
        fakeOm = 0; % flag indicating fake OM
        fakeGcp = {}; % object used to generate fake control points
        running = 0;
        simTimer = {}; % Timer which runs the execute function
        arch = {}  % Archiver instance 
        
    end
    methods
        function me  = LbcbPluginActions(handles,cfg)
            me.handles = handles;
            if isempty(javaclasspath('-dynamic'))
                javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary'));
            end
            % Default configuration found in lbcb_plugin.properties
            if isempty(cfg)
                me.cfg = Configuration;
                me.cfg.load();
            else
                %Used for software testing
                me.cfg = cfg;
            end
            me.handles.log = me.log;
            me.handles.actions = me;
            me.currentAction.setState('READY');
            % set up execute timer
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
            me.simTimer.TimerFcn = { 'LbcbPluginActions.execute', me };
        end
        openCloseConnection(me, connection,closeIt)
        runInputFile(me,inFile)
        initialize(me)
        updateCommandLimits(me)
        updateStepTolerances(me)
        updateSteps(me)
        shutdown(me)
        setRunButton(me,value)
        setCommandLimit(me,dof,lbcb,isLower,str);
        setIncrementLimit(me,dof,lbcb,str);
        setStepTolerance(me,dof,lbcb,str);
        setInputFile(me,infile)
        setLoggerLevels(me)
        startSimulation(me,notimer)
        toggleConnectOmButton(me)
        colorConnectionButton(me,connection)
        yes = errorsExist(me,connection)
    end
    methods (Static)
        colorFaultText(hndl,fault)
        colorToleranceText(hndl,fault)
        execute(obj, event, me)
        updateGui(me)
        setGui(ingui)
        setLimit(hndl,dof,used,limit)
    end
end