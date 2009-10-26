classdef StepTolerances < handle
    properties
        within = ones(12,1);
        diffs = zeros(12,1);
        window = [];
        used = [];
        log = Logger;
        cfg = [];
        isLbcb1 = 0;
    end
    methods
        function me = StepTolerances(cfg,isLbcb1)            
            me.cfg = cfg;
            me.isLbcb1 = isLbcb1;
        end

        function yes = withinTolerances(me,target,response)
            me.getWindow();
            me.log.debug(dbstack, sprintf('Comparing %s \nto %s',target.toString(),response.toString()));
            me.within = ones(12,1);
            me.diffs(1:6) = abs(target.disp - response.disp);
            me.diffs(7:12) = abs(target.force - response.force);
            for l = 1:12
                if(me.used(l))
                    if me.diffs(l) > me.window(l)
                        me.within(l) = 0;
                    end
                end
            end
            yes = all(me.within);
        end
        function getWindow(me)
            wlcfg = WindowLimitsDao('command.tolerances',me.cfg);
            if me.isLbcb1
                me.window = wlcfg.window1;
                me.used = wlcfg.used1;
            else
                me.window = wlcfg.window2;
                me.used = wlcfg.used2;
            end
        end
    end
end