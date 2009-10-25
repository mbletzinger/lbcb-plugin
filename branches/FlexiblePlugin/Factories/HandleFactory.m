classdef HandleFactory <  handle
    properties
        % MDL instances
        mdlLbcb = {};
        
        % Limit instances
        cl = []; % CommandLimits object
        st = cell(2,1); % StepTolerances objects
        il = []; % IncrementLimits object
        
        
        % Configuration Instance
        cfg = [];
        
        % Corrections
        ed = cell(2,1);
        dd = [];
        
        % Simulation States and Executors
        omStates = cell(5,1);
        simStates = cell(3,1);
        
        %Display update instance
        gui = [];
        
        %Step Data
        dat = [];
        
        %Step Data Factory
        sdf = [];
        
        % Input File Loader
        inF = [];
        
        %Fake OM classes
        
        fakeGcp = [];
      
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
        function me = HandleFactory(handle,cfg)
            
            me.cfg = cfg;
            
            me.mdlLbcb = MdlLbcb(me.cfg);
            me.omStates{1} = OpenCloseOm;
            me.omStates{2} = ProposeExecuteOm;
            me.omStates{3} = GetControlPointsOm;
            me.omStates{4} = NextStep;
            me.omStates{5} = ProcessResponse;
            
            me.simStates{1} = ConnectStates;
            me.simStates{2} = StepStates;
            me.simStates{3} = TargetStates;

            lc = LimitChecks;
            me.il = IncrementLimits(me.cfg);
            me.cl = CommandLimits(me.cfg);
            lc.cl = me.cl;
            lc.il = me.il;
            me.gui = LbcbPluginResults(handle,cfg);
            
            
            me.ed{1} = ElasticDeformation(cfg,0);
            me.ed{2} = ElasticDeformation(cfg,1);
            me.dd = DerivedDof;
            me.st{1} = StepTolerances(me.cfg,1);
            me.st{2} = StepTolerances(me.cfg,0);
            me.dat = SimSharedData;
            me.sdf = StepDataFactory;
            me.sdf.cfg = me.cfg;
            me.sdf.mdlLbcb = me.mdlLbcb;
            me.inF = InputFile(me.sdf);

            me.omStates{4}.lc = lc;
            me.omStates{4}.st = me.st;

            for c =1:length(me.omStates)
                me.omStates{c}.cfg = cfg;
                me.omStates{c}.dd = me.dd;
                me.omStates{c}.ed = me.ed;
                me.omStates{c}.gui = me.gui;                
                me.omStates{c}.dat = me.dat;
                me.omStates{c}.sdf = me.sdf;
                me.omStates{c}.mdlLbcb = me.mdlLbcb;
                
            end
            me.omStates{1}.hndlfact = me;
            
            me.fakeGcp = GetControlPointsFake(me.cfg);
            
            for c =1:length(me.simStates)
                me.simStates{c}.cfg = cfg;
                me.simStates{c}.gui = me.gui;
                me.simStates{c}.ocOm = me.ocOm;
                me.simStates{c}.dat = me.dat;
            end
            me.simStates{2}.fakeGcp = me.fakeGcp;
            me.simStates{2}.nxtStep = me.nxtStep;
            me.simStates{2}.peOm = me.peOm;
            me.simStates{2}.gcpOm = me.gcpOm;
            me.simStates{2}.pResp = me.pResp;
            
        end
        function setGuiHandle(me, handle)
            me.gui = LbcbPluginResults(handle,me.cfg);
            for c =1:length(me.omStates)
                me.omStates{c}.gui = me.gui;                                
            end
            for c =1:length(me.simStates)
                me.simStates{c}.gui = me.gui;
            end
        end
        
        function c = get.ocOm(me)
            c= me.omStates{1};
        end
        function c = get.peOm(me)
            c= me.omStates{2};
        end
        function c = get.gcpOm(me)
            c= me.omStates{3};
        end
        function c = get.nxtStep(me)
            c= me.omStates{4};
        end
        function c = get.pResp(me)
            c= me.omStates{5};
        end
        function c = get.cnEx(me)
            c= me.simStates{1};
        end
        function c = get.stpEx(me)
            c= me.simStates{2};
        end
        function c = get.tgtEx(me)
            c= me.simStates{3};
        end
   end
end