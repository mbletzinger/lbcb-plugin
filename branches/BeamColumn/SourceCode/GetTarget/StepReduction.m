classdef StepReduction < handle
    properties
        cfgStepSize = 0; % config
        numSteps = 0;
        targetChange = [];
        target = [];
        subStepTargets = targetSequence();
    end
    methods
        function me = StepReduction()
            config = ConfigSimulationParameters();
            me.cfgStepSize = config.cfgStepSize;
        end
        function needsReduction = setTarget(me,target)
            me.targetChange = target - me.target;
           numStepsV = abs(me.targetChange)./me.cfgStepSize;
           [largest maxDof] = max(numStepsV);
           needsReduction = largest > 1;
           me.numSteps = ceil(largest);
           me.stepSize = me.targetChange / me.numSteps;
           targets = zeros(me.numSteps, 6);
           curCmd = target;
            for s=1:me.numSteps
               targets(i,:) = curCmd + me.stepSize;
            end
            me.subStepTargets.setTargets(targets);
        end
    end
end
