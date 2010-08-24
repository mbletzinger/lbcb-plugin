classdef ResponseTable < DataTable
    properties
    end
    methods
        function me = ResponseTable(name)
            me = me@DataTable(name);
        end
        function row = genRow(me, step)
            lt = length(me.cnames);
            row = cell(1,lt);
            if me.cdp.numLbcbs() == 2
                r = [ step.lbcbCps{1}.response.disp' step.lbcbCps{1}.response.force' ...
                    step.lbcbCps{2}.response.disp' step.lbcbCps{2}.response.force' ];
            else
                r = [ step.lbcbCps{1}.response.disp' step.lbcbCps{1}.response.force' ];
            end
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end