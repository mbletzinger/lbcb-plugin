classdef StepStats < handle
    properties
        stepCalc
        stepTimes
        totalSteps
        currentStep
        currentStepNum
    end
    methods
        function me = StepStats(totalSteps)
            me.stepCalc = TimeCalculator();
            me.stepTimes = TimeFifo(10);
            me.totalSteps = totalSteps;
            me.currentStep = 0;
            me.currentStepNum = 0;
        end
        function reset(me)
            me.stepCalc.time2Stop();
            me.stepTimes.clear();
            me.currentStep = 0;
            me.currentStepNum = 0;
        end
        function stepStart(me,stepNum)
            me.stepCalc.time2Start();
            me.currentStepNum = stepNum;
            me.currentStep = me.currentStep + 1;
        end
        function stepEnd(me)
            tm = me.stepCalc.time2Stop();
            me.stepTimes.push(tm);
        end
        function av = averageStepTime(me)
            av = me.stepTimes.average();
        end
        function remaining = remainingSteps(me)
            remaining = me.totalSteps - me.currentStep;
        end
    end
end