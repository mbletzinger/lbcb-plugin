classdef CommandLimitsConfigActions < handle
    properties
        handles
        limitsTable
        log = Logger('CommandLimitsConfigActions')
        selectedRow
        step
        cl
    end
    methods
        function me = CommandLimitsConfigActions(cfg,step)
            me.step = step;
            me.cl = CommandLimits(cfg);
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
            format = {'char','char','numeric','logical'};
            set(me.handles.LimitsTable,'ColumnFormat',format);
            set(me.handles.Lbcb,'String',{'LBCB 1','LBCB 2'});
            set(me.handles.Lbcb,'Value',1);
            me.fill();
        end
        function fill(me)
            me.limitsTable = cell(12,4);
            [lower upper used] = me.getCfg();
            if me.isLbcb1()
                [logical current ] = me.cl.wL(me.step.lbcbCps{1}.command,lower, upper, used);
            else
                [logical current ] = me.cl.wL(me.step.lbcbCps{2}.command,lower, upper, used);
            end
            for i = 1:12
                if used(i)
                    me.limitsTable{i,1} = sprintf('%f',lower(i));
                    me.limitsTable{i,2} = sprintf('%f',upper(i));
                end
                me.limitsTable{i,3} = current(i);
                me.limitsTable{i,4} = logical(i,1) | logical(i,2);
            end
            set(me.handles.LimitsTable,'Data',me.limitsTable);
        end
        function setCell(me,indices,data)
            r = indices(1);
                lo = 0;
                up = 0;
                u = false;
            if isempty(me.limitsTable{r,1}) == false
                lo = str2double(me.limitsTable{r,1});
            end
            if isempty(me.limitsTable{r,2}) == false
                up = str2double(me.limitsTable{r,2});
            end
            if isempty(data) == false
                if indices(2) == 1
                    lo = str2double(data);
                else
                    up = str2double(data);
                end
                u = true;
            end
            [lower upper used] = me.getCfg();
            lower(r) = lo;
            upper(r) = up;
            used(r) = u;
            cfg = me.cl.limits;
            if me.isLbcb1()
                cfg.lower1 = lower;
                cfg.upper1 = upper;
                cfg.used1 = used;
            else
                cfg.lower2 = lower;
                cfg.upper2 = upper;
                cfg.used2 = used;
            end
            me.fill();
        end
        function [lower upper used] = getCfg(me)
            me.cl.getLimits();
            cfg = me.cl.limits;
            if me.isLbcb1()
                upper = cfg.upper1;
                lower = cfg.lower1;
                used = cfg.used1;
            else
                upper = cfg.upper2;
                lower = cfg.lower2;
                used = cfg.used2;
            end
        end
    end
end