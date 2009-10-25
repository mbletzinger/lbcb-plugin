classdef StepTolerances < handle
    properties
        within = ones(12,1);
        diffs = zeros(12,1);
        window = [];
        used = [];
    end
    methods
        function me = StepTolerances(cfg,isLbcb1)
            wlcfg = WindowLimitsDao('command.tolerances',cfg);
            if isLbcb1
                me.window = wlcfg.window1;
                me.used = wlcfg.used1;
            else
                me.window = wlcfg.window2;
                me.used = wlcfg.used2;
            end
        end
        function yes = withinTolerances(me,target,response)
            me.within = ones(12,1);
            me.diff(1:6) = abs(target.disp - response.disp);
            me.diff(7:12) = abs(target.force - response.force);
            for l = 1:12
                if(me.used(l))
                    if me.diff(l) > me.window(l)
                        me.within(l) = 0;
                    end
                end
            end
            yes = all(me.within);
        end
    end
end