classdef SimSharedData < handle
    properties
        prevTarget = [];
        curTarget = [];
        correctionTarget = [];
        prevStepData = [];
        curStepData = [];
        nextStepData = [];
        sdf = [];
    end
    methods
        function stepShift(me)
            me.prevStepData = me.curStepData;
            me.curStepData = me.nextStepData;
        end
        function targetShift(me,target)
            me.prevTarget = me.curTarget;
            me.curTarget = target;
        end
        function clearSteps(me)
            me.correctionTarget = [];
            me.prevStepData = [];
            me.curStepData = [];
            me.nextStepData = [];
        end
    end
end
