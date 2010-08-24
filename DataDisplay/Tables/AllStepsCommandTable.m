classdef AllStepsCommandTable < DataTable
    properties
    end
    methods
        function me = AllStepsCommandTable(name)
            me = me@DataTable(name);
        end
        function row = genRow(me, step)
            lt = length(me.cnames);
            row = cell(1,lt);
            if me.cdp.numLbcbs() == 2
                r = [ step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force' ...
                    step.lbcbCps{2}.command.disp' step.lbcbCps{2}.command.force' ];
            else
                r = [ step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force' ];
            end
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end