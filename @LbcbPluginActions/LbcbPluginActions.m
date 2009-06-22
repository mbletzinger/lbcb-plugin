classdef LbcbPluginActions < handle
    properties
        handles = [];
        cfg = [];
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
        
        cl = [];
        st = [];
        il = [];
        
        oc = OpenClose;
        peOm = ProposeExecuteOm;
        gcpOm = GetControlPointsOm;
        nxtTgt = NextTarget;
%        sndTrig = SendTrigger;
        
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
        simTimer = {};
        
    end
    methods
        function me  = LbcbPluginActions(handles)
            me.handles = handles;
            set(me.handles.Rev, 'String','$LastChangedDate: 2009-06-10 18:15:21 -0500 (Wed, 10 Jun 2009) $');
            javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
            javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
            javaaddpath(fullfile(pwd,'JavaLibrary'));
            
            me.cfg = Configuration;
            me.cfg.load();
            me.handles.log = me.log;
            me.currentAction.setState('READY');
            me.simTimer = timer('Period',1, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
            me.simTimer.TimerFcn = 'me.execute';
        end
        openCloseConnection(me, connection,closeIt)
        runInputFile(me,inFile)
        initialize(me)
        execute(me)
        colorCommandLimits(me)
        colorIncrementLimits(me)
        updateCommandCurrentValue(me)
        updateToleranceCurrentValue(me)
        updateIncrementCurrentValue(me)
        colorStepTolerances(me)
        shutdown(me)
        setRunButton(me,hndl,value)
        setCommandLimit(me,dof,lbcb,isLower,str);
        setInputFile(me)
        setLoggerLevels(me)
    end
    methods (Static)
        colorText(hndl,fault)
    end
end