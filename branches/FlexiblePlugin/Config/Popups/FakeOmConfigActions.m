classdef FakeOmConfigActions < handle
    properties
        handles = [];
        dofTable;
        fcfg
        ocfg
        log = Logger('FakeOmConfigActions')
        derived
        extsensTable
        sensorNames
    end
    methods
        function me = FakeOmConfigActions(cfg)
            me.fcfg = FakeOmDao(cfg);
            me.ocfg = OmConfigDao(cfg);
            me.derived = me.fcfg.derivedOptions;
            me.sensorNames = me.ocfg.sensorNames;
        end
        function initialize(me,handles)
            me.handles = handles;
            derive = [ me.fcfg.derived1; me.fcfg.derived2 ];
            scale = [ me.fcfg.scale1; me.fcfg.scale2 ];
            offset = [ me.fcfg.offset1; me.fcfg.offset2 ];
            me.dofTable = cell(24,3);
            for d = 1:24
                me.dofTable{d,1} = derive{d};
                me.dofTable{d,2} = scale(d);
                me.dofTable{d,3} = offset(d);
            end

            
            derive = me.fcfg.eDerived;
            scale = me.fcfg.eScale;
            offset = me.fcfg.eOffset;
            numExtSens = length(me.sensorNames);
            me.extsensTable = cell(numExtSens,3);
            for d = 1:numExtSens
                me.extsensTable{d,1} = derive{d};
                me.extsensTable{d,2} = scale(d);
                me.extsensTable{d,3} = offset(d);
            end
            
            set(me.handles.ExtSensorTable,'Data',me.extsensTable);
            set(me.handles.LbcbDofTable,'Data',me.dofTable);
            format = {me.derived,'numeric','numeric'};
            set(me.handles.ExtSensorTable,'ColumnFormat',format);
            set(me.handles.LbcbDofTable,'ColumnFormat',format);
            set(me.handles.ExtSensorTable,'RowName',me.sensorNames);
            set(me.handles.ConvergenceIncrement,'String',sprintf('%d',me.fcfg.convergeInc));
            set(me.handles.NumConvergenceSteps,'String',sprintf('%d',me.fcfg.convergeSteps));
        end
        function setNumConvergenceSteps(me,value)
            me.fcfg.convergeSteps = value;
        end
        function setConvergenceIncrement(me,value)
            me.fcfg.convergeInc = value;
        end
        function setDofCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<UNRCH>
            end
            if indices(1) > 24
                me.log.error(dbstack, 'Only 24 DOFs exist');
              return;
            end
            if indices(1) > 12
            derive = me.fcfg.derived2;
            scale = me.fcfg.scale2;
            offset = me.fcfg.offset2;
            else
            derive = me.fcfg.derived1;
            scale = me.fcfg.scale1;
            offset = me.fcfg.offset1;
            end
            switch indices(2)
                case 1
                    derive{indices(1)} = data;
                case 2
                    scale(indices(1)) = data;
                case 3
                    offset(indices(1)) = data;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
                        if indices(1) > 12
            me.fcfg.derived2 = derive;
            me.fcfg.scale2 = scale;
            me.fcfg.offset2 = offset;
            else
            me.fcfg.derived1 = derive;
            me.fcfg.scale1 = scale;
            me.fcfg.offset1 = offset;
            end

        end
        function setExtSensCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<UNRCH>
            end
            if indices(1) > length(me.sensorNames)
                me.log.error(dbstack, sprintf('Only %d exist',length(me.sensorNames)));
              return;
            end
            derive = me.fcfg.eDerived;
            scale = me.fcfg.eScale;
            offset = me.fcfg.eOffset;
            switch indices(2)
                case 1
                    derive{indices(1)} = data;
                case 2
                    scale(indices(1)) = data;
                case 3
                    offset(indices(1)) = data;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            me.fcfg.eDerived = derive;
            me.fcfg.eScale = scale;
            me.fcfg.eOffset = offset;

        end
    end
end
