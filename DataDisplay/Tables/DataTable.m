classdef DataTable < handle
    properties
        name = '';
        steps = cell(3,1);
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        rnames
        data
        cdp
        plot
        rowsize
        idx
        isLbcb1
    end
    methods
        function me = DataTable(name,isLbcb1)
            me.name = name;
            me.isLbcb1 = isLbcb1;
            lt = length(me.cnames);
            me.plot = DisplayTable(name,me.cnames);
            me.rowsize = 20;
            me.data = cell(me.rowsize,lt);
            me.idx = 0;
        end
        function displayMe(me)
            me.plot.displayMe();
        end
        function undisplayMe(me)
            me.plot.undisplayMe();
        end
        function update(me,step)
            row = me.genRow(step);
            if me.idx == 0
                me.data(1,:) = row;
                me.rnames{1} =  regexprep(step.stepNum.toString(),'\t',',');
                me.idx = me.idx + 1;
                return;
            end
            if me.idx < me.rowsize
                me.data(2:me.idx + 1,:) = me.data(1:me.idx,:);
                me.rnames(2:me.idx+1,1) = me.rnames(1:me.idx,1);
                me.idx = me.idx + 1;
            else
                me.data(2:me.rowsize,:) = me.data(1:(me.rowsize - 1),:);
                me.rnames(2:me.rowsize,1) = me.rnames(1:(me.rowsize - 1),1);
            end
            me.data(1,:) = row;
            me.rnames{1} = regexprep(step.stepNum.toString(),'\t',',');
            me.plot.update(me.data,me.rnames);
        end
        function setCnames(me,cnames)
            me.cnames = cnames;
            me.data = cell(me.rowsize,length(me.cnames));
            if me.plot.isDisplayed
                set(me.plot.table,'ColumnName',cnames);
            end
            me.plot.cnames = cnames;
        end
    end
    methods (Abstract)
        row = genRow(me, step)
    end
end