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
        end
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
        function update(me)
            target = me.dat.curStepData;
            me.log.debug(dbstack, sprintf('Displaying %s',target.toString()));
            me.dataTable.update(target);
            me.MyVsDxL1.update(target);
            me.RyVsDxL1.update(target);
            me.FxVsDxL1.update(target);
            me.DxStepL1.update();
            me.RyStepL1.update();
            me.DzStepL1.update();
            if me.cdp.numLbcbs() > 1
                me.totalFxVsLbcbDxL1.update(target);
                me.totalFxVsLbcbDxL2.update(target);
                me.totalMyVsLbcbDxL1.update(target);
                me.totalMyVsLbcbDxL2.update(target);
                me.MyVsDxL2.update(target);
                me.RyVsDxL2.update(target);
                me.DxStepL2.update();
                me.RyStepL2.update();
                me.DzStepL2.update();
            end
        end
        function setCdp(me,cdp)
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
        end
        
    end
    methods (Static)
        function deleteDisplay(display)
            global ddMe;
            switch display
                case 0
                    ddMe.dataTable.undisplayMe();
                case 1
                    ddMe.totalFxVsLbcbDxL1.undisplayMe();
                case 2
                    ddMe.totalFxVsLbcbDxL2.undisplayMe();
                case 3
                    ddMe.dbgWin.undisplayMe();
                case 4
                    ddMe.totalMyVsLbcbDxL1.undisplayMe();
                case 5
                    ddMe.totalMyVsLbcbDxL2.undisplayMe();
                case 6
                    ddMe.MyVsDxL1.undisplayMe();
                case 7
                    ddMe.MyVsDxL2.undisplayMe();
                case 8
                    ddMe.RyVsDxL1.undisplayMe();
                case 9
                    ddMe.RyVsDxL2.undisplayMe();
                case 10
                    ddMe.FxVsDxL1.undisplayMe();
                case 11
                    ddMe.FxVsDxL2.undisplayMe();
                case 12
                    ddMe.DxStepL1.undisplayMe();
                case 13
                    ddMe.DxStepL2.undisplayMe();
                case 14
                    ddMe.RyStepL1.undisplayMe();
                case 15
                    ddMe.RyStepL2.undisplayMe();
                case 16
                    ddMe.DzStepL1.undisplayMe();
                case 17
                    ddMe.DzStepL2.undisplayMe();
                otherwise
                    me.log.error(dbstack, sprintf('Case %d not recognized',display));
            end
        end
        function setDataDisplayHandle(mMe)
            global ddMe;
            ddMe = mMe;
        end
        function setMenuHandle(hndl)
            global mhndl;
            mhndl = hndl;
        end
        function checkOff(obj,event,c) %#ok<*INUSD,*INUSL>
            global mhndl;
            switch c
                case 0
                    set(mhndl.DataTable,'Checked','off');
                case 1
                    set(mhndl.TotalFxVsLbcb1Dx,'Checked','off');
                case 2
                    set(mhndl.TotalFxVsLbcb2Dx,'Checked','off');
                case 3
%                    set(mhndl.DebugWindow,'Checked','off');
                case 4
                    set(mhndl.TotalMyVsLbcb1Dx,'Checked','off');
                case 5
                    set(mhndl.TotalMyVsLbcb2Dx,'Checked','off');
                case 6
                    set(mhndl.MyVsLbcb1Dx,'Checked','off');
                case 7
                    set(mhndl.MyVsLbcb2Dx,'Checked','off');
                case 8
                    set(mhndl.RyVsLbcb1Dx,'Checked','off');
                case 9
                    set(mhndl.RyVsLbcb2Dx,'Checked','off');
                case 10
                    set(mhndl.FxVsLbcb1Dx,'Checked','off');
                case 11
                    set(mhndl.FxVsLbcb2Dx,'Checked','off');
                case 12
                    set(mhndl.DxStepL1,'Checked','off');
                case 13
                    set(mhndl.DxStepL2,'Checked','off');
                case 14
                    set(mhndl.RyStepL1,'Checked','off');
                case 15
                    set(mhndl.RyStepL2,'Checked','off');
                case 16
                    set(mhndl.DzStepL1,'Checked','off');
                case 17
                    set(mhndl.DzStepL2,'Checked','off');
                otherwise
                    me.log.error(dbstack, sprintf('Case %d not recognized',c));
            end
            DataDisplay.deleteDisplay(c);
        end
    end
end