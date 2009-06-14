classdef StepTolerances < handle
    properties
        within1 = zeros(12,1);
        within2 = zeros(12,1);
        limits = [];
    end
    methods
        function me = CommandLimits(cfg)
            me.limits = LimitsDao('command.limits',cfg);
        end
        function yes = withinLimits(me,step)
            yes = 1;
            me.within1 = ones(12,1);
            me.within2 = ones(12,1);
            cmds1 = step.lbcb{1}.command;
            rsp1 = step.lbcb{1}.response;
            cmds2 = step.lbcb{2}.command;
            rsp2 = step.lbcb{2}.response;
            for l = 1:12
                if l > 6
                    dof1 = abs(cmds1.force(l -6) - rsp1.force(l-6));
                    dof2 = abs(cmds2.force(l -6) - rsp2.force(l-6));
                else
                    dof1 = abs(cmds1.disp(l) - rsp1.disp(l));
                    dof2 = abs(cmds2.disp(l) - rsp2.disp(l));
                end
                if(me.limits.used1(l))
                    if dof1 > me.limits.window1(l)
                        yes = 0;
                        me.within1(l) = 0;
                    end
                end
                if(me.limits.used2(l))
                    if dof2 > me.limits.window1(l)
                        yes = 0;
                        me.within2(l) = 0;
                    end
                end
            end
        end
    end
end