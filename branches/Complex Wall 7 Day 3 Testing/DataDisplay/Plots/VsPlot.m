classdef VsPlot < handle
    properties
        plot = {};
        measuredY = [];
        measuredX = [];
        isLbcb1
        xdof
        ydof
        cdp
    end
    methods
        function me = VsPlot(name,isLbcb1,xdof,ydof)
            me.plot = XyPlots(name,{'measured'});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
            me.xdof = xdof;
            me.ydof = ydof;
        end
        function displayMe(me)
                me.plot.displayMe(me.plot.lbl{me.xdof},me.plot.lbl{me.ydof});
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            if me.isLbcb1 == false && me.cdp.numLbcbs() < 2
                return;
            end
            if me.ydof > 6 
                yd = step.lbcbCps{cpsidx}.response.force(me.ydof - 6);
            else
                yd = step.lbcbCps{cpsidx}.response.disp(me.ydof);
            end
            if me.xdof > 6
                xmd = step.lbcbCps{cpsidx}.response.force(me.xdof - 6);
            else
                xmd = step.lbcbCps{cpsidx}.response.disp(me.xdof);
            end
            if isempty(me.measuredY) == false
                me.measuredY = cat(1, me.measuredY,yd);
                me.measuredX = cat(1, me.measuredX,xmd);
            else
                me.measuredY = yd;
                me.measuredX = xmd;
            end
            me.plot.update([me.measuredY'; me.measuredX'],1);
        end
    end
end
