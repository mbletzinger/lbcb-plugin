classdef LbcbPluginActions < handle
    properties
        simTimer = [];
        gui = [];
        hndlF = [];
        currentExecute = StateEnum({...
            'OPEN OM CONNECTION',...
            'CLOSE OM CONNECTION',...
            'OPEN SIMCOR CONNECTION',...
            'CLOSE SIMCOR CONNECTION',...
            'OPEN TRIGGER CONNECTION',...
            'CLOSE TRIGGER CONNECTION',...
            'RUN SIMULATION',...
            'EXIT APPLICATION',...
            'READY'...
            });
    end
    methods
        function me  = LbcbPluginActions(handles,cfg)
            if isempty(javaclasspath('-dynamic'))
                javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
                javaaddpath(fullfile(pwd,'JavaLibrary'));
            end
            % Default configuration found in lbcb_plugin.properties
            if isempty(cfg)
                cfg = Configuration;
                cfg.load();
            end
            me.gui = LbcbPluginResults(handle,cfg);
            me.hndlF = HandleFactory(cfg);
            handles.log = me.log;
            handles.actions = me;
            % set up execute timer
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
            me.simTimer.TimerFcn = { 'LbcbPluginActions.execute', me };
            me.currentExecute.setState('READY');
        end
        processRunHold(me,on)
        processConnectOm(me,on)
        processTriggering(me,on)
        processConnectSimCor(me,on)
        selectInputFile(me,on)
        processAutoAccept(me,on)
        processAccept(me,on)
        processDecline(me,on)
        setCommandLimit(me,dof,lbcb,isLower,str);
        setIncrementLimit(me,dof,lbcb,str);
        setStepTolerance(me,dof,lbcb,str);
        setInputFile(me,infile)
        setLoggerLevels(me)
        shutdown(me)
    end
    methods (Static)
        execute(obj, event, me)
    end
end