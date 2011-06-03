classdef IncrementLimits < handle
    properties
        faults1 = zeros(12,1);
        faults2 = zeros(12,1);
        increments1 = zeros(12,1);
        increments2 = zeros(12,1);
        limits = [];
        cfg = [];
    end
    methods
        function me = IncrementLimits(cfg)
            me.cfg = cfg;
        end
        function yes = withinLimits(me,curStep,prevStep)
            cdp = ConfigDaoProvider(me.cfg);
            me.getLimits();
            me.faults2 = zeros(12,1);
            [me.faults1 me.increments1 ] = me.wL(curStep.lbcbCps{1}.command,...
                prevStep.lbcbCps{1}.command,me.limits.window1,me.limits.used1);
            lt = cdp.numLbcbs();
            if lt > 1
                [me.faults2 me.increments2 ] = me.wL(curStep.lbcbCps{2}.command,...
                    prevStep.lbcbCps{2}.command,me.limits.window2,me.limits.used2);
            end
            yes = (sum(me.faults1) + sum(me.faults2)) == 0;
        end
        function [faults increments] = wL(me,curCmd,prevCmd,window,used)
            faults = false(12,1);
            increments(1:6) = curCmd.disp - prevCmd.disp;
            increments(7:12) = curCmd.force - prevCmd.force;
            for l = 1:12
                if used(l)
                    if abs(increments(l)) > window(l)
                        faults(l) = true;
                    end
                end
            end
        end
        function getLimits(me)
            me.limits = WindowLimitsDao('increment.limits',me.cfg);
        end
        function setAlerts(me, alerts)
            list = [];
            for d = 1:12
                
                f = me.genAlert(1,d);
                if me.faults1(d)
                    alerts.add(f);
                else
                    alerts.remove(f);
                end
                
                f = me.genAlert(2,d);
                if me.faults2(d)
                    alerts.add(f);
                else
                    alerts.remove(f);
                end
            end
        end
        function fault = genAlert(me,lbcb, dof)
            lbcbS = { 'LBCB 1' 'LBCB 2' };
            dofS = { 'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz' };
            fault = sprintf('%s %s has exceeded the increment limit', lbcbS{lbcb},dofS{dof});
        end
    end
end