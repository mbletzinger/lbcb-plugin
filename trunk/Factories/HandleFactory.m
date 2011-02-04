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
        
        % Corrections
        ed = cell(2,1);
        dd = cell(4,1);
        pa = [];
        
        % Simulation States and Executors
        omStates = cell(3,1);
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
        
        %Fake OM classes
        
        fakeGcp = [];
        
        %Archiver
        
        arch = [];
        
        % Display Windows
        ddisp = []
        
        
    end
    properties (Dependent = true)
        % OM states
        ocOm;
        peOm;
        gcpOm;
        
        % Step States
        nxtStep;
        pResp;
        acceptStp;
        
        %Simulation Execution
        stpEx;
        tgtEx;
        
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
        function me = HandleFactory(handle,cfg)
            
            me.cdp = ConfigDaoProvider(cfg);
            
            me.mdlLbcb = MdlLbcb(me.cfg);
            me.omStates{1} = OpenCloseOm;
            me.omStates{2} = ProposeExecuteOm;
            me.omStates{3} = GetControlPointsOm;
            
            me.stpStates{1} = NextStep;
            me.stpStates{2} = ProcessResponse;
            me.stpStates{3} = ProcessTarget;
            
            me.simStates{1} = StepStates;
            me.simStates{2} = TargetStates;
            
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

            me.sdf = StepDataFactory;
            me.sdf.cdp = me.cdp;
            me.sdf.mdlLbcb = me.mdlLbcb;
            me.sdf.mdlUiSimCor = me.mdlUiSimCor;
            me.inF = InputFile(me.sdf);

            me.dat = SimSharedData;
            me.dat.sdf = me.sdf;
            me.dat.cdp = me.cdp;
            me.arch = Archiver(me.cdp);
            me.cfg.dat = me.dat;
            me.cfg.arch = me.arch;

            cfgH = org.nees.uiuc.simcor.matlab.HashTable();
            datH = org.nees.uiuc.simcor.matlab.HashTable();
            archH = org.nees.uiuc.simcor.matlab.HashTable();
            for i = 1:2
                me.ed{i} = ElasticDeformation(me.cdp,(i == 1));
                me.st{i} = StepTolerances(me.cfg,i == 1);
                me.ed{i}.cfgH = cfgH;
                me.ed{i}.datH = datH;
                me.ed{i}.archH = archH;
                me.ed{i}.st = me.st;
            end
            
            for i = 1:4
                me.dd{i} = DerivedDof(me.cdp,i - 1);
                me.dd{i}.cfgH = cfgH;
                me.dd{i}.datH = datH;
                me.dd{i}.archH = archH;
            end
            
            me.pa = PrelimAdjustment(me.cdp);
            me.pa.cfgH = cfgH;
            me.pa.datH = datH;
            me.pa.dat = me.dat;
            me.pa.archH = archH;
            
            for c =1:length(me.omStates)
                me.omStates{c}.cdp = me.cdp;
                me.omStates{c}.dat = me.dat;
                me.omStates{c}.mdlLbcb = me.mdlLbcb;
            end
            
            for c =1:length(me.stpStates)
                me.stpStates{c}.cdp = me.cdp;
                me.stpStates{c}.dat = me.dat;
                me.stpStates{c}.sdf = me.sdf;
                me.stpStates{c}.ed = me.ed;
                me.stpStates{c}.dd = me.dd;
                me.stpStates{c}.pa = me.pa;
            end
            me.acceptStp.lc = lc;
            
            for c =1:4
                me.dd{c}.cdp = me.cdp;
                if c < 3
                    me.ed{c}.cdp = me.cdp;
                end
            end
            
            me.fakeGcp = GetControlPointsFake(me.cdp);
            me.fakeGcp.dat = me.dat;
            me.ddisp = DisplayFactory(handle);
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
            end
            me.stpEx.fakeGcp = me.fakeGcp;
            me.stpEx.peOm = me.peOm;
            me.stpEx.gcpOm = me.gcpOm;
            me.stpEx.pResp = me.pResp;
            me.stpEx.st = me.st;
            me.stpEx.arch = me.arch;
            me.stpEx.brdcstRsp = me.brdcstRsp;
            me.stpEx.acceptStp = me.acceptStp;
            
            me.tgtEx.stpEx = me.stpEx;
            me.tgtEx.inF = me.inF;
            me.tgtEx.ocSimCor = me.ocSimCor;
                        
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
                handle.esButton,...
                handle.strButton,...
                handle.simdButton...
                };
            me.gui.bsimst = bsimst;
            bstpst = ButtonGroupManagement(handle.stepStatesPanel);
            bstpst.childHandles = {...
                handle.nsButton,...
                handle.ptButton,...
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
                handle.srcnButton,...
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