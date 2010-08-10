classdef DataDisplay < handle
    properties
        dataTable = {};
        totalFxVsLbcbDxL1 = {};
        totalFxVsLbcbDxL2 = {};
        totalMyVsLbcbDxL1 = {};
        totalMyVsLbcbDxL2 = {};
        MyVsDxL1 = {};
        MyVsDxL2 = {};
        RyVsDxL1 = {};
        RyVsDxL2 = {};
        FxVsDxL1 = {};
        FxVsDxL2 = {};
        DxStepL1 = {};
        DxStepL2 = {};
        RyStepL1 = {};
        RyStepL2 = {};
        DzStepL1 = {};
        DzStepL2 = {};
        FzStepL1 = {};
        FzStepL2 = {};
        log = Logger('DataDisplay');
        dat
        dbgWin
        cdp
    end
    methods
        function me = DataDisplay()
            me.dataTable = DataTable('Step DOF Data');
            DataDisplay.setDataDisplayHandle(me);
            me.totalFxVsLbcbDxL1 = TotalFxVsLbcbDx(1);
            me.totalFxVsLbcbDxL2 = TotalFxVsLbcbDx(0);
            me.totalMyVsLbcbDxL1 = TotalMyVsDx(1);
            me.totalMyVsLbcbDxL2 = TotalMyVsDx(0);
            me.MyVsDxL1 = MyVsDx(1);
            me.MyVsDxL2 = MyVsDx(0);
            me.RyVsDxL1 = RyVsDx(1);
            me.RyVsDxL2 = RyVsDx(0);
            me.FxVsDxL1 = FxVsDx(1);
            me.FxVsDxL2 = FxVsDx(0);
            me.DxStepL1 = OneDofStepPlot(1,me.dat,1);
            me.DxStepL2 = OneDofStepPlot(0,me.dat,1);
            me.RyStepL1 = OneDofStepPlot(1,me.dat,5);
            me.RyStepL2 = OneDofStepPlot(0,me.dat,5);
            me.DzStepL1 = OneDofStepPlot(1,me.dat,3);
            me.DzStepL2 = OneDofStepPlot(0,me.dat,3);
            me.FzStepL1 = OneDofStepPlot(1,me.dat,9);
            me.FzStepL2 = OneDofStepPlot(0,me.dat,9);
        end
        update(me)
        function startDataTable(me)
            me.dataTable.displayMe();
        end
        function stopDataTable(me) %#ok<*MANU>
            DataDisplay.deleteDisplay(0);
        end
        function startDebugWindow(me)
            me.dbgWin.displayMe();
        end
        function stopDebugWindow(me)
            DataDisplay.deleteDisplay(3);
        end
        function startTotalFxVsLbcbDx(me,isLbcb1)
            if isLbcb1
                me.totalFxVsLbcbDxL1.displayMe();
            else
                me.totalFxVsLbcbDxL2.displayMe();
            end
        end
        function stopTotalFxVsLbcbDx(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(1);
            else
                DataDisplay.deleteDisplay(2);
            end
        end
        function startTotalMyVsLbcbDx(me,isLbcb1)
            if isLbcb1
                me.totalMyVsLbcbDxL1.displayMe();
            else
                me.totalMyVsLbcbDxL2.displayMe();
            end
        end
        function stopTotalMyVsLbcbDx(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(4);
            else
                DataDisplay.deleteDisplay(5);
            end
        end
        function startMyVsDx(me,isLbcb1)
            if isLbcb1
                me.MyVsDxL1.displayMe();
            else
                me.MyVsDxL2.displayMe();
            end
        end
        function stopMyVsDx(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(6);
            else
                DataDisplay.deleteDisplay(7);
            end
        end
        function startRyVsDx(me,isLbcb1)
            if isLbcb1
                me.RyVsDxL1.displayMe();
            else
                me.RyVsDxL2.displayMe();
            end
        end
        function stopRyVsDx(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(8);
            else
                DataDisplay.deleteDisplay(9);
            end
        end
        function startFxVsDx(me,isLbcb1)
            if isLbcb1
                me.FxVsDxL1.displayMe();
            else
                me.FxVsDxL2.displayMe();
            end
        end
        function stopFxVsDx(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(10);
            else
                DataDisplay.deleteDisplay(11);
            end
        end
        function startDxStep(me,isLbcb1)
            if isLbcb1
                me.DxStepL1.displayMe();
            else
                me.DxStepL2.displayMe();
            end
        end
        function stopDxStep(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(12);
            else
                DataDisplay.deleteDisplay(13);
            end
        end
        function startRyStep(me,isLbcb1)
            if isLbcb1
                me.RyStepL1.displayMe();
            else
                me.RyStepL2.displayMe();
            end
        end
        function stopRyStep(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(14);
            else
                DataDisplay.deleteDisplay(15);
            end
        end
        function startDzStep(me,isLbcb1)
            if isLbcb1
                me.DzStepL1.displayMe();
            else
                me.DzStepL2.displayMe();
            end
        end
        function stopDzStep(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(16);
            else
                DataDisplay.deleteDisplay(17);
            end
        end
        function startFzStep(me,isLbcb1)
            if isLbcb1
                me.FzStepL1.displayMe();
            else
                me.FzStepL2.displayMe();
            end
        end
        function stopFzStep(me,isLbcb1)
            if isLbcb1
                DataDisplay.deleteDisplay(18);
            else
                DataDisplay.deleteDisplay(19);
            end
        end
        function set.cdp(me,cdp)
            me.cdp = cdp;
            me.dataTable.cdp = cdp;
        end
        function set.dat(me,dt)
            me.dat = dt;
            me.DxStepL1.dat = dt; %#ok<*MCSUP>
            me.DxStepL2.dat = dt;
            me.RyStepL1.dat = dt;
            me.RyStepL2.dat = dt;
            me.DzStepL1.dat = dt;
            me.DzStepL2.dat = dt;
            me.FzStepL1.dat = dt;
            me.FzStepL2.dat = dt;
        end
        
    end
    methods (Static)
        deleteDisplay(display)
        setDataDisplayHandle(mMe)
        setMenuHandle(hndl)
        checkOff(obj,event,c) %#ok<*INUSD,*INUSL>
    end
end