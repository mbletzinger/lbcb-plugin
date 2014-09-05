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
        cdp = [];
        
        % Offset Settings
        
        offstcfg = [];
        
        % Corrections
        ed = cell(2,1);
        dxed = cell(2,1);
        dd = cell(4,1);
        corrections = [];
        
        % Simulation States and Executors
        omStates = cell(4,1);
        simStates = cell(2,1);
        simCorStates = cell(2,1);
        brdcstStates = cell(3,1);
        stpStates = cell(2,1);
        
        %Display update instance
        gui = [];
        
        %Step Data
        dat = [];
        
        %Step Data Factory
        sdf = [];
        
        % Input File Loader
        inF = [];
        
        %Archiver
        
        arch = [];
        
        % Display Windows
        ddisp = []
        
        % Test Statistics
        stats
        
        
    end
    properties (Dependent = true)
        % OM states
        ocOm;
        peOm;
        gcpOm;
        gipOm;
        
        % Step States
        nxtStep;
        pResp;
        acceptStp;
        
        %Simulation Execution
        stpEx;
        tgtEx;
        offstRfsh;
        
        % UiSimCor States
        ocSimCor
        tgtRsp
        
        % Broadcast Trigger States
        ssBrdcst
        brdcstRsp
        vmpChk
        
        cfg
        
    end
    methods
        function me = HandleFactory(handle,cfg,ofst)
            
            me.cdp = ConfigDaoProvider(cfg);
            me.offstcfg = ofst;
            
            me.sdf = StepDataFactory;
            me.sdf.cdp = me.cdp;
            me.sdf.offstcfg = ofst;

            me.dat = SimSharedData;
            me.dat.sdf = me.sdf;
            me.dat.cdp = me.cdp;
            
            me.mdlLbcb = MdlLbcb(me.cfg);
            me.sdf.mdlLbcb = me.mdlLbcb;

            me.omStates{1} = OpenCloseOm;
            me.omStates{2} = ProposeExecuteOm;
            me.omStates{3} = GetControlPointsOm;
            me.omStates{4} = GetInitialPosition;
            
            me.stpStates{1} = NextStep;
            me.stpStates{2} = ProcessResponse;
            me.stpStates{3} = ProcessTarget;
            
            me.simStates{1} = StepStates;
            me.simStates{2} = TargetStates;
            me.simStates{3} = OffsetsRefresh;
            
            me.mdlUiSimCor = MdlUiSimCor(me.cfg);
            me.sdf.mdlUiSimCor = me.mdlUiSimCor;

            me.simCorStates{1} = OpenCloseUiSimCor;
            me.simCorStates{2} = TargetResponse;
            
            me.mdlBroadcast = MdlBroadcast(me.cdp);
            me.brdcstStates{1} = StartStopBroadcaster;
            me.brdcstStates{2} = BroadcastResponses;
            me.brdcstStates{3} = VampCheck;
            
            lc = LimitChecks;
            me.il = IncrementLimits(me.cfg);
            me.cl = CommandLimits(me.cfg);
            lc.cl = me.cl;
            lc.il = me.il;
            me.stats = StepStats();

            me.inF = InputFile(me.sdf);
            me.inF.stats = me.stats;
            me.arch = Archiver(me.cdp);
            me.cfg.dat = me.dat;
            me.cfg.arch = me.arch;
            
            cfgH = org.nees.uiuc.simcor.matlab.HashTable();
            datH = org.nees.uiuc.simcor.matlab.HashTable();
            archH = org.nees.uiuc.simcor.matlab.HashTable();
            
            me.sdf.cv = CorrectionVariables(me.cdp);
            me.sdf.cv.cfgH = cfgH;
            me.sdf.cv.datH = datH;
            me.sdf.cv.archH = archH;

            for i = 1:2
                me.ed{i} = ElasticDeformation(me.cdp,(i == 1));
                me.dxed{i} = DxOnlyElasticDeformation(me.cdp,(i == 1));
                me.st{i} = StepTolerances(me.cfg,i == 1);
                me.ed{i}.cfgH = cfgH;
                me.ed{i}.datH = datH;
                me.ed{i}.archH = archH;
                me.ed{i}.st = me.st{i};
                me.ed{i}.offstcfg = me.offstcfg;
                me.dxed{i}.cfgH = cfgH;
                me.dxed{i}.datH = datH;
                me.dxed{i}.archH = archH;
                me.dxed{i}.st = me.st{i};
                me.dxed{i}.offstcfg = me.offstcfg;
            end
            
            for i = 1:4
                me.dd{i} = DerivedDof(me.cdp,i - 1);
                me.dd{i}.cfgH = cfgH;
                me.dd{i}.datH = datH;
                me.dd{i}.archH = archH;
                me.dd{i}.targetHist = me.dat.targetHist;
                me.dd{i}.substepHist = me.dat.substepHist;
                me.dd{i}.executeHist = me.dat.executeHist;
                me.dd{i}.offstcfg = me.offstcfg;
            end
            
            me.corrections = Corrections(me.cdp);
            me.corrections.ed = me.ed;
            me.corrections.dxed = me.dxed;
            me.corrections.dd = me.dd;
            
            for c =1:length(me.omStates)
                me.omStates{c}.cdp = me.cdp;
                me.omStates{c}.dat = me.dat;
                me.omStates{c}.mdlLbcb = me.mdlLbcb;
            end
            
            for c =1:length(me.stpStates)
                me.stpStates{c}.cdp = me.cdp;
                me.stpStates{c}.dat = me.dat;
                me.stpStates{c}.sdf = me.sdf;
                me.stpStates{c}.corrections = me.corrections;
            end
            me.acceptStp.lc = lc;
            
            for c =1:4
                me.dd{c}.cdp = me.cdp;
                if c < 3
                    me.ed{c}.cdp = me.cdp;
                end
            end
                        
            me.ddisp = DisplayFactory(handle);
            me.ddisp.stats = me.stats;
            me.ddisp.cdp = me.cdp;
            %            dbgWin = DebugWindow;
            me.ddisp.dat = me.dat;
            %            me.ddisp.dbgWin = dbgWin;
            me.gui.ddisp = me.ddisp;
            %            me.mdlLbcb.dbgWin = dbgWin;
            %            me.mdlBroadcast.dbgWin = dbgWin;
            
            for c =1:length(me.simStates)
                me.simStates{c}.cdp = me.cdp;
                me.simStates{c}.ocOm = me.ocOm;
                me.simStates{c}.dat = me.dat;
                me.simStates{c}.nxtStep = me.nxtStep;
                me.simStates{c}.sdf = me.sdf;
                me.simStates{c}.ddisp = me.ddisp;
				me.simStates{c}.arch = me.arch;
            end
            me.stpEx.peOm = me.peOm;
            me.stpEx.gcpOm = me.gcpOm;
            me.stpEx.gipOm = me.gipOm;
            me.stpEx.pResp = me.pResp;
            me.stpEx.st = me.st;
            me.stpEx.arch = me.arch;
            me.stpEx.brdcstRsp = me.brdcstRsp;
            me.stpEx.acceptStp = me.acceptStp;
            me.stpEx.corrections = me.corrections;
            me.stpEx.stats = me.stats;

            me.tgtEx.stpEx = me.stpEx;
            me.tgtEx.inF = me.inF;
            me.tgtEx.ocSimCor = me.ocSimCor;
            me.tgtEx.tgtRsp = me.tgtRsp;
            
            me.offstRfsh.gcpOm = me.gcpOm;
            me.offstRfsh.gipOm = me.gipOm;
            me.offstRfsh.pResp = me.pResp;
            
            for c =1:length(me.simCorStates)
                me.simCorStates{c}.cdp = me.cdp;
                me.simCorStates{c}.mdlUiSimCor = me.mdlUiSimCor;
                me.simCorStates{c}.dat = me.dat;
                me.simCorStates{c}.sdf = me.sdf;
            end
            
            for c =1:length(me.brdcstStates)
                me.brdcstStates{c}.cdp = me.cdp;
                me.brdcstStates{c}.mdlBroadcast = me.mdlBroadcast;
                me.brdcstStates{c}.dat = me.dat;
                me.brdcstStates{c}.sdf = me.sdf;
            end
            
            if isempty(handle)
                me.gui = LbcbPluginResults(handle,me);
                bsimst = ButtonGroupManagement([]);
                me.gui.bsimst = bsimst;
                bstpst = ButtonGroupManagement([]);
                me.gui.bstpst = bstpst;
                bsrc = ButtonGroupManagement([]);
                me.gui.bsrc = bsrc;
                bcor = CorrectionButtonGroupManagement([]);
                me.gui.bcor = bcor;
            else
                me.setGuiHandle(handle);
            end
            
        end
        function setGuiHandle(me, handle)
            me.gui = LbcbPluginResults(handle,me);
            me.fillButtons(handle)
            me.gui.ddisp = me.ddisp;
            me.gui.stats = me.stats;

            me.ddisp.initialize(handle);
            
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
            for c =1:length(me.stpStates)
                me.stpStates{c}.gui = me.gui;
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
        function c = get.gipOm(me)
            c= me.omStates{4};
        end
        function c = get.nxtStep(me)
            c= me.stpStates{1};
        end
        function c = get.pResp(me)
            c= me.stpStates{2};
        end
        function c = get.stpEx(me)
            c= me.simStates{1};
        end
        function c = get.tgtEx(me)
            c= me.simStates{2};
        end
        function c = get.offstRfsh(me)
            c= me.simStates{3};
        end
        function c = get.acceptStp(me)
            c= me.stpStates{3};
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
        function c = get.cfg(me)
            c= me.cdp.cfg;
        end
        function fillButtons(me,handle)
            bsimst = ButtonGroupManagement(handle.simStatesPanel);
            bsimst.childHandles = {...
                handle.ipButton,...
                handle.wftButton,...
                handle.ptButton,...
                handle.esButton,...
                handle.strButton,...
                handle.simdButton...
                };
            me.gui.bsimst = bsimst;
            bstpst = ButtonGroupManagement(handle.stepStatesPanel);
            bstpst.childHandles = {...
                handle.nsButton,...
                handle.asButton,...
                handle.peButton,...
                handle.gcpButton,...
                handle.prButton,...
                handle.btButton,...
                handle.stpdButton...
                };
            me.gui.bstpst = bstpst;
            bsrc = ButtonGroupManagement(handle.sourcePanel);
            bsrc.childHandles = {...
                handle.ifButton,...
                handle.scorButton,...
                };
            me.gui.bsrc = bsrc;
            bcor = CorrectionButtonGroupManagement(handle.correctionPanel);
            bcor.childHandles = {...
                handle.edButton,...
                handle.ddButton,...
                handle.cornButton,...
                };
            me.gui.bcor = bcor;
        end
    end
end
