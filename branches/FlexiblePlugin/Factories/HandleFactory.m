classdef HandleFactory <  handle
    properties
        % MDL instances
        mdlLbcb = {};
        
        % Limit instances
        cl = []; % CommandLimits object
        st = []; % StepTolerances object
        il = []; % IncrementLimits object
        
        
        % Configuration Instance
        cfg = [];
        
        % Corrections
        ed = cell(2,1);
        dd = [];
        
        % Simulation States and Executors
        simStates = cell(5,1);
        simExec = cell(3,1);
        
        %Display update instance
        gui = [];
        
        %Step Data
        dat = [];
        
        %Step Data Factory
        sdf = [];
        
        % Input File Loader
        inF = [];
      
    end
    properties (Dependent = true)
        % Simulation states
        ocOm;
        peOm;
        gcpOm;
        nxtStep;
        pResp;
        
        %Simulation Execution
        cnEx;
        stpEx;
        tgtEx;
        
    end
    methods
        function me = HandleFactory(handles,cfg)
            
            me.cfg = cfg;
            
            me.mdlLbcb = MdlLbcb(me.cfg);
            me.simStates{1} = OpenCloseOm;
            me.simStates{2} = ProposeExecuteOm;
            me.simStates{3} = GetControlPointsOm;
            me.simStates{4} = NextStep;
            me.simStates{5} = ProcessResponse;
            
            me.simExec{1} = ConnectionExecute;
            me.simExec{2} = StepExecute;
            me.simExec{3} = TargetExecute;

            lc = LimitChecks;
            me.il = IncrementLimits(me.cfg);
            me.cl = CommandLimits(me.cfg);
            lc.cmd = me.cl;
            lc.inc = me.il;
            me.gui = LbcbPluginResults(handles,cfg);
            
            
            me.ed{1} = ElasticDeformation(cfg,0);
            me.ed{2} = ElasticDeformation(cfg,1);
            me.dd = DerivedDof;
            me.st = StepTolerances(me.cfg);
            me.dat = SimSharedData;
            me.sdf = StepDataFactory;
            me.sdf.cfg = me.cfg;
            me.sdf.mdlLbcb = me.mdlLbcb;
            me.inF = InputFile(me.sdf);

            me.simStates{4}.lc = lc;
            me.simStates{4}.st = me.st;

            for c =1:length(me.simStates)
                me.simStates{c}.cfg = cfg;
                me.simStates{c}.dd = me.dd;
                me.simStates{c}.ed = me.ed;
                me.simStates{c}.gui = me.gui;                
                me.simStates{c}.dat = me.dat;
                me.simStates{c}.sdf = me.sdf;
                me.simStates{c}.mdlLbcb = me.mdlLbcb;
                
            end
            for c =1:length(me.simExec)
                me.simExec{c}.cfg = cfg;
                me.simExec{c}.gui = me.gui;
            end
            me.simStates{1}.hndlfact = me;
            
        end
        
        function c = get.ocOm(me)
            c= me.simStates{1};
        end
        function c = get.peOm(me)
            c= me.simStates{2};
        end
        function c = get.gcpOm(me)
            c= me.simStates{3};
        end
        function c = get.nxtStep(me)
            c= me.simStates{4};
        end
        function c = get.pResp(me)
            c= me.simStates{5};
        end
        function c = get.cnEx(me)
            c= me.simExec{1};
        end
        function c = get.stpEx(me)
            c= me.simExec{2};
        end
        function c = get.tgtEx(me)
            c= me.simExec{3};
        end
   end
end