classdef LbcbReadingsTable < DataTable
    properties
    end
    methods
        function me = LbcbReadingsTable(name)
            me = me@DataTable(name);
        end
        function row = genRow(me, step)
            lt = length(me.cnames);
            row = cell(1,lt);
            if me.cdp.numLbcbs() == 2
                r = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ...
                    step.lbcbCps{2}.response.lbcb.disp' step.lbcbCps{2}.response.lbcb.force' ];
            else
                r = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            end
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end