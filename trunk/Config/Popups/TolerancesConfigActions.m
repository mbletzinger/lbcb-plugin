classdef TolerancesConfigActions < TableDataManagement
    properties
        handles
        limitsTable
        log = Logger('TolerancesConfigActions')
        selectedRow
        tl
        correctionTarget
        currentStep
        isLbcb1
    end
    methods
        function me = TolerancesConfigActions(tl, isLbcb1)
            me.tl = tl;
            me.isLbcb1 = isLbcb1;
        end
        function select(me,indices)
            if isempty(indices)
                return;
            end
            me.selectedRow = indices(1);
        end
        function initialize(me,handles)
            me.handles = handles;
            format = {'char','numeric','logical'};
            set(me.handles,'ColumnFormat',format);
            me.fill();
        end
        
        function setStep(me,step)
            me.currentStep = step;
        end
        function setTarget(me,target)
            me.correctionTarget = target;
        end
        function fill(me)
            me.limitsTable = cell(6,3);
            [limits used diffs within] = me.getCfg();
            for i = 1:6
                if used(i)
                    me.limitsTable{i,1} = sprintf('%f',limits(i));
                    me.limitsTable{i,2} = diffs(i);
                end
                me.limitsTable{i,3} = (within(i) == false);
            end
            set(me.handles,'Data',me.limitsTable);
        end
        function recalculate(me)
            if isempty(me.correctionTarget) || isempty(me.currentStep)
                return;
            end
            if me.isLbcb1()
                stpT = me.tl{1};
                target = me.correctionTarget.lbcbCps{1}.command;
                response = me.currentStep.lbcbCps{1}.response;
            else
                stpT = me.tl{2};
                target = me.correctionTarget.lbcbCps{2}.command;
                response = me.currentStep.lbcbCps{2}.response;
            end
            me.fill();
        end
        function setCell(me,indices,data)
            r = indices(1);
            li = 0;
            [li u ] = me.getData(data);
            [limits used] = me.getCfg();
            limits(r) = li;
            used(r) = u;
            if me.isLbcb1()
                me.tl{1}.setWindow(limits,used);
            else
                me.tl{2}.setWindow(limits,used);
            end
            me.recalculate();
        end
        
        function [limits used diffs within] = getCfg(me)
            stpT = me.tl{2};
            if me.isLbcb1()
                stpT = me.tl{1};
            end
            stpT.getWindow();
            limits = stpT.window;
            used = stpT.used;
            diffs = stpT.diffs;
            within = stpT.within;
        end
    end
end