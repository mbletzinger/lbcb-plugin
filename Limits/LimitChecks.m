classdef LimitChecks < handle
    properties
        cmd = {};
        inc = {};
    end
    methods
        function me = LimitChecks(cfg)
            me.cmd = CommandLimits(cfg);
            me.inc = IncrementLimits(cfg);
        end
        function yes = withinLimits(me, curStep, prevStep)
            yes1 = me.cmd.withinLimits(curStep);
            if isempty(prevStep)
                yes2 = 1;
            else
                yes2 = me.inc.withinLimits(curStep,prevStep);
            end
            yes = yes1 && yes2;
        end
    end
end