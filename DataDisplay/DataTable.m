classdef DataTable < handle
    properties
        name = '';
        table = [];
        steps = cell(3,1);
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        rnames
        data
        cdp
        plot
        rowsize
    end
    methods
        function me = DataTable(name)
            me.name = name;
            if me.cdp.numLbcbs() == 2
                lt = length(me.cnames);
                cn = cell(lt * 2,1);
                for i = 1: lt
                    cn{i} = sprintf('L1 %s',me.cnames{i});
                    cn{i + lt} = sprintf('L2 %s',me.cnames{i});
                end
            else
                cn = me.cnames;
            end
            me.plot = DataTable(name,cn);
            me.rowsize = 40;
        end
        function update(me,step)
            sz = size(me.data,1);
            row = me.genRow(step);
            if sz <= me.rowsize
                me.data{2:sz + 1,:} = me.data{1:sz,:};
                me.rnames{2:sz,1} = me.rnames{1:sz,1};
            else
                me.data{2:me.rowsize,:} = me.data{1:(me.rowsize - 1),:};
                me.rnames{2:me.rowsize,1} = me.rnames{1:(me.rowsize - 1),1};
            end
            me.data(1,:) = row;
            me.rnames{1} = step.stepNum.toString();
            me.plot.update(me.data,me.rnames);
        end
    end
    methods (Abstract)
        row = genRow(me, step)
    end
end