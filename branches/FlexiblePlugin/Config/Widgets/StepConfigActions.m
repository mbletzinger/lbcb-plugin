classdef StepConfigActions < handle
    properties
        handles = [];
        scfg
        log = Logger
        aps
        ssITable = cell(6,2);
    end
    methods
        function me = StepConfigActions(cfg)
            me.aps = StateEnum({'LBCB1','LBCB2'});
            me.scfg = StepConfigDao(cfg);
            ssI1 = me.scfg.substepIncL1;
            ssI2 = me.scfg.substepIncL2;
            
            for i = 1:6
                if ssI1.dispDofs(i)
                    me.ssITable{i,1} = sprintf('%f',ssI1.disp(i));
                end
                if ssI2.dispDofs(i)
                    me.ssITable{i,2} = sprintf('%f',ssI2.disp(i));
                end
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.DoEdCalc,'Value',me.scfg.doEdCalculations);
            set(me.handles.DoEdCorrection,'Value',me.scfg.doEdCorrection);
            set(me.handles.DoDdCalc,'Value',me.scfg.doDdofCalculations);
            set(me.handles.DoDdCorrection,'Value',me.scfg.doDdofCorrection);
            set(me.handles.SubStepIncrements,'Data',me.ssITable);
            set(me.handles.DoStepSplitting,'Value',me.scfg.doStepSplitting);
            set(me.handles.CorrectionPerSubstep,'String',sprintf('%d',me.scfg.correctEverySubstep));
        
        end
        function setDoStepSplitting(me,value)
            me.scfg.doStepSplitting = value;
        end
        function setCorrectionPerSubstep(me,str)
            value = sscanf(str,'%d');
            if isempty(value)
                me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
                return;
            end
            me.scfg.correctEverySubstep = value;
        end
        function setDoEdCalculations(me,value)
            me.scfg.doEdCalculations = value;
        end
        function setDoEdCorrection(me,value)
            me.scfg.doEdCorrection = value;
        end
        function setDoDdofCalculations(me,value)
            me.scfg.doDdofCalculations = value;
        end
        function setDoDdofCorrection(me,value)
            me.scfg.doDdofCorrection = value;
        end
        function setSsICell(me,indices,str)
            if indices(2) == 1
                ssI = me.scfg.substepIncL1;
            else
                ssI = me.scfg.substepIncL2;
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
                me.scfg.substepIncL1 = ssI;
            else
                me.scfg.substepIncL2 = ssI;
            end            
        end
    end
end
