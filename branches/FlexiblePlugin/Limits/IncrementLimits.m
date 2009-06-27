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
            me.limits = WindowLimitsDao('command.limits',cfg);
        end
        function yes = withinLimits(me,curStep,prevStep)
            me.faults1 = zeros(12,1);
            me.faults2 = zeros(12,1);
            [me.faults1 me.increments1 ] = me.wL(curStep.lbcb{1}.command,...
                prevStep.lbcb{1}.command,me.limits.window1,me.limits.used1);
            lt = length(step.lbcb);
            if lt > 1
                [me.faults2 me.increments2 ] = me.wL(curStep.lbcb{2}.command,...
                    prevStep.lbcb{2}.command,me.limits.window2,me.limits.used2);
            end
            yes = sum(me.faults1) + sum(me.faults2);
        end
        function [faults increments] = wL(me,curCmd,prevCmd,window,used)
            faults = zeros(12,1);
            increments = zeros(12,1);
            for l = 1:12
                if l > 6
                    dof = curCmd.force(l -6) - prevCmd.force(l-6);
                else
                    dof = curCmd.disp(l) - prevCmd.disp(l);
                end
                increments(l) = dof;
                if(used(l))
                    if abs(dof) > window(l)
                        faults(l) = 1;
                    end
                end
            end
        end
    end
end