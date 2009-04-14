classdef simulationState < handle
    properties
        step = 0;
        subStep = 0;
        startTime = clock;
    end
    methods
        function me = simulationState(step)
        end
        function start(me)
            me.startTime = clock;
        end
        function increment(me,useSubStep)
            if(useSubStep)
                me.subStep = me.subStep + 1;
                return;
            end
                me.step = me.step + 1;
        end
        function et = getElapsedTime(me)
            et = clock - me.startTime;
        end
    end
end