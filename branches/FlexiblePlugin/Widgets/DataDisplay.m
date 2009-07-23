classdef DataDisplay < handle
    properties
        dataTable = [];
    end
    methods
        function me = DataDisplay()
            me.dataTable = [];
            DataDisplay.setDataDisplayHandle(me);
        end
        function startDataTable(me)
            me.dataTable = LbcbDataTable('DOF Data');
        end
        function stopDataTable(me)
            delete(me.dataTable.fig);
            DataDisplay.deleteDataTable();
        end
        function update(me,step)
            if isempty(me.dataTable) == 0 % Means the data table exists (double negative)
                me.dataTable.update(step);
            end
        end
    end
    methods (Static)
        function setMenuHandle(h)
            global menuHandle;
            menuHandle = h;
        end
        function deleteDataTable()
            global ddMe;
            global menuHandle;
            ddMe.dataTable = [];
            set(menuHandle.DataTable,'Checked','off');
        end
        function setDataDisplayHandle(mMe)
            global ddMe;
            ddMe = mMe;
        end
    end
end