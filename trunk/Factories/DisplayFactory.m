classdef DisplayFactory < handle
    properties
        mainDisp
        dispIdxs
        disps
        idx
        checkHndls
        dat
        cdp
    end
    methods
        function me = DisplayFactory(handle)
            me.mainDisp = handle;
            me.idx = 1;
            me.dispIdxs = org.nees.uiuc.simcor.matlab.HashTable();
            me.disps = {};
            DisplayFactory.setMe(me);
        end
        function addDisplay(me,name,ref,chkhndl)
            me.dispIdxs.put(name,me.idx);
            me.disps{me.idx} = ref;
            me.checkHndls{me.idx} = chkhndl;
            me.idx = me.idx + 1;
        end
        function initialize(me,handle)
            me.mainDisp = handle;
%             ref = ArchPlot('TotalFxVsLbcb1Dx',1,1,'Fx total');
%             ref.cdp = me.cdp;
%             me.addDisplay('TotalFxVsLbcb1Dx',ref,me.mainDisp.TotalFxVsLbcb1Dx);
%             ref = ArchPlot('TotalFxVsLbcb2Dx',0,1,'Fx total');
%             ref.cdp = me.cdp;
%             me.addDisplay('TotalFxVsLbcb2Dx',ref,me.mainDisp.TotalFxVsLbcb2Dx);
%             ref = ArchPlot('TotalMyVsLbcb1Dx',1,1,'My total');
%             ref.cdp = me.cdp;
%             me.addDisplay('TotalMyVsLbcb1Dx',ref,me.mainDisp.TotalMyVsLbcb1Dx);
%             ref = ArchPlot('TotalMyVsLbcb2Dx',0,1,'My total');
%             ref.cdp = me.cdp;
%             me.addDisplay('TotalMyVsLbcb2Dx',ref,me.mainDisp.TotalMyVsLbcb2Dx);
            ref = ArchPlot('MyBottom',1,1,'MyBottom');
            ref.cdp = me.cdp;
            me.addDisplay('MyBottom',ref,me.mainDisp.MyBottom);
            ref = VsPlot('RyVsLbcb1Dx',1,1,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyVsLbcb1Dx',ref,me.mainDisp.RyVsLbcb1Dx);
            ref = VsPlot('RyVsLbcb2Dx',0,1,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyVsLbcb2Dx',ref,me.mainDisp.RyVsLbcb2Dx);
            ref = VsPlot('FxVsLbcb1Dx',1,1,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxVsLbcb1Dx',ref,me.mainDisp.FxVsLbcb1Dx);
            ref = VsPlot('FxVsLbcb2Dx',0,1,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxVsLbcb2Dx',ref,me.mainDisp.FxVsLbcb2Dx);
            ref = VsPlot('MyVsLbcb1Dx',1,1,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyVsLbcb1Dx',ref,me.mainDisp.MyVsLbcb1Dx);
            ref = VsPlot('MyVsLbcb2Dx',0,1,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyVsLbcb2Dx',ref,me.mainDisp.MyVsLbcb2Dx);
            ref = OneDofStepPlot('DxStepL1',1,me.dat,1);
            ref.cdp = me.cdp;
            me.addDisplay('DxStepL1',ref,me.mainDisp.DxStepL1);
            ref = OneDofStepPlot('DxStepL2',0,me.dat,1);
            ref.cdp = me.cdp;
            me.addDisplay('DxStepL2',ref,me.mainDisp.DxStepL2);
            ref = OneDofStepPlot('RyStepL1',1,me.dat,5);
            ref.cdp = me.cdp;
            ref = OneDofStepPlot('DzStepL1',1,me.dat,3);
            ref.cdp = me.cdp;
            me.addDisplay('DzStepL1',ref,me.mainDisp.DzStepL1);
            ref = OneDofStepPlot('DzStepL2',0,me.dat,3);
            ref.cdp = me.cdp;
            me.addDisplay('DzStepL2',ref,me.mainDisp.DzStepL2);
            me.addDisplay('RyStepL1',ref,me.mainDisp.RyStepL1);
            ref = OneDofStepPlot('RyStepL2',0,me.dat,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyStepL2',ref,me.mainDisp.RyStepL2);
            ref = OneDofStepPlot('FzStepL1',1,me.dat,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzStepL1',ref,me.mainDisp.FzStepL1);
            ref = OneDofStepPlot('FzStepL2',0,me.dat,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzStepL2',ref,me.mainDisp.FzStepL2);
            ref = OneDofStepPlot('MyStepL1',1,me.dat,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyStepL1',ref,me.mainDisp.MyStepL1);
            ref = OneDofStepPlot('MyStepL2',0,me.dat,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyStepL2',ref,me.mainDisp.MyStepL2);
            ref = ResponseTable('L1ResponseTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1ResponseTable',ref,me.mainDisp.L1ResponseTable);
            ref = ResponseTable('L2ResponseTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2ResponseTable',ref,me.mainDisp.L2ResponseTable);
            ref = AllStepsCommandTable('L1CommandTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1CommandTable',ref,me.mainDisp.L1CommandTable);
            ref = AllStepsCommandTable('L2CommandTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2CommandTable',ref,me.mainDisp.L2CommandTable);
            ref = SubstepsCommandTable('L1SubstepsTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1SubstepsTable',ref,me.mainDisp.L1SubstepsTable);
            ref = SubstepsCommandTable('L2SubstepsTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2SubstepsTable',ref,me.mainDisp.L2SubstepsTable);
            ref = LbcbReadingsTable('L1ReadingsTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1ReadingsTable',ref,me.mainDisp.L1ReadingsTable);
            ref = LbcbReadingsTable('L2ReadingsTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2ReadingsTable',ref,me.mainDisp.L2ReadingsTable);
            ref = ArchTable('DerivedTable');
            ref.cdp = me.cdp;
            me.addDisplay('DerivedTable',ref,me.mainDisp.DerivedTable);
        end
        function yes = isDisplaying(me,name)
            ref = me.disps{me.dispIdxs.get(name)};
            yes = ref.plot.isDisplayed;
        end
        function closeDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.undisplayMe();
            hndl = me.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','off');
            end
        end
        function openDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.displayMe();
            ref.plot.isDisplayed = true;
            hndl = me.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','on');
            end
        end
        function updateDisplay(me,name,target)
            ref = me.disps{me.dispIdxs.get(name)};
            ref.update(target);
        end
        function updateAll(me,target)
            keys = me.dispIdxs.keys();
            lt = length(keys);
            for v = 1:lt
                name = char(keys(v));
                me.updateDisplay(name,target);
            end
        end
        function closeAll(me)
            keys = me.dispIdxs.keys();
            lt = length(keys);
            for v = 1:lt
                name = char(keys(v));
                if me.isDisplaying(name)
                    me.closeDisplay(name);
                end
            end
        end
    end
    methods (Static)
        function setMe(me)
            global mySelf;
            mySelf = me;
        end
        function dispDeleted(src,event,name) %#ok<INUSD,INUSL>
            global mySelf;
            i = mySelf.dispIdxs.get(name);
            ref = mySelf.disps{i};
            ref.plot.isDisplayed = false;
            hndl = mySelf.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','off');
            end
        end
    end
end