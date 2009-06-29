classdef IncrementLimits < handle
    properties
        faults1 = zeros(12,1);
        faults2 = zeros(12,1);
        increments1 = zeros(12,1);
        increments2 = zeros(12,1);
        limits = [];
    end
    methods
        function me = IncrementLimits(cfg)
            me.limits = WindowLimitsDao('increment.limits',cfg);
        end
        function yes = withinLimits(me,curStep,prevStep)
            me.faults2 = zeros(12,1);
            [me.faults1 me.increments1 ] = me.wL(curStep.lbcb{1}.command,...
                prevStep.lbcb{1}.command,me.limits.window1,me.limits.used1);
            lt = length(curStep.lbcb);
            if lt > 1
                [me.faults2 me.increments2 ] = me.wL(curStep.lbcb{2}.command,...
                    prevStep.lbcb{2}.command,me.limits.window2,me.limits.used2);
            end
            yes = (sum(me.faults1) + sum(me.faults2)) == 0;
        end
        function [faults increments] = wL(me,curCmd,prevCmd,window,used)
            faults = zeros(12,1);
            increments(1:6) = curCmd.disp - prevCmd.disp;
            increments(7:12) = curCmd.force - prevCmd.force;
            for l = 1:12
                if used(l)
                    if abs(increments(l)) > window(l)
                        faults(l) = 1;
                    end
                end
            end
        end
    end
end