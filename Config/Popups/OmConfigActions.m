classdef OmConfigActions < handle
    properties
        handles = [];
        table;
        ocfg
        log = Logger('OmConfigActions')
        aps
        pertTable = cell(6,2);
        selected;
    end
    methods
        function me = OmConfigActions(cfg)
            me.aps = StateEnum({'LBCB1','LBCB2','BOTH'});
            me.ocfg = OmConfigDao(cfg);
            me.selected = 1;
            if me.ocfg.empty
                me.addSensor(0);
            else
                me.uDisplay(0);
            end
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
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<UNRCH>
            end
            if indices(1) > me.ocfg.numExtSensors
                me.ocfg.addSensor();
            end
                    names = me.ocfg.sensorNames;
                    apply = me.ocfg.apply2Lbcb;
                    sens = me.ocfg.sensitivities;
                    bs = me.ocfg.base;
                    pl = me.ocfg.plat;
                    err = me.ocfg.sensorErrorTol;
            switch indices(2)
                case 1
                    names{indices(1)} = data;
                    me.ocfg.sensorNames = names;
                case 2
                    apply{indices(1)} = data;
                    me.ocfg.apply2Lbcb = apply;
                case 3
                    sens(indices(1)) = data;
                    me.ocfg.sensitivities = sens;
                case { 4 5 6 }
                    bs{indices(1)}(indices(2) - 3) = data;
                    me.ocfg.base = bs;
                case { 7 8 9 }
                    pl{indices(1)}(indices(2) - 6) = data;
                    me.ocfg.plat = pl;
                case 10
                    err(indices(1)) = data;
                    me.ocfg.sensorErrorTol = err;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            me.uDisplay(1);
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.sensorTable,'Data',me.table);
            format = {'char',me.aps.states,'numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.sensorTable,'ColumnFormat',format);
             set(me.handles.numLbcbs,'String',{'1','2'});
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);
            set(me.handles.useFakeOm,'Value',me.ocfg.useFakeOm);
            set(me.handles.pertTable,'Data',me.pertTable);
        
        end
        function setNumLbcbs(me,value)
            me.ocfg.numLbcbs = value;
        end
        function setUseFakeOm(me,value)
            me.ocfg.useFakeOm = value;
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
        function addSensor(me,haveHandle)
            me.ocfg.addSensor();
            me.uDisplay(haveHandle);
        end
        function removeSensor(me,haveHandle)
            me.table(me.selected,:) = [];
            me.ocfg.removeSensor(me.selected);
            if me.selected > me.ocfg.numExtSensors
                me.selected = me.ocfg.numExtSensors;
            end
            me.uDisplay(haveHandle);
        end
        function uDisplay(me,haveHandle)
            names = me.ocfg.sensorNames;
            apply = me.ocfg.apply2Lbcb;
            sens = me.ocfg.sensitivities;
            bs = me.ocfg.base;
            pl = me.ocfg.plat;
            err = me.ocfg.sensorErrorTol;
            me.table = cell(me.ocfg.numExtSensors,10);
            for s = 1:me.ocfg.numExtSensors
                me.table{s,1} = names{s};
                me.table{s,2} = apply{s};
                me.table{s,3} = sens(s);
                me.table{s,4} = bs{s}(1);
                me.table{s,5} = bs{s}(2);
                me.table{s,6} = bs{s}(3);
                me.table{s,7} = pl{s}(1);
                me.table{s,8} = pl{s}(2);
                me.table{s,9} = pl{s}(3);
                me.table{s,10} = err(s);
            end
            if haveHandle
            set(me.handles.sensorTable,'Data',me.table);
            end
        end
    end
end
