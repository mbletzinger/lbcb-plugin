classdef SimSharedData < handle
    properties
        prevTarget = [];
        curTarget = [];
        correctionTarget = [];
        prevStepData = [];
        curStepData = [];
        nextStepData = [];
    end
    methods
        function stepShift(me)
            me.prevStepData = me.curStepData;
            me.curStepData = me.nextStepData;
        end
    end
end
