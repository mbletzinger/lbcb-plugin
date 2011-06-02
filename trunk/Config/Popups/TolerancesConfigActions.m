classdef TolerancesConfigActions < TableDataManagement
    properties
        handles
        limitsTable
        log = Logger('TolerancesConfigActions')
        selectedRow
        pstep
        cstep
        tl
    end
    methods
        function me = TolerancesConfigActions(tl)
            me.tl = tl;
        end
        function select(me,indices)
            if isempty(indices)
                return;
            end
            me.selectedRow = indices(1);
        end
        function yes = isLbcb1(me)
            yes = false;
            val = get(me.handles.LbcbChoice, 'Value');
            if val == 1
                yes = true;
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            format = {'char','numeric','logical'};
            set(me.handles.ToleranceTable,'ColumnFormat',format);
            set(me.handles.LbcbChoice,'String',{'LBCB 1','LBCB 2'});
            set(me.handles.LbcbChoice,'Value',1);
            me.fill();
        end
        function setSteps(me,pstep,cstep)
            me.pstep = pstep;
            me.cstep = cstep;
            me.fill();
        end
        function fill(me)
            me.limitsTable = cell(12,3);
            [limits used] = me.getCfg();
            logical = true(12,1);
            increments = zeros(12,1);
            if isempty(me.cstep) == false
            if me.isLbcb1()
                [logical increments ] = me.tl{1}.wL(me.cstep.lbcbCps{1}.command,...
                    me.pstep.lbcbCps{1}.command,limits, used);
            else
                [logical increments ] = me.tl{2}.wL(me.cstep.lbcbCps{2}.command,...
                    me.pstep.lbcbCps{2}.command,limits, used);
            end
            end
            for i = 1:12
                if used(i)
                    me.limitsTable{i,1} = sprintf('%f',limits(i));
                end
                me.limitsTable{i,2} = increments(i);
                me.limitsTable{i,3} = (logical(i) == false);
            end
            set(me.handles.ToleranceTable,'Data',me.limitsTable);
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
            me.fill();
        end
        
        function [limits used] = getCfg(me)
            if me.isLbcb1()
                me.tl{1}.getWindow();
                limits = me.tl{1}. window;
                used = me.tl{1}.used;
            else
                me.tl{2}.getWindow();
                limits = me.tl{2}.window;
                used = me.tl{2}.used;
            end
        end
    end
end