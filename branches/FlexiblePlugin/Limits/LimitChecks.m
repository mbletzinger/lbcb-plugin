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
            yes2 = me.inc.withinLimits(curStep,prevStep);
            yes = yes1 || yes2;
        end
    end
end