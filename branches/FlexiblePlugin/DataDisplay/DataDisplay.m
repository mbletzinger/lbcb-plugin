classdef DataDisplay < handle
    properties
        dataTable = {};
        totalFxVsLbcbDxL1 = {};
        totalFxVsLbcbDxL2 = {};
        log = Logger('DataDisplay');
        dat
    end
    methods
        function me = DataDisplay()
            me.dataTable = {};
            DataDisplay.setDataDisplayHandle(me);
            me.totalFxVsLbcbDxL1 = TotalFxVsLbcbDx(1);
            me.totalFxVsLbcbDxL2 = TotalFxVsLbcbDx(0);
        end
        function startDataTable(me)
            me.dataTable = LbcbDataTable('Step DOF Data');
        end
        function stopDataTable(me)
            me.dataTable.delete();
            DataDisplay.deleteDisplay(0);
        end
        function startTotalFxVsLbcbDx(me,isLbcb1)
            if isLbcb1
                me.totalFxVsLbcbDxL1.display(0);
            else
                me.totalFxVsLbcbDxL2.display(1);
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
            if isempty(me.dataTable) == false
                me.dataTable.update(me.dat.curStepData);
            end
            me.totalFxVsLbcbDxL1.update(me.dat.curStepData);
            me.totalFxVsLbcbDxL2.update(me.dat.curStepData);            
        end
    end
    methods (Static)
        function setMenuHandle(h)
            global menuHandle;
            menuHandle = h;
        end
        function deleteDisplay(display)
            global ddMe;
            global menuHandle;
            switch display
                case 0
                    ddMe.dataTable = [];
                    set(menuHandle.DataTable,'Checked','off');
                case 1
                    ddMe.totalFxVsLbcbL1.display(0);
                    set(menuHandle.TotalFxVsLbcb1Dx,'Checked','off');
                case 2
                    ddMe.totalFxVsLbcbL1.display(0);
                    set(menuHandle.TotalFxVsLbcb1Dx,'Checked','off');
                otherwise
                    me.log.error(dbstack, sprintf('Case %d not recognized',display));
            end 
        end
        function setDataDisplayHandle(mMe)
            global ddMe;
            ddMe = mMe;
        end
    end
end