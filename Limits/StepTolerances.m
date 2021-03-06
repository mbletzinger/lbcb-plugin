classdef StepTolerances < handle
    properties
        within;
        diffs;;
        window = [];
        used = [];
        log = Logger('StepTolerances');
        cfg = [];
        isLbcb1 = 0;
    end
    methods
        function me = StepTolerances(cfg,isLbcb1)            
            me.cfg = cfg;
            me.isLbcb1 = isLbcb1;
            me.within = true(12,1);
            me.diffs = zeros(12,1);
        end
        function yes = needsCorrection(me,dof)
                yes = me.within(dof) == false;
        end
        function yes = withinTolerances(me,target,response)
            me.getWindow();
%            me.log.debug(dbstack, sprintf('Comparing %s \nto %s',target.toString(),response.toString()));
            me.within = true(12,1);
            me.diffs(1:6) = abs(target.disp - response.disp);
            me.diffs(7:12) = abs(target.force - response.force);
            for lm = 1:12
                if(me.used(lm))
                    if me.diffs(lm) > me.window(lm)
                        me.within(lm) = false;
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
        function setWindow(me, window, used)
            wlcfg = WindowLimitsDao('command.tolerances',me.cfg);
            if me.isLbcb1
                wlcfg.window1 = window;
                wlcfg.used1 = used;
            else
                wlcfg.window2 = window;
                wlcfg.used2 = used;
            end
            me.getWindow();
        end
    end
end