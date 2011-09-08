classdef OmConfigActions < handle
    properties
        handles = [];
        table;
        corTable;
        ocfg
        log = Logger('OmConfigActions')
        aps
        selected;
        oesl
    end
    methods
        function me = OmConfigActions(cfg)
            me.aps = StateEnum({'LBCB1','LBCB2','BOTH'});
            me.ocfg = OmConfigDao(cfg);
            me.selected = 1;
            me.oesl = OmExternalSensorList(cfg);
            me.corTable = cell(6,2);

            icl1 = me.ocfg.initialCorrectionL1;
            icl2 = me.ocfg.initialCorrectionL2;
            for i = 1:6
                if icl1.dispDofs(i)
                    me.corTable{i,1} = sprintf('%f',icl1.disp(i));
                end
                if icl2.dispDofs(i)
                    me.corTable{i,2} = sprintf('%f',icl2.disp(i));
                end
            end
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
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
                    o.fixedLocations(indices(2) - 3) = data;
                case { 7 8 9 }
                    o.pinLocations(indices(2) - 6) = data;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            o.setMe();
            me.uDisplay();
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.numLbcbs,'String',{'1','2'});
            
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);
            set(me.handles.transPert,'String',sprintf('%9.7e',me.ocfg.transPert));
            set(me.handles.rotPert,'String',sprintf('%9.7e',me.ocfg.rotPert));
            set(me.handles.maxFunEvals,'String',sprintf('%d',me.ocfg.optsetMaxFunEvals));
            set(me.handles.maxIter,'String',sprintf('%d',me.ocfg.optsetMaxIter));
            set(me.handles.tolFun,'String',sprintf('%9.7e',me.ocfg.optsetTolFun));
            set(me.handles.tolX,'String',sprintf('%9.7e',me.ocfg.optsetTolX));
            set(me.handles.jacob,'Value',me.ocfg.optsetJacob);
            set(me.handles.InitCor,'Data',me.corTable);
            me.uDisplay();
            set(me.handles.sensorTable,'Data',me.table);
            format = {'char',me.aps.states,'numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.sensorTable,'ColumnFormat',format);
        end
        
        function setNumLbcbs(me,value)
            me.ocfg.numLbcbs = value;
        end
        function setTransPert(me,str)
            value = str2double(str);
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return;
            end
            me.ocfg.transPert = value;
        end
        function setRotPert(me,str)
            value = str2double(str);
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return;
            end
            me.ocfg.rotPert = value;
        end
        function setOptsetMaxFunEvals(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return;
            end
            me.ocfg.optsetMaxFunEvals = value;
        end
        function setOptsetMaxIter(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return;
            end
            me.ocfg.optsetMaxIter = value;
        end
        function setOptsetTolFun(me,str)
            value = str2double(str);
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return; %#ok<*UNRCH>
            end
            me.ocfg.optsetTolFun = value;
        end
        function setOptsetTolX(me,str)
            value = str2double(str);
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a number', str));
                return;
            end
            me.ocfg.optsetTolX = value;
        end
        function setOptsetJacob(me,value)
            me.ocfg.optsetJacob = value;
        end
        
        function selectedRow(me,indices)
            if isempty(indices)
                return;
            end
            me.selected = indices(1);
        end
        function addSensor(me)
            me.oesl.insertSensor(me.selected)
            me.uDisplay();
        end
        function removeSensor(me)
            me.oesl.removeSensor(me.selected)
            me.uDisplay();
        end
        function upSensor(me)
            me.oesl.upSensor(me.selected)
            me.uDisplay();
        end
        function downSensor(me)
            me.oesl.downSensor(me.selected)
            me.uDisplay();
        end
        
        function setCorrection(me,indices,str)
            if indices(2) == 1
                icl = me.ocfg.initialCorrectionL1;
            else
                icl = me.ocfg.initialCorrectionL2;
            end
            if strcmp(str,'') || isempty(str)
                icl.dispDofs(indices(1)) = 0;
            else
                data = sscanf(str,'%f');
                if isempty(data)
                    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                    return; %#ok<UNRCH>
                end
                icl.setDispDof(indices(1),data);
            end
            if indices(2) == 1
                me.ocfg.initialCorrectionL1 = icl;
            else
                me.ocfg.initialCorrectionL2 = icl;
            end
        end
        
        function uDisplay(me)
            me.table = cell(me.ocfg.numExtSensors,9);
            for s = 1:me.ocfg.numExtSensors
                o = me.oesl.list{s};
                me.table{s,1} = o.sensorName;
                me.table{s,2} = o.apply2Lbcb;
                me.table{s,3} = o.sensitivity;
                if isempty(o.fixedLocations) == false
                    me.table{s,4} = o.fixedLocations(1);
                    me.table{s,5} = o.fixedLocations(2);
                    me.table{s,6} = o.fixedLocations(3);
                end
                if isempty(o.pinLocations) == false
                    me.table{s,7} = o.pinLocations(1);
                    me.table{s,8} = o.pinLocations(2);
                    me.table{s,9} = o.pinLocations(3);
                end
            end
        end
    end
end
