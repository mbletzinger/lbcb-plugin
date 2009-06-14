classdef IncrementLimits < handle
    properties
        faults1 = zeros(12,1);
        faults2 = zeros(12,1);
        limits = [];
    end
    methods
        function me = CommandLimits(cfg)
            me.limits = WindowLimitDao('command.limits',cfg);
        end
        function yes = withinLimits(me,curStep,prevStep)
            yes = 1;
            me.faults1 = zeros(12,1);
            me.faults2 = zeros(12,1);
            cCmds1 = curStep.lbcb{1}.command;
            cCmds2 = curStep.lbcb{2}.command;
            pCmds1 = prevStep.lbcb{1}.command;
            pCmds2 = prevStep.lbcb{2}.command;
            for l = 1:12
                if l > 6
                    dof1 = cCmds1.force(l -6) - pCmds1.force(l-6);
                    dof2 = cCmds2.force(l -6) - pCmds2.force(l-6);
                else
                    dof1 = cCmds1.disp(l) - pCmds1.disp(l);
                    dof2 = cCmds2.disp(l) - pCmds2.disp(l);
                end
                if(me.limits.used1(l))
                    if abs(dof1) > me.limits.window1(l)
                        yes = 0;
                        me.faults1(l) = 1;
                    end
                end
                if(me.limits.used2(l))
                    if abs(dof2) > me.limits.window2(l)
                        yes = 0;
                        me.faults2(l) = 1;
                    end
                end
            end
        end
    end
end