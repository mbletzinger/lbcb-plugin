classdef OmConfigActions < handle
    properties
        handles = [];
        table;
        ocfg
        log = Logger('OmConfigActions')
        aps
        pertTable = cell(6,2);
        selected;
        oesl
    end
    methods
        function me = OmConfigActions(cfg)
            me.aps = StateEnum({'LBCB1','LBCB2','BOTH'});
            me.ocfg = OmConfigDao(cfg);
            me.selected = 1;
            me.oesl = OmExternalSensorList(cfg);
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<UNRCH>
            end
            if indices(1) > me.ocfg.numExtSensors
                me.addSensor();
            end
            o = me.oesl.list{indices(1)};
            switch indices(2)
                case 1
                    o.sensorName = data;
                case 2
                    o.apply2Lbcb = data;
                case 3
                    o.sensitivity = data;
                case { 4 5 6 }
                    o.base(indices(2) - 3) = data;
                case { 7 8 9 }
                    o.plat(indices(2) - 6) = data;
                case 10
                    o.sensorErrorTol = data;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            o.setMe();
            me.uDisplay();
        end
        function initialize(me,handles)
            me.handles = handles;
            pert1 = me.ocfg.perturbationsL1;
            pert2 = me.ocfg.perturbationsL2;
            me.pertTable = cell(6,2);
            for i = 1:6
                if pert1.dispDofs(i)
                    me.pertTable{i,1} = sprintf('%f',pert1.disp(i));
                end
                if pert2.dispDofs(i)
                    me.pertTable{i,2} = sprintf('%f',pert2.disp(i));
                end
            end
            set(me.handles.sensorTable,'Data',me.table);
            format = {'char',me.aps.states,'numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.sensorTable,'ColumnFormat',format);
            set(me.handles.numLbcbs,'String',{'1','2'});
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);
            set(me.handles.pertTable,'Data',me.pertTable);
            me.uDisplay();
            
        end
        function setNumLbcbs(me,value)
            me.ocfg.numLbcbs = value;
        end
        function setPertCell(me,indices,str)
            if indices(2) == 1
                pert = me.ocfg.perturbationsL1;
            else
                pert = me.ocfg.perturbationsL2;
            end
            if strcmp(str,'') || isempty(str)
                pert.dispDofs(indices(1)) = 0;
            else
                data = sscanf(str,'%f');
                if isempty(data)
                    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                    return;
                end
                pert.setDispDof(indices(1),data);
            end
            if indices(2) == 1
                me.ocfg.perturbationsL1 = pert;
            else
                me.ocfg.perturbationsL2 = pert;
            end
        end
        function selectedRow(me,indices)
            if isempty(indices)
                return;
            end
            me.selected = indices(1);
        end
        function addSensor(me)
            me.oesl.insertSensor(me.selected)
            me.oesl.setList();
            me.uDisplay();
        end
        function removeSensor(me)
            me.oesl.removeSensor(me.selected)
            me.oesl.setList();
            me.uDisplay();
        end
        function upSensor(me)
            me.oesl.upSensor(me.selected)
            me.oesl.setList();
            me.uDisplay();
        end
        function downSensor(me)
            me.oesl.downSensor(me.selected)
            me.oesl.setList();
            me.uDisplay();
        end
        function uDisplay(me)
            me.table = cell(me.ocfg.numExtSensors,10);
            for s = 1:me.ocfg.numExtSensors
                o = me.oesl.list{s};
                me.table{s,1} = o.sensorName;
                me.table{s,2} = o.apply2Lbcb;
                me.table{s,3} = o.sensitivity;
                if isempty(o.base) == false
                    me.table{s,4} = o.base(1);
                    me.table{s,5} = o.base(2);
                    me.table{s,6} = o.base(3);
                end
                if isempty(o.plat) == false
                    me.table{s,7} = o.plat(1);
                    me.table{s,8} = o.plat(2);
                    me.table{s,9} = o.plat(3);
                end
                me.table{s,10} = o.sensorErrorTol;
            end
            set(me.handles.sensorTable,'Data',me.table);
        end
    end
end
