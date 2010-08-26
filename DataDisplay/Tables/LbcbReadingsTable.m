classdef LbcbReadingsTable < DataTable
    properties
    end
    methods
        function me = LbcbReadingsTable(name,isLbcb1)
            me = me@DataTable(name,isLbcb1);
        end
        function row = genRow(me, step)
            cpsidx = (me.isLbcb1 == false) + 1;
            lt = length(me.cnames);
            row = cell(1,lt);
            r = [ step.lbcbCps{cpsidx}.response.lbcb.disp' step.lbcbCps{cpsidx}.response.lbcb.force' ];
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end