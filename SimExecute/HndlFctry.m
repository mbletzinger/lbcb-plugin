classdef HndlFctry <  handle
    properties
        % MDL instances
        mdlLbcb = {};
        
        % Limit instances
        cl = []; % CommandLimits object
        st = []; % StepTolerances object
        il = []; % IncrementLimits object
        
        % Simulation states
        ocOm = [];
        peOm = [];
        gcpOm = [];
        nxtStep = [];
        
        % Configuration Instance
        cfg = [];
        
        % Corrections
        ed = cell(2,1);
        dd = [];
    end
    methods
        function me = HndlFctry(cfg)
            
            me.cfg = cfg;
            
            
            me.ocOm = OpenCloseOm;
            me.peOm = ProposeExecuteOm;
            me.gcpOm = GetControlPointsOm;
            me.nxtStep = NextStep;
            
            me.ocOm.cfg = cfg;
            me.peOm.cfg = cfg;
            me.gcpOm.cfg = cfg;
            me.nxtStep.cfg = cfg;
            
            lc = LimitChecks;
            
            lc.cmd = me.cl;
            lc.inc = me.il;
            me.nxtStep.lc = lc;
            
            me.ed{1} = ElasticDeformation(cfg,0);
            me.ed{2} = ElasticDeformation(cfg,1);
            
            me.ocOm.ed = me.ed;
            me.peOm.ed = me.ed;
            me.gcpOm.ed = me.ed;
            me.nxtStep.ed = me.ed;
            
            me.dd = DerivedDof;
            me.ocOm.dd = me.dd;
            me.peOm.dd = me.dd;
            me.gcpOm.dd = me.dd;
            me.nxtStep.dd = me.dd;
            
            me.st = StepTolerances(me.cfg);
            me.nxtStep.st = me.st;
        end
        function mdl = createMdlLbcb(me)
            mdl = MdlLbcb(me.cfg);
            me.mdlLbcb = mdl;
            me.ocOm.mdlLbcb = me.mdlLbcb;
            me.peOm.mdlLbcb = me.mdlLbcb;
            me.gcpOm.mdlLbcb = me.mdlLbcb;
            me.nxtStep.mdlLbcb = me.mdlLbcb;
            StepData.setMdlLbcb(me.mdlLbcb);
            

        end
        function destroyMdlLbcb(me)
            me.mdlLbcb = [];
            me.ocOm.mdlLbcb = me.mdlLbcb;
            me.peOm.mdlLbcb = me.mdlLbcb;
            me.gcpOm.mdlLbcb = me.mdlLbcb;
            me.nxtStep.mdlLbcb = me.mdlLbcb;
        end
    end
end