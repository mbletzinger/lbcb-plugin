classdef LimitChecks < handle
    properties
        cl = {}; % command limits object
        il = {}; % increment limits object
    end
    methods
        function yes = withinLimits(me, curStep, prevStep)
            yes1 = me.cl.withinLimits(curStep);
            if isempty(prevStep)
                yes2 = 1;
            else
                yes2 = me.il.withinLimits(curStep,prevStep);
            end
            yes = and(yes1 , yes2);
        end
    end
end