classdef LbcbPluginActions < handle
    properties
        simTimer = [];
        comTimer = [];
        csimcorTimer = [];
        ctriggerTimer = [];
        vampTimer = [];
        simTimerCnt = [];
        comTimerCnt = [];
        csimcorTimerCnt;
        ctriggerTimerCnt;
        vampTimerCnt;
        hfact = [];
        currentSimExecute = StateEnum({...
            'RUN SIMULATION',...
            'DONE'...
            });
        connectOmAction = StateEnum({...
            'OPEN OM CONNECTION',...
            'CLOSE OM CONNECTION',...
            'DONE'...
            });
        
        connectSimCorAction = StateEnum({...
            'OPEN SIMCOR CONNECTION',...
            'CLOSE SIMCOR CONNECTION'...
            'DONE'...
            });
        startTriggeringAction = StateEnum({...
            'START TRIGGERING',...
            'STOP TRIGGERING',...
            'DONE'...
            });
        log = Logger('LbcbPluginActions');
        startStep
        prevExecute
        ocSimCor
        ocOm
        shuttingDown
        
    end
    methods
        function me  = LbcbPluginActions(handles,hfact)
            if isempty(javaclasspath('-dynamic'))
                javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-1.0.1-SNAPSHOT.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary'));
            end
            % Default configuration found in lbcb_plugin.properties
            handles.log = me.log;
            handles.actions = me;
            Logger.setMsgLevel(handles.Messages);
            if isempty(hfact)
                cfg = Configuration;
                cfg.load();
                me.hfact = HandleFactory(handles,cfg);
            else
                me.hfact = hfact;
                me.hfact.setGuiHandle(handles);
            end
            me.hfact.gui.initialize();
            lcfg = LogLevelsDao(me.hfact.cfg);
            Logger.setCmdLevel(lcfg.cmdLevel);
            Logger.setMsgLevel(lcfg.msgLevel);
            % set up execute timers
            me.simTimerCnt = 0;
            me.comTimerCnt = 0;
            me.csimcorTimerCnt = 0;
            me.ctriggerTimerCnt = 0;
            me.vampTimerCnt = 0;
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
            me.simTimer.TimerFcn = { 'LbcbPluginActions.executeSim', me };
            me.comTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','ConnectOmTimer');
            me.comTimer.TimerFcn = { 'LbcbPluginActions.connectOm', me };
            me.csimcorTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','ConnectSimCorTimer');
            me.csimcorTimer.TimerFcn = { 'LbcbPluginActions.connectSimCor', me };
            me.ctriggerTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','StartTriggerTimer');
            me.ctriggerTimer.TimerFcn = { 'LbcbPluginActions.startTriggering', me };
            me.vampTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','StartTriggerTimer');
            me.vampTimer.TimerFcn = { 'LbcbPluginActions.vampCheck', me };
            me.currentSimExecute.setState('DONE');
            me.connectSimCorAction.setState('DONE');
            me.connectOmAction.setState('DONE');
            me.startStep = 1;
            me.shuttingDown = false;
        end
        processRunHold(me,on)
        processConnectOm(me,on)
        processConnectSimCor(me,on)
        processTriggering(me,on)
        processVamping(me,on)
        selectInputFile(me,on)
        processAutoAccept(me,on)
        processAccept(me,on)
        processEditTarget(me)
        processArchiveOnOff(me,on)
        setCommandLimit(me,dof,lbcb,isLower,str);
        setIncrementLimit(me,dof,lbcb,str);
        setStepTolerance(me,dof,lbcb,str);
        setStartStep(me,str)
        setInputFile(me,infile)
        setLoggerLevels(me)
        shutdown(me)
        startSimulation(me)
        processConfig(me,action)
    end
    methods (Static)
        executeSim(obj, event, me)
        connectOm(obj, event, me)
        connectSimCor(obj, event, me)
        startTriggering(obj, event, me)
        vampCheck(obj, event, me)
    end
end