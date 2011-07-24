classdef CommandLimitsConfigActions < TableDataManagement
    properties
        handles
        limitsTable
        log = Logger('CommandLimitsConfigActions')
        selectedRow
        step
        cl
    end
    methods
        function me = CommandLimitsConfigActions(cl,step)
            me.step = step;
            me.cl = cl;
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
            [lower upper used logical] = me.getCfg();
            current = zeros(12,1);
            if isempty(me.step) == false
                if me.isLbcb1()
                    [ disp dD force fD] = me.step.lbcbCps{1}.cmdData(); %#ok<ASGLU>
                else
                    [ disp dD force fD] = me.step.lbcbCps{2}.cmdData(); %#ok<ASGLU>
                end
                current = [ disp' force'];
            end
            for i = 1:12
                if used(i)
                    me.limitsTable{i,1} = sprintf('%9.7e',lower(i));
                    me.limitsTable{i,2} = sprintf('%9.7e',upper(i));
                    me.limitsTable{i,3} = sprintf('%9.7e',current(i));
                end
                me.limitsTable{i,4} = (logical(i,1) || logical(i,2));
            end
            set(me.handles.LimitsTable,'Data',me.limitsTable);
        end
        function recalculate(me)
            me.cl.withinLimits(me.step);
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
            [ d u ] = me.getData(data);
            if indices(2) == 1
                lo = d;
            else
                up = d;
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
            me.recalculate();
            me.fill();
        end
        function [lower upper used faults] = getCfg(me)
            me.cl.getLimits();
            cfg = me.cl.limits;
            if me.isLbcb1()
                upper = cfg.upper1;
                lower = cfg.lower1;
                used = cfg.used1;
                faults = me.cl.faults1;
            else
                upper = cfg.upper2;
                lower = cfg.lower2;
                used = cfg.used2;
                faults = me.cl.faults2;
            end
        end
    end
end