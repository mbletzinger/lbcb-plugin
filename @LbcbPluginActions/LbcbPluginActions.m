classdef LbcbPluginActions < handle
    properties
        simTimer = [];
        hfact = [];
        currentExecute = StateEnum({...
            'OPEN CLOSE CONNECTION',...
            'RUN SIMULATION',...
            'READY'...
            });
        log = Logger('LbcbPluginActions');
        startStep
        prevExecute
    end
    methods
        function me  = LbcbPluginActions(handles,hfact)
            if isempty(javaclasspath('-dynamic'))
                javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
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
            % set up execute timer
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
            me.simTimer.TimerFcn = { 'LbcbPluginActions.execute', me };
            me.currentExecute.setState('READY');
            me.startStep = 1;
        end
        processRunHold(me,on)
        processConnectOm(me,on)
        processTriggering(me,on)
        processConnectSimCor(me,on)
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
        execute(obj, event, me)
    end
end