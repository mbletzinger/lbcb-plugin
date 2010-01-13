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
        log = Logger('DataDisplay');
        dat
        dbgWin
        cdp
    end
    methods
        function me = DataDisplay()
            me.dataTable = LbcbDataTable('Step DOF Data');
            DataDisplay.setDataDisplayHandle(me);
            me.totalFxVsLbcbDxL1 = TotalFxVsLbcbDx(1);
            me.totalFxVsLbcbDxL2 = TotalFxVsLbcbDx(0);
            me.totalMyVsLbcbDxL1 = TotalMyVsDx(1);
            me.totalMyVsLbcbDxL2 = TotalMyVsDx(0);
            me.MyVsDxL1 = MyVsDx(1);
            me.MyVsDxL2 = MyVsDx(0);
            me.RyVsDxL1 = RyVsDx(1);
            me.RyVsDxL2 = RyVsDx(0);
        end
        function startDataTable(me)
            me.dataTable.displayMe(me.cdp);
        end
        function stopDataTable(me)
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
        function update(me)
            me.log.debug(dbstack, sprintf('Displaying %s',me.dat.curStepData.toString()));
            me.dataTable.update(me.dat.curStepData);
            me.totalFxVsLbcbDxL1.update(me.dat.curStepData);
            me.totalFxVsLbcbDxL2.update(me.dat.curStepData);
            me.totalMyVsLbcbDxL1.update(me.dat.curStepData);
            me.totalMyVsLbcbDxL2.update(me.dat.curStepData);
            me.MyVsDxL1.update(me.dat.curStepData);
            me.MyVsDxL2.update(me.dat.curStepData);
            me.RyVsDxL1.update(me.dat.curStepData);
            me.RyVsDxL2.update(me.dat.curStepData);
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
        function checkOff(obj,event,c)
            global mhndl;            
            switch c
                case 0
                    set(mhndl.DataTable,'Checked','off');
                case 1
                    set(mhndl.TotalFxVsLbcb1Dx,'Checked','off');
                case 2
                    set(mhndl.TotalFxVsLbcb2Dx,'Checked','off');
                case 3
                    set(mhndl.DebugWindow,'Checked','off');
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
                otherwise
                    me.log.error(dbstack, sprintf('Case %d not recognized',c));
            end
            DataDisplay.deleteDisplay(c);
        end
    end
end