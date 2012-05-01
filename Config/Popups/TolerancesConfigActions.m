classdef TolerancesConfigActions < TableDataManagement
    properties
        handles
        limitsTable
        log = Logger('TolerancesConfigActions')
        selectedRow
        tl
        correctionTarget
        currentResponse
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
        
        function setResponse(me,resp)
            me.currentResponse = resp;
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
        function setCell(me,indices,data)
            r = indices(1);
            li = 0;
            [li u ] = me.getData(data);
            [limits used] = me.getCfg();
            limits(r) = li;
            used(r) = u;
            me.tl.setWindow(limits,used);
            if isempty(me.correctionTarget) || isempty(me.currentResponse)
                return;
            end
            me.tl.withinTolerances(me.correctionTarget, me.currentResponse);
            me.fill();
        end
        
        function [limits used diffs within] = getCfg(me)
            me.tl.getWindow();
            limits = me.tl.window;
            used = me.tl.used;
            diffs = me.tl.diffs;
            within = me.tl.within;
        end
    end
end