classdef OmConfigActions < handle
    properties
        handles = [];
        table;
        ocfg
        log = Logger('OmConfigActions')
        aps
        correctTable
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
                case 10
                    o.sensorErrorTol = data;
                case 11
                    o.sensorLower = data;
                case 12
                    o.sensorUpper = data;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            o.setMe();
            me.uDisplay();
        end
        function initialize(me,handles)
            me.handles = handles;
            cor1 = me.ocfg.needsCorrectionL1;
            cor2 = me.ocfg.needsCorrectionL2;
            me.correctTable = false(6,2);
            for i = 1:6
                if isempty(cor1) == false
                    me.correctTable(i,1) = cor1(i);
                end
                if isempty(cor2) == false
                    me.correctTable(i,2) = cor2(i);
                end
            end
            set(me.handles.sensorTable,'Data',me.table);
            format = {'char',me.aps.states,'numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.sensorTable,'ColumnFormat',format);
            set(me.handles.numLbcbs,'String',{'1','2'});
            
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);       
            set(me.handles.transPert,'String',sprintf('%9.7e',me.ocfg.transPert));
            set(me.handles.rotPert,'String',sprintf('%9.7e',me.ocfg.rotPert));
            set(me.handles.maxFunEvals,'String',sprintf('%d',me.ocfg.optsetMaxFunEvals));
            set(me.handles.maxIter,'String',sprintf('%d',me.ocfg.optsetMaxIter));
            set(me.handles.tolFun,'String',sprintf('%9.7e',me.ocfg.optsetTolFun));
            set(me.handles.tolX,'String',sprintf('%9.7e',me.ocfg.optsetTolX));
            set(me.handles.jacob,'Value',me.ocfg.optsetJacob);
            
            set(me.handles.correctionTable,'Data',me.correctTable);
            me.uDisplay();
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
        
        function setCorrectCell(me,indices,str)
            if indices(2) == 1
                pert = me.ocfg.needsCorrectionL1;
            else
                pert = me.ocfg.needsCorrectionL2;
            end
            if isempty(pert)
                pert = zeros(6,1);
            end
            pert(indices(1)) = str;
            if indices(2) == 1
                me.ocfg.needsCorrectionL1 = pert;
            else
                me.ocfg.needsCorrectionL2 = pert;
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
        function uDisplay(me)
            me.table = cell(me.ocfg.numExtSensors,10);
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
                me.table{s,10} = o.sensorErrorTol;
                me.table{s,11} = o.sensorLower;
                me.table{s,12} = o.sensorUpper;
            end
            set(me.handles.sensorTable,'Data',me.table);
        end
    end
end
