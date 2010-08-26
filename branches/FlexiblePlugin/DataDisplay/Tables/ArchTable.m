classdef ArchTable < DataTable
    properties
        cnamesSet
    end
    methods
        function me = ArchTable(name)
            me = me@DataTable(name,1);
            me.cnamesSet = false;
        end
        function update(me,step)
            if isempty(step.cData.values) == false
                if me.cnamesSet == false
                    me.cnamesSet = true;
                    me.setCnames(step.cData.labels);
                end
                me.update@DataTable(step);
            end
        end
        function row = genRow(me, step) %#ok<MANU>
            lt = length(step.cData.values);
            row = cell(1,lt);
            r = step.cData.values;
            for i = 1:lt
                row{i} = sprintf('%+12.7e',r(i));
            end
        end
    end
end