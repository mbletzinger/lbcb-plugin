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
            me.plot = XyPlots(sprintf('Total Fx vs LBCB %d Dx',1 + (isLbcb1 == false)),{});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
        end
        function displayMe(me)
                me.plot.displayMe();
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            if isempty(step.dData.values)
                return;
            end
            tfx = step.dData.values(1);
            cdx = step.lbcbCps{cpsidx}.command.disp(1);
            mdx = step.lbcbCps{cpsidx}.response.disp(1);
            if(me.haveData)
                me.totalFx = cat(1, me.totalFx,tfx);
                me.commandDx = cat(1, me.commandDx,cdx);
                me.measuredDx = cat(1, me.measuredDx,mdx);
            else
                me.haveData = 1;
                me.totalFx = [tfx];
                me.commandDx = [cdx];
                me.measuredDx = [mdx];
            end
            me.plot.update([me.totalFx'; me.measuredDx'],1);
            me.plot.update([me.totalFx'; me.commandDx'],2);
        end
    end
end