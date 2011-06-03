classdef CommandLimits < handle
    properties
        faults1 = zeros(12,2); % 12 x 2 upper and lower limit faults.  Exceeded = 1
        faults2 = zeros(12,2);
        limits = [];
        commands1 = zeros(12,1);
        commands2 = zeros(12,1);
        log = Logger('CommandLimits');
        cfg = [];
        alerts
    end
    methods
        function me = CommandLimits(cfg)
            me.cfg = cfg;
        end
        function yes = withinLimits(me,step)
            me.getLimits();
            me.faults1 = zeros(12,2);
            me.faults2 = zeros(12,2);
            [me.faults1 me.commands1 ] = me.wL(step.lbcbCps{1}.command,...
                me.limits.lower1,me.limits.upper1,me.limits.used1);
            lt = length(step.lbcbCps);
            if lt > 1
                [me.faults2 me.commands2 ] = me.wL(step.lbcbCps{2}.command,...
                    me.limits.lower2,me.limits.upper2,me.limits.used2);
                %             me.log.debug(dbstack,sprintf('Lower 2 %d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d'...
                %                 ,me.limits.lower2(:)));
                %             me.log.debug(dbstack,sprintf('Lower Fault 2 %d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d'...
                %                 ,me.faults2(:)));
            end
            yes = sum(sum(me.faults1) + sum(me.faults2)) == 0;
        end
        function [faults commands] = wL(me,cmds,lower,upper,used)
            faults = false(12,2);
            commands(1:6) = cmds.disp;
            commands(7:12) = cmds.force;
            for l = 1:12
                if(used(l))
                    if commands(l) < lower(l)
                        faults(l,1) = true;
                    end
                    if commands(l) > upper(l)
                        faults(l,2) = true;
                    end
                end
                %                 me.log.debug(dbstack,sprintf('%d cmd %f < low %f',...
                %                     l,commands(l),lower(1)));
            end
        end
        function getLimits(me)
            me.limits = LimitsDao('command.limits',me.cfg);
        end
        function setAlerts(me, alerts)
            list = [];
            for l = 1:2
                for d = 1:12
                    f = me.genAlert(1,l,d);
                    if me.faults1(d,l)
                        alerts.add(f);
                    else
                        alerts.remove(f);
                    end
                    
                    f = me.genAlert(2,l,d);
                    if me.faults2(d,l)
                        alerts.add(f);
                    else
                        alerts.remove(f);
                    end
                end
            end
        end
        function fault = genAlert(me,lbcb, limit, dof)
            lbcbS = { 'LBCB 1' 'LBCB 2' };
            limitS = { 'Lower' 'Upper' };
            dofS = { 'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz' };
            fault = sprintf('%s %s has exceeded the %s limit', lbcbS{lbcb},limitS{limit},dofS{dof});
        end
    end
end