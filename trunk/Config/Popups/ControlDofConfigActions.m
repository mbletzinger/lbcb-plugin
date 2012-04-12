classdef ControlDofConfigActions < handle
    properties
        handles = [];
        cdofcfg
        log = Logger('ControlDofConfigActions');
        cdofTable
    end
    methods
        function me = StepConfigActions(cfg)
            me.cdofcfg = ControlDofConfigDao(cfg);
            me.cdofTable = cell(12,4);
            cdofl1 = me.cdofcfg.cDofL1;
            cdofl2 = me.cdofcfg.cDofL2;
            cdofs = {'Dx', 'Dy', 'Dz', 'Rx', 'Ry', 'Rz', 'Fx', 'Fy', 'Fz', 'Mx', 'My', 'Mz'};
            me.cdofTable(:,2) = cdofs(:);
            me.cdofTable(:,4) = cdofs(:);
            for i = 1:12
                me.cdofTable{i,1} = cdofl1(i);
                me.cdofTable{i,3} = cdofl2(i);
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.cdofTable,'Data',me.cdofTable);
            format = {'logical','text','logical','text'};
            set(me.handles.cdofTable,'ColumnFormat',format);            
        end
        function setCorrectionCell(me,indices,val)
            cdofl1 = me.cdofcfg.cDofL1;
            cdofl2 = me.cdofcfg.cDofL2;
            switch indices(2)
                case 1
                    cdofl1(indices(1)) = val;
                case 3
                    cdofl2(indices(1)) = val;
                otherwise
                    return;
            end
            me.cdofcfg.cDofL1 = cdofl1;
            me.cdofcfg.cDofL2 = cdofl2;
        end
    end
end
