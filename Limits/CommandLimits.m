classdef CommandLimits < handle
    properties
        faults1 = zeros(12,2);
        faults2 = zeros(12,2);
        limits = [];
        commands1 = zeros(12,1);
        commands2 = zeros(12,1);
    end
    events
        CommandLimitExceeded
        CommandCurrentValueUpdated
    end
    methods
        function me = CommandLimits(cfg)
            me.limits = LimitsDao('command.limits',cfg);
        end
        function yes = withinLimits(me,step)
            yes = 1;
            me.faults1 = zeros(12,2);
            me.faults2 = zeros(12,2);
            cmds1 = step.lbcb{1}.command;
            cmds2 = step.lbcb{2}.command;
            for l = 1:12
                if l > 6
                    dof1 = cmds1.force(l -6);
                    dof2 = cmds2.force(l -6);
                else
                    dof1 = cmds1.disp(l);
                    dof2 = cmds2.disp(l);
                end
                me.commands1(l) = dof1;
                me.commands2(l) = dof2;
                if(me.limits.used1(l))
                    if dof1 < me.limits.lower1(l)
                        yes = 0;
                        me.faults1(l,1) = 1;
                    end
                    if dof1 > me.limits.upper1(l)
                        yes = 0;
                        me.faults1(l,2) = 1;
                    end
                end
                if(me.limits.used2(l))
                    if dof2 < me.limits.lower2(l)
                        yes = 0;
                        me.faults2(l,1) = 1;
                    end
                    if dof2 > me.limits.upper2(l)
                        yes = 0;
                        me.faults2(l,2) = 1;
                    end
                end
            end
            notify(me,'CommandCurrentValueUpdated');
            if yes == 0
                notify(me,'CommandLimitExceeded');
            end
        end
    end
end