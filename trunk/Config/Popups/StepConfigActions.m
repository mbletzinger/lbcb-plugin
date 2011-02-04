classdef StepConfigActions < handle
    properties
        handles = [];
        stcfg
        sccfg
        log = Logger('StepConfigActions');
        aps
        ssITable
        correctionTable
        flist
        blist
    end
    methods
        function me = StepConfigActions(cfg)
            me.ssITable = cell(6,2);
            me.correctionTable = cell(5,5);
            me.stcfg = StepTimingConfigDao(cfg);
            me.sccfg = StepCorrectionConfigDao(cfg);
            ssI1 = me.stcfg.substepIncL1;
            ssI2 = me.stcfg.substepIncL2;
            flabels = FunctionLists('StepCorrections');            
            me.blist = { 'Disabled' 'Enabled'};
            me.flist = {'<NONE>',flabels.list{:}};
            for i = 1:6
                if ssI1.dispDofs(i)
                    me.ssITable{i,1} = sprintf('%f',ssI1.disp(i));
                end
                if ssI2.dispDofs(i)
                    me.ssITable{i,2} = sprintf('%f',ssI2.disp(i));
                end
            end
            sz = size(me.correctionTable);
            for i = 1:sz(1)
                for j = 1:sz(2)
                    me.correctionTable{i,j} = me.loadValue(i,j);
                end
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.SubStepIncrements,'Data',me.ssITable);
            set(me.handles.DoStepSplitting,'Value',me.stcfg.doStepSplitting);
            set(me.handles.CorrectionPerSubstep,'String',sprintf('%d',me.stcfg.correctEverySubstep));
            set(me.handles.CorrectionTable,'Data',me.correctionTable);
            format = {me.blist,me.blist,me.flist,me.flist,me.flist};
            set(me.handles.CorrectionTable,'ColumnFormat',format);
            patf = me.sccfg.prelimAdjustTargetFunctions;
            set(me.handles.edPrelimAdjust,'String',me.flist);
            if isempty(patf) == false
                val = me.locate(me.flist,patf{1});
            else
                val = 1;
            end
            set(me.handles.edPrelimAdjust,'Value',val);
            set(me.handles.ddPrelimAdjust,'String',me.flist);
            if isempty(patf) == false
                val = me.locate(me.flist,patf{2});
            else
                val = 1;
            end
            set(me.handles.ddPrelimAdjust,'Value',val);
            
            yes = 0;
            if me.stcfg.correctEverySubstep > 0
                
                yes = 1;
            end
            
            set(me.handles.substepTriggering,'String',sprintf('%d',me.stcfg.triggerEverySubstep));
            set(me.handles.triggerDelay,'String',sprintf('%d',me.stcfg.triggerDelay));
            yes = 0;
            if me.stcfg.triggerEverySubstep > 0
                
                yes = 1;
            end
            set(me.handles.doSubstepTriggering,'Value',yes);

        end
        function setDoStepSplitting(me,value)
            me.stcfg.doStepSplitting = value;
        end
        function setCorrectionPerSubstep(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return;
            end
            me.stcfg.correctEverySubstep = value;
        end
        function setTriggeringPerSubstep(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return;
            end
            me.stcfg.triggerEverySubstep = value;
        end
        function setTriggeringDelay(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return;
            end
            me.stcfg.triggerDelay = value;
        end
        function setSsICell(me,indices,str)
            if indices(2) == 1
                ssI = me.stcfg.substepIncL1;
            else
                ssI = me.stcfg.substepIncL2;
            end
            if strcmp(str,'') || isempty(str)
                ssI.dispDofs(indices(1)) = 0;
            else
                data = sscanf(str,'%f');
                if isempty(data)
                    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                    return;
                end
                ssI.setDispDof(indices(1),data);
            end
            if indices(2) == 1
                me.stcfg.substepIncL1 = ssI;
            else
                me.stcfg.substepIncL2 = ssI;
            end            
        end
        function setCorrectionCell(me,indices,str)
            % hObject    handle to CorrectionTable (see GCBO)
            % eventdata  structure with the following fields (see UITABLE)
            %	Indices: row and column indices of the cell(s) edited
            %	PreviousData: previous data for the cell(s) edited
            %	EditData: string(s) entered by the user
            %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
            %	Error: error string when failed to convert EditData to appropriate value for Data
            me.saveValue(indices(1), indices(2),str);
        end
        function setPrelimAdjust(me,str,idx)
            patf = me.sccfg.prelimAdjustTargetFunctions;
            patf{idx} = me.flist{str};
            me.sccfg.prelimAdjustTargetFunctions = patf;
        end
        function saveValue(me,row,column,value)
            cfg = me.sccfg;
            switch column
                case {1 2}
                    me.saveBoolValue(row,column,value);
                    return;
                case 3
                    cols = cfg.calculationFunctions;
                    lst = me.flist;
                    fil = lst;
                case 4
                    cols = cfg.needsCorrectionFunctions;
                    lst = me.flist;
                    fil = lst;
                case 5
                    cols = cfg.adjustTargetFunctions;
                    lst = me.flist;
                    fil = lst;
            end
            str = value;
            lgt = size(me.correctionTable,1);
            if isempty(cols)
                cols = cell(lgt,1);
                for i = 1:lgt
                    cols{i} = fil{1};
                end
            end
            cols{row} = str;
            switch column
                case 3
                    cfg.calculationFunctions = cols;
                case 4
                    cfg.needsCorrectionFunctions = cols;
                case 5
                    cfg.adjustTargetFunctions = cols;
            end            
        end
        function saveBoolValue(me,row,column,str)
            cfg = me.sccfg;
            switch column
                case 1
                    cols = cfg.doCalculations;
                case 2
                    cols = cfg.doCorrections;
            end
            value = me.locate(me.blist,str);
            lgt = size(me.correctionTable,1);
            if isempty(cols)
                cols = zeros(lgt,1);
            end
            cols(row) = value - 1;  % 1, 2 turns into 0,1
            switch column
                case 1
                    cfg.doCalculations = cols;
                case 2
                    cfg.doCorrections = cols;
            end            
        end
        function value = loadValue(me,row,column)
            cfg = me.sccfg;
            switch column
                case { 1 2 }
                    value = me.loadBoolValue(row,column);
                    return;
                case 3
                    cols = cfg.calculationFunctions;
                    lst = me.flist;
                case 4
                    cols = cfg.needsCorrectionFunctions;
                    lst = me.flist;
                case 5
                    cols = cfg.adjustTargetFunctions;
                    lst = me.flist;
            end
            if isempty(cols)
                value = lst{1};
                return;
            end
            if length(cols) < row
                value = lst{1};
                return;
            end
            value = cols{row};
        end
        function value = loadBoolValue(me,row,column)
            cfg = me.sccfg;
            lst = me.blist;
            switch column
                case 1
                    cols = cfg.doCalculations;
                case 2
                    cols = cfg.doCorrections;
            end
            if isempty(cols)
                value = lst{1};
                return;
            end
            if length(cols) < row
                value = lst{1};
                return;
            end
            value = lst{cols(row) + 1};
        end
        function value = locate(me,list,item)
            tmp = find(strcmp(list,item));
            if isempty(tmp)
                value = 1;
                return;
            end
            value = tmp(1);
        end
    end
end
