classdef StepTolerances < handle
    properties
        within1 = zeros(12,1);
        within2 = zeros(12,1);
        diffs1 = zeros(12,1);
        diffs2 = zeros(12,1);
        limits = [];
    end
    methods
        function me = StepTolerances(cfg)
            me.limits = WindowLimitsDao('command.tolerances',cfg);
        end
        function yes = withinTolerances(me,step)
            me.within2 = ones(12,1);
            [me.within1 me.diffs1 ] = me.wL(step.lbcb{1}.command,...
                step.lbcb{1}.response,me.limits.window1,me.limits.used1);
            lt = length(step.lbcb);
            if lt > 1
                [me.within2 me.diffs2 ] = me.wL(step.lbcb{2}.command,...
                    step.lbcb{2}.response,me.limits.window2,me.limits.used2);
            end
            yes = (sum(me.within1) + sum(me.within2)) == 24;
        end
        function [within diff] = wL(me,command, response, window, used)
            within = ones(12,1);
            diff(1:6) = abs(command.disp - response.disp);
            diff(7:12) = abs(command.force - response.force);
            for l = 1:12
                if(me.limits.used1(l))
                    if diff(l) > me.limits.window1(l)
                        me.within1(l) = 0;
                    end
                end
            end
        end
    end
end