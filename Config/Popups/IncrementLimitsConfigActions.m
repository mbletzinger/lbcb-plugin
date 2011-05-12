classdef IncrementLimitsConfigActions < handle
    properties
        handles
        limitsTable
        log = Logger('IncrementLimitsConfigActions')
        selectedRow
        ilcfg
        pstep
        cstep
        il
    end
    methods
        function me = IncrementLimitsConfigActions(cfg,pstep,cstep)
            me.ilcfg = WindowLimitsDao('increment.limits',cfg);
            me.pstep = pstep;
            me.cstep = cstep;
            me.il = IncrementLimits(cfg);
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
            [limits used] = me.getCfg();
            if me.isLbcb1()
                [logical increments ] = me.il.wL(me.cstep.lbcbCps{1}.command,me.pstep.lbcbCps{1}.command,limits, used);
            else
                [logical increments ] = me.il.wL(me.cstep.lbcbCps{2}.command,me.pstep.lbcbCps{2}.command,limits, used);
            end
            for i = 1:12
                if used(i)
                    me.limitsTable{i,1} = sprintf('%f',limits(i));
                end
                me.limitsTable{i,2} = increments(i);
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
            if isempty(data) == false
                if ischar(data)
                    nli = str2double(data);
                    if isnan(nli) == false
                        li = nli;
                        u = true;
                    end
                else
                    li = data;
                    u = true;
                end
            end
            [limits used] = me.getCfg();
            limits(r) = li;
            used(r) = u;
            if me.isLbcb1()
                me.ilcfg.window1 = limits;
                me.ilcfg.used1 = used;
            else
                me.ilcfg.window2 = limits;
                me.ilcfg.used2 = used;
            end
            me.fill();
        end
        
        function [limits used] = getCfg(me)
            if me.isLbcb1()
                limits = me.ilcfg.window1;
                used = me.ilcfg.used1;
            else
                limits = me.ilcfg.window2;
                used = me.ilcfg.used2;
            end
        end
    end
end