classdef StepStats < handle
    properties
        stepCalc
        stepTimes
        totalSteps
        currentStep
        currentStepNum
        ended
    end
    methods
        function me = StepStats()
            me.stepCalc = TimeCalculator();
            me.stepTimes = TimeFifo(10);
            me.currentStep = 0;
            me.currentStepNum = 0;
            me.ended = true;
        end
        function reset(me)
            me.stepCalc.time2Stop();
            me.stepTimes.clear();
            me.currentStep = 0;
            me.currentStepNum = 0;
            me.ended = true;
        end
        function stepStart(me,stepNum)
            me.stepCalc.time2Start();
            me.currentStepNum = stepNum;
            me.currentStep = me.currentStep + 1;
            me.ended = false;
        end
        function stepEnd(me)
            tm = me.stepCalc.time2Stop();
            me.stepTimes.push(tm);
            me.ended = true;
        end
        function tm = latestStepTime(me)
            tm = me.stepCalc.get();
        end
        function av = averageStepTime(me)
            av = me.stepTimes.average();
        end
        function remaining = remainingSteps(me)
            remaining = me.totalSteps - me.currentStep;
        end
    end
end