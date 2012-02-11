classdef StepConfigActions < handle
    properties
        handles = [];
        stcfg
        sccfg
        log = Logger('StepConfigActions');
        aps
        ssITable
        ddCorrectionTable
        edCorrectionTable
        flist
        edlist
        pedlist
        pflist
    end
    methods
        function me = StepConfigActions(cfg)
            me.ssITable = cell(6,2);
            me.edCorrectionTable = cell(1,3);
            me.ddCorrectionTable = cell(4,5);
            me.stcfg = StepTimingConfigDao(cfg);
            me.sccfg = StepCorrectionConfigDao(cfg);
            ssI1 = me.stcfg.substepIncL1;
            ssI2 = me.stcfg.substepIncL2;
            flabels = FunctionLists('StepCorrections');
            me.flist = { 'Test' flabels.list{:}};   %#ok<*CCAT>
            me.edlist = {'Standard','Test', 'Dx Only'};
            me.pflist = { '<NONE>',me.flist{:} };
            me.pedlist = { '<NONE>',me.edlist{:} };
            
            for i = 1:6
                if ssI1.dispDofs(i)
                    me.ssITable{i,1} = sprintf('%f',ssI1.disp(i));
                end
                if ssI2.dispDofs(i)
                    me.ssITable{i,2} = sprintf('%f',ssI2.disp(i));
                end
            end
            
            sz = size(me.edCorrectionTable);
            for j = 1:sz(2)
                me.edCorrectionTable{1,j} = me.loadValue(1,j);
            end

            sz = size(me.ddCorrectionTable);
            for i = 1:sz(1)
                for j = 1:sz(2)
                    me.ddCorrectionTable{i,j} = me.loadValue(i+1,j);
                end
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.SubStepIncrements,'Data',me.ssITable);
            set(me.handles.DoStepSplitting,'Value',me.stcfg.doStepSplitting);
            set(me.handles.AcceptStep,'Value',me.stcfg.acceptStep);
            set(me.handles.CorrectionPerSubstep,'String',sprintf('%d',me.stcfg.correctEverySubstep));

            set(me.handles.ddCorrectionTable,'Data',me.ddCorrectionTable);
            format = {'logical','logical',me.flist,me.flist,me.flist};
            set(me.handles.ddCorrectionTable,'ColumnFormat',format);

            set(me.handles.edCorrectionTable,'Data',me.edCorrectionTable);
            format = {'logical','logical',me.edlist};
            set(me.handles.edCorrectionTable,'ColumnFormat',format);

            patf = me.sccfg.prelimAdjustTargetFunctions;

            set(me.handles.edPrelimAdjust,'String',me.pedlist);
            val = me.locate(me.pedlist,patf{1});
            set(me.handles.edPrelimAdjust,'Value',val);

            set(me.handles.ddPrelimAdjust,'String',me.pflist);
            val = me.locate(me.pflist,patf{2});
            set(me.handles.ddPrelimAdjust,'Value',val);
            
            set(me.handles.substepTriggering,'String',sprintf('%d',me.stcfg.triggerEverySubstep));
            set(me.handles.triggerDelay,'String',sprintf('%d',me.stcfg.triggerDelay));

            
        end
        function setDoStepSplitting(me,value)
            me.stcfg.doStepSplitting = value;
        end
        function setAcceptStep(me,value)
            me.stcfg.acceptStep = value;
        end
        function setCorrectionPerSubstep(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return; %#ok<UNRCH>
            end
            me.stcfg.correctEverySubstep = value;
        end
        function setTriggeringPerSubstep(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return; %#ok<UNRCH>
            end
            me.stcfg.triggerEverySubstep = value;
        end
        function setTriggeringDelay(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return; %#ok<UNRCH>
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
                    return; %#ok<UNRCH>
                end
                ssI.setDispDof(indices(1),data);
            end
            if indices(2) == 1
                me.stcfg.substepIncL1 = ssI;
            else
                me.stcfg.substepIncL2 = ssI;
            end
        end
        function setCorrectionCell(me,indices,str,isdD)
            if isdD
                me.saveValue(indices(1) + 1, indices(2),str);
            else
                me.saveValue(indices(1), indices(2),str);
            end
        end
        function setPrelimAdjust(me,str,idx)
            if idx == 1
                lst = me.pedlist;
            else
                lst = me.pflist;
            end
            patf = me.sccfg.prelimAdjustTargetFunctions;
            patf{idx} = lst{str};
            me.sccfg.prelimAdjustTargetFunctions = patf;
        end
        function saveValue(me,row,column,value)
            cfg = me.sccfg;
            switch column
                case 1
                    cols = cfg.doCalculations;
                    cols(row) = value;
                    cfg.doCalculations = cols;
                    return;
                case 2
                    cols = cfg.doCorrections;
                    cols(row) = value;
                    cfg.doCorrections = cols;
                    return;
                case 3
                    cols = cfg.calculationFunctions;
                case 4
                    cols = cfg.needsCorrectionFunctions;
                case 5
                    cols = cfg.adjustTargetFunctions;
            end
            str = value;
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
        function value = loadValue(me,row,column)
            cfg = me.sccfg;
            switch column
                case 1
                    cols = cfg.doCalculations;
                    value = cols(row) > 0;
                    return;
                case 2
                    cols = cfg.doCorrections;
                    value = cols(row) > 0;
                    return;
                case 3
                    cols = cfg.calculationFunctions;
                case 4
                    cols = cfg.needsCorrectionFunctions;
                case 5
                    cols = cfg.adjustTargetFunctions;
            end
            value = cols{row};
        end
        function value = locate(me,list,item) %#ok<MANU>
            tmp = find(strcmp(list,item));
            if isempty(tmp)
                value = 1;
                return;
            end
            value = tmp(1);
        end
    end
end
