classdef IncrementLimitsConfigActions < TableDataManagement
    properties
        handles
        limitsTable
        log = Logger('IncrementLimitsConfigActions')
        selectedRow
        pstep
        cstep
        il
    end
    methods
        function me = IncrementLimitsConfigActions(il,pstep,cstep)
            me.pstep = pstep;
            me.cstep = cstep;
            me.il = il;
        end
        function select(me,indices)
            if isempty(indices)
                return;
            end
            me.selectedRow = indices(1);
        end
        function yes = isLbcb1(me)
            yes = false;
            val = get(me.handles.Lbcb, 'Value');
            if val == 1
                yes = true;
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            format = {'char','numeric','logical'};
            set(me.handles.LimitsTable,'ColumnFormat',format);
            set(me.handles.Lbcb,'String',{'LBCB 1','LBCB 2'});
            set(me.handles.Lbcb,'Value',1);
            me.fill();
        end
        function fill(me)
            me.limitsTable = cell(12,3);
            [limits used logical increments] = me.getCfg();
            for i = 1:12
                if used(i)
                    me.limitsTable{i,1} = sprintf('%9.7e',limits(i));
                    me.limitsTable{i,2} = sprintf('%9.7e',increments(i));
                end
                me.limitsTable{i,3} = logical(i);
            end
            set(me.handles.LimitsTable,'Data',me.limitsTable);
        end
        function setCell(me,indices,data)
            r = indices(1);
            li = 0;
            u = false;
            if isempty(me.limitsTable{r,1}) == false
                li = str2double(me.limitsTable{r,1});
            end
            [li u] = me.getData(data);
            [limits used] = me.getCfg();
            limits(r) = li;
            used(r) = u;
            cfg = me.il.limits;
            if me.isLbcb1()
                cfg.window1 = limits;
                cfg.used1 = used;
            else
                cfg.window2 = limits;
                cfg.used2 = used;
            end
            me.recalculate()
            me.fill();
        end
        function recalculate(me)
            me.il.withinLimits(me.cstep, me.pstep);
        end
        
        function [limits used logical increments] = getCfg(me)
            me.il.getLimits();
            cfg = me.il.limits;
            if me.isLbcb1()
                limits = cfg.window1;
                used = cfg.used1;
                logical = me.il.faults1;
                increments = me.il.increments1;
            else
                limits = cfg.window2;
                used = cfg.used2;
                logical = me.il.faults2;
                increments = me.il.increments2;
            end
        end
    end
end