classdef VsPlot2 < handle
    properties
        plot = {};
        measuredY = cell(2,1);
        measuredX = cell(2,1);
        isLbcb1
        xdof
        ydof
        cdp
    end
    methods
        function me = VsPlot2(name,isLbcb1,xdof,ydof)
            me.plot = XyPlots(name,{'LBCB 1','LBCB 2'});
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
            for cpsidx = 1:2

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
                    me.measuredY{cpsidx} = cat(1, me.measuredY{cpsidx},yd);
                    me.measuredX{cpsidx} = cat(1, me.measuredX{cpsidx},xmd);
                else
                    me.measuredY{cpsidx} = yd;
                    me.measuredX{cpsidx} = xmd;
                end
                me.plot.update([me.measuredY{cpsidx}'; me.measuredX{cpsidx}'],cpsidx);
            end
        end
    end
end
