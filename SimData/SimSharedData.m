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
        function newTarget(me)
            me.prevTarget = me.curTarget;
            me.curTarget = me.sdf.stepNumber2StepData(...
                me.curTarget.stepNum.next(0));
        end
    end
end
