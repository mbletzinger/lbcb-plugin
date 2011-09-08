classdef SubstepsCommandTable < AllStepsCommandTable
    properties
    end
    methods
        function me = SubstepsCommandTable(name,isLbcb1)
            me = me@AllStepsCommandTable(name,isLbcb1);
        end
        function update(me,step)
            if step.stepNum.correctionStep == 0
                me.update@AllStepsCommandTable(step);
            end
        end
    end
end