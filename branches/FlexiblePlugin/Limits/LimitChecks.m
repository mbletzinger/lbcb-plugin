classdef LimitChecks < handle
    properties
        cmd = {}; % command limits object
        inc = {}; % increment limits object
    end
    methods
        function yes = withinLimits(me, curStep, prevStep)
            yes1 = me.cmd.withinLimits(curStep);
            if isempty(prevStep)
                yes2 = 1;
            else
                yes2 = me.inc.withinLimits(curStep,prevStep);
            end
            yes = and(yes1 , yes2);
        end
    end
end