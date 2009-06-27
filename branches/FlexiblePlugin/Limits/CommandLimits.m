classdef CommandLimits < handle
    properties
        faults1 = zeros(12,2);
        faults2 = zeros(12,2);
        limits = [];
        commands1 = zeros(12,1);
        commands2 = zeros(12,1);
    end
    methods
        function me = CommandLimits(cfg)
            me.limits = LimitsDao('command.limits',cfg);
        end
        function yes = withinLimits(me,step)
            me.faults1 = zeros(12,1);
            me.faults2 = zeros(12,1);
            [me.faults1 me.commands1 ] = me.wL(step.lbcb{1}.command,...
                me.limits.lower1,me.limits.upper1,me.limits.used1);
            lt = length(step.lbcb);
            if lt > 1
            [me.faults2 me.commands2 ] = me.wL(step.lbcb{2}.command,...
                me.limits.lower2,me.limits.upper2,me.limits.used2);
            end
            yes = sum(me.faults1) + sum(me.faults2);
        end
        function [faults commands] = wL(me,cmds,lower,upper,used)
            faults = zeros(12,2);
            for l = 1:12
                if l > 6
                    dof = cmds.force(l -6);
                else
                    dof = cmds.disp(l);
                end
                commands = dof;
                if(used(l))
                    if dof < lower(l)
                        faults(l,1) = 1;
                    end
                    if dof > upper(l)
                        faults(l,2) = 1;
                    end
                end
            end
        end
    end
end