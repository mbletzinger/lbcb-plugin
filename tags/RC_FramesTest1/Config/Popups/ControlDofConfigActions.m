classdef ControlDofConfigActions < handle
    properties
        handles = [];
        cdofcfg
        log = Logger('ControlDofConfigActions');
        cdofTable
    end
    methods
        function me = ControlDofConfigActions(cfg)
            me.cdofcfg = ControlDofConfigDao(cfg);
            me.cdofTable = cell(12,4);
            cdofl1 = me.cdofcfg.cDofL1;
            cdofl2 = me.cdofcfg.cDofL2;
            cdofs = {'Dx', 'Dy', 'Dz', 'Rx', 'Ry', 'Rz', 'Fx', 'Fy', 'Fz', 'Mx', 'My', 'Mz'};
            me.cdofTable(:,2) = cdofs(:);
            me.cdofTable(:,4) = cdofs(:);
            for i = 1:12
                me.cdofTable{i,1} = (cdofl1(i) ~= 0);
                me.cdofTable{i,3} = (cdofl2(i) ~= 0);
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.controlDofTable,'Data',me.cdofTable);
            format = {'logical','char','logical','char'};
            set(me.handles.controlDofTable,'ColumnFormat',format);            
        end
        function setControlDof(me,indices,val)
            cdofl1 = me.cdofcfg.cDofL1;
            cdofl2 = me.cdofcfg.cDofL2;
            switch indices(2)
                case 1
                    cdofl1(indices(1)) = (val ~= 0);
                case 3
                    cdofl2(indices(1)) = (val ~= 0);
                otherwise
                    return;
            end
            me.cdofcfg.cDofL1 = cdofl1;
            me.cdofcfg.cDofL2 = cdofl2;
        end
    end
end
