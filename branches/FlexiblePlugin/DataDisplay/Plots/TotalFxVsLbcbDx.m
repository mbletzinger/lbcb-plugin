classdef TotalFxVsLbcbDx < handle
    properties
        plot = {};
        totalFx = [];
        commandDx = [];
        measuredDx = [];
        isLbcb1 = 1;
        haveData = 0;
    end
    methods
        function me = TotalFxVsLbcbDx(isLbcb1)
            me.plot = XyPlots();
            me.isLbcb1 = isLbcb1;
        end
        function displayPlot(me,turnOn)
                me.plot.displayPlot(turnOn);
        end
        function update(me,step)
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            tfx = step.dData.values(1);
            cdx = step.lbcbCps{cpsidx}.command.disp(1);
            mdx = step.lbcbCps{cpsidx}.response.ed.disp(1);
            if(me.haveData)
                me.totalFx = cat(1, me.totalFx,tfx);
                me.commandDx = cat(1, me.commandDx,cdx);
                me.measuredDx = cat(1, me.measuredDx,mdx);
            else
                me.haveData = 1;
                me.totalFx = tfx;
                me.commandDx = cdx;
                me.measuredDx = mdx;
            end
            me.plot.update([me.totalFx; me.measuredDx],1);
            me.plot.update([me.totalFx; me.commandDx],2);
        end
    end
end