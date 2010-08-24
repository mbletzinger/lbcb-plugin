classdef ArchPlot < handle
    properties
        plot = {};
        measuredY = [];
        commandX = [];
        measuredX = [];
        isLbcb1
        xdof
        ylabel
        yidx
    end
    methods
        function me = ArchPlot(name,isLbcb1,xdof,ylabel)
            me.plot = XyPlots(name,{'measured','commanded'});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
            me.xdof = xdof;
            me.ylabel = ylabel;
            me.yidx = -1;
        end
        function displayMe(me)
                me.plot.displayMe(me.plot.lbl{me.xdof},me.ylabel);
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            if isempty(step.cData.values)
                return;
            end
            if me.yidx < 0 
                lt = length(step.cData.labels);
                for i = 1:lt
                    if strcmp(me.ylabel,step.cData.labels{i})
                        me.yidx = i;
                        break;
                    end
                end
            end
                
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            yd = step.cData.values{me.yidx};
            if me.xdof > 6
                xmd = step.lbcbCps{cpsidx}.response.force(me.yidx - 6);
                xcd = step.lbcbCps{cpsidx}.command.force(me.yidx - 6);
            else
                xmd = step.lbcbCps{cpsidx}.response.disp(me.yidx);
                xcd = step.lbcbCps{cpsidx}.command.disp(me.yidx);
            end
            if isempty(me.measuredY) == false
                me.measuredY = cat(1, me.measuredY,yd);
                me.commandX = cat(1, me.commandX,xcd);
                me.measuredX = cat(1, me.measuredX,xmd);
            else
                me.measuredY = yd;
                me.commandX = xcd;
                me.measuredX = xmd;
            end
            me.plot.update([me.measuredY'; me.measuredX'],1);
            me.plot.update([me.measuredY'; me.commandX'],2);
        end
    end
end
