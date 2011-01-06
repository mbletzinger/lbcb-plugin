classdef AllStepsCommandTable < DataTable
    properties
    end
    methods
        function me = AllStepsCommandTable(name,isLbcb1)
            me = me@DataTable(name,isLbcb1);
        end
        function row = genRow(me, step)
            cpsidx = (me.isLbcb1 == false) + 1;
            lt = length(me.cnames);
            row = cell(1,lt);
            if me.cdp.numLbcbs() < 2 && me.isLbcb1 == false
                return;
            end
            r = [ step.lbcbCps{cpsidx}.command.disp' step.lbcbCps{cpsidx}.command.force' ];
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end