classdef  targetSequence < handle
    properties
    targets = zeroes(100,6);
    total = 0;
    useSubStep = 0;
    simState = {};
    end
    methods
        function me = targetSequence(simState)
            me.simState = simState;
        end
        function tgt = getTarget(me)
            if me.useSubStep
                step = me.simState.subStep;
            else
                step = me.simState.step;
            end
            tgt = me.targets(step,:);
        end
        function setTargets(me,targets)
            me.targets= targets;	% 6 column data
            tmp = size(targets);
            me.total = tmp(1);
        end
    end
end