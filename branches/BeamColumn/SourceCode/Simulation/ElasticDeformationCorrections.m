classdef elasticDeformationCorrections <handle
    properties
        tolerances = [];
        differences = [];
        commands = [];
        offsets = [];
        transform = {};
    end
    methods
        function me = elasticDeformation(tolerances,transform)
            me.transform = transform;
            me.tolerances = tolerances; 
        end
        function isWithinTolerances = checkTolerances(me,tgt,measurements)
            me.differences = me.transform.model2Lbcb(tgt) - (measurements - me.offsets);
            isWithinTolerances = abs(me.differences) <= me.tolerances; 
        end
        function newTarget(me,tgt_increment)
            me.commands = me.commands + me.transform.model.model2Lbcb(tgt_increment);
        end
        function adjustCommands(me)
            me.commands = me.differences + me.commands;
        end
    end
end