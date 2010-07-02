classdef HandleFactory <  handle
    properties
        % MDL instances
        mdlLbcb = {};
        mdlUiSimCor = {};
        mdlBroadcast = {};
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
        simCorStates = cell(2,1);
        brdcstStates = cell(3,1);
        
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
        
        %Archiver
        
        arch = [];
        
        % Display Windows
        ddisp = []
        
        
    end
    properties (Dependent = true)
        % Simulation states
        ocOm;
        peOm;
        gcpOm;
        nxtStep;
        pResp;
        
        %Simulation Execution
        stpEx;
        tgtEx;
        prcsTgt;
        
        % UiSimCor States
        ocSimCor
        tgtRsp
        
        % Broadcast Trigger States
        ssBrdcst
        brdcstRsp
        vmpChk
        
    end
    methods
        function me = HandleFactory(handle,cfg)
            
            me.cfg = cfg;
            cdp = ConfigDaoProvider(cfg);
            
            me.mdlLbcb = MdlLbcb(me.cfg);
            me.omStates{1} = OpenCloseOm;
            me.omStates{2} = ProposeExecuteOm;
            me.omStates{3} = GetControlPointsOm;
            me.omStates{4} = NextStep;
            me.omStates{5} = ProcessResponse;
            
            me.simStates{1} = StepStates;
            me.simStates{2} = TargetStates;
            me.simStates{3} = ProcessTarget;
            
            me.mdlUiSimCor = MdlUiSimCor(me.cfg);
            me.simCorStates{1} = OpenCloseUiSimCor;
            me.simCorStates{2} = TargetResponse;
            
            me.mdlBroadcast = MdlBroadcast(me.cfg);
            me.brdcstStates{1} = StartStopBroadcaster;
            me.brdcstStates{2} = BroadcastResponses;
            me.brdcstStates{3} = VampCheck;
            
            lc = LimitChecks;
            me.il = IncrementLimits(me.cfg);
            me.cl = CommandLimits(me.cfg);
            lc.cl = me.cl;
            lc.il = me.il;
            
            me.gui = LbcbPluginResults(handle,me);
            if isempty(handle)
                bsimst = ButtonManagementGroup([]);
                me.gui.bsimst = bsimst;
                bstpst = ButtonManagementGroup([]);
                me.gui.bstpst = bstpst;
                bsrc = ButtonManagementGroup([]);
                me.gui.bsrc = bsrc;
            else
                me.fillButtons(handle)
            end
            DataDisplay.setMenuHandle(handle);
            
            me.ed{1} = ElasticDeformation(cdp,1);
            me.ed{2} = ElasticDeformation(cdp,0);
            me.dd = DerivedDof(cdp);
            me.st{1} = StepTolerances(me.cfg,1);
            me.st{2} = StepTolerances(me.cfg,0);
            
            me.sdf = StepDataFactory;
            me.sdf.cdp = cdp;
            me.sdf.mdlLbcb = me.mdlLbcb;
            me.sdf.mdlUiSimCor = me.mdlUiSimCor;
            me.inF = InputFile(me.sdf);
            
            me.dat = SimSharedData;
            me.dat.sdf = me.sdf;
            me.dat.cdp = cdp;
            me.arch = Archiver(cdp);
            
            me.omStates{4}.st = me.st;
            
            for c =1:length(me.omStates)
                me.omStates{c}.cdp = cdp;
                me.omStates{c}.dd = me.dd;
                me.omStates{c}.ed = me.ed;
                me.omStates{c}.gui = me.gui;
                me.omStates{c}.dat = me.dat;
                me.omStates{c}.sdf = me.sdf;
                me.omStates{c}.mdlLbcb = me.mdlLbcb;
                
            end
            
            me.fakeGcp = GetControlPointsFake(cdp);
            me.fakeGcp.dat = me.dat;
            me.ddisp = DataDisplay;
            me.ddisp.setCdp(cdp);
            dbgWin = DebugWindow;
            me.ddisp.dat = me.dat;
            me.ddisp.dbgWin = dbgWin;
            me.gui.ddisp = me.ddisp;
            me.mdlLbcb.dbgWin = dbgWin;
            me.mdlBroadcast.dbgWin = dbgWin;
            
            for c =1:length(me.simStates)
                me.simStates{c}.cdp = cdp;
                me.simStates{c}.gui = me.gui;
                me.simStates{c}.ocOm = me.ocOm;
                me.simStates{c}.dat = me.dat;
                me.simStates{c}.nxtStep = me.nxtStep;
                me.simStates{c}.sdf = me.sdf;
                me.simStates{c}.ddisp = me.ddisp;
            end
            me.stpEx.fakeGcp = me.fakeGcp;
            me.stpEx.peOm = me.peOm;
            me.stpEx.gcpOm = me.gcpOm;
            me.stpEx.pResp = me.pResp;
            me.stpEx.arch = me.arch;
            me.stpEx.brdcstRsp = me.brdcstRsp;
            
            me.tgtEx.stpEx = me.stpEx;
            me.tgtEx.prcsTgt = me.simStates{3};
            me.tgtEx.inF = me.inF;
            me.tgtEx.tgtRsp = me.tgtRsp;
            me.tgtEx.ocSimCor = me.ocSimCor;
            me.simStates{3}.lc = lc;
            
            dbgWin.stpEx = me.stpEx;
            dbgWin.tgtEx = me.tgtEx;
            dbgWin.prcsTgt = me.simStates{3};
            
            for c =1:length(me.simCorStates)
                me.simCorStates{c}.cdp = cdp;
                me.simCorStates{c}.gui = me.gui;
                me.simCorStates{c}.mdlUiSimCor = me.mdlUiSimCor;
                me.simCorStates{c}.dat = me.dat;
                me.simCorStates{c}.sdf = me.sdf;
            end
            
            for c =1:length(me.brdcstStates)
                me.brdcstStates{c}.cdp = cdp;
                me.brdcstStates{c}.gui = me.gui;
                me.brdcstStates{c}.mdlBroadcast = me.mdlBroadcast;
                me.brdcstStates{c}.dat = me.dat;
                me.brdcstStates{c}.sdf = me.sdf;
            end
            
        end
        function setGuiHandle(me, handle)
            me.gui = LbcbPluginResults(handle,me);
            me.fillButtons(handle)
            me.gui.ddisp = me.ddisp;
            for c =1:length(me.omStates)
                me.omStates{c}.gui = me.gui;
            end
            for c =1:length(me.simStates)
                me.simStates{c}.gui = me.gui;
            end
            for c =1:length(me.simCorStates)
                me.simCorStates{c}.gui = me.gui;
            end
            for c =1:length(me.brdcstStates)
                me.brdcstStates{c}.gui = me.gui;
            end
            DataDisplay.setMenuHandle(handle);
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
        function c = get.stpEx(me)
            c= me.simStates{1};
        end
        function c = get.tgtEx(me)
            c= me.simStates{2};
        end
        function c = get.prcsTgt(me)
            c= me.simStates{3};
        end
        function c = get.ocSimCor(me)
            c= me.simCorStates{1};
        end
        function c = get.tgtRsp(me)
            c= me.simCorStates{2};
        end
        function c = get.ssBrdcst(me)
            c= me.brdcstStates{1};
        end
        function c = get.brdcstRsp(me)
            c= me.brdcstStates{2};
        end
        function c = get.vmpChk(me)
            c= me.brdcstStates{3};
        end
        function fillButtons(me,handle)
            bsimst = ButtonGroupManagement(handle.simStatesPanel);
            bsimst.childHandles = {...
                handle.ipButton,...
                handle.wftButton,...
                handle.ptButton,...
                handle.esButton,...
                handle.strButton,...
                handle.dButton...
                };
            bsimst.init()
            me.gui.bsimst = bsimst;
            bstpst = ButtonGroupManagement(handle.stepStatesPanel);
            bstpst.childHandles = {...
                handle.nsButton,...
                handle.peButton,...
                handle.gcpButton,...
                handle.prButton,...
                handle.btButton,...
                handle.dButton...
                };
            bstpst.init()
            me.gui.bstpst = bstpst;
            bsrc = ButtonGroupManagement(handle.sourcePanel);
            bsrc.childHandles = {...
                handle.ifButton,...
                handle.scorButton,... 
                handle.nButton,...
                };
            bsrc.init()
            me.gui.bsrc = bsrc;
        end
    end
end