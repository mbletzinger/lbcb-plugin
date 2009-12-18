classdef DataDisplay < handle
    properties
        dataTable = {};
        totalFxVsLbcbDxL1 = {};
        totalFxVsLbcbDxL2 = {};
        log = Logger('DataDisplay');
        dat
        dbgWin
    end
    methods
        function me = DataDisplay()
            me.dataTable = LbcbDataTable('Step DOF Data');
            DataDisplay.setDataDisplayHandle(me);
            me.totalFxVsLbcbDxL1 = TotalFxVsLbcbDx(1);
            me.totalFxVsLbcbDxL2 = TotalFxVsLbcbDx(0);
        end
        function startDataTable(me)
            me.dataTable.displayMe();
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
        function update(me)
            me.dataTable.update(me.dat.curStepData);
            me.totalFxVsLbcbDxL1.update(me.dat.curStepData);
            me.totalFxVsLbcbDxL2.update(me.dat.curStepData);
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
                otherwise
                    me.log.error(dbstack, sprintf('Case %d not recognized',c));
            end
            DataDisplay.deleteDisplay(c);
        end
    end
end