classdef timerTest < handle
    properties 
        startTime = 0;
    end
    methods
        function execute(me)
            if me.startTime == 0
                me.startTime = rem(now,1);
            end
            fprintf('start %d elapsed %d\n',me.startTime,rem(now,1) - me.startTime);
        end
    end
end