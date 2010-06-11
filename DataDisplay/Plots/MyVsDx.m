classdef MyVsDx < handle
    properties
        plot = {};
        measuredMy = [];
        commandDx = [];
        measuredDx = [];
        isLbcb1 = 1;
        haveData = 0;
    end
    methods
        function me = MyVsDx(isLbcb1)
            me.plot = XyPlots(sprintf('LBCB %d  My vs Dx',1 + (isLbcb1 == false)),{});
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
            my = step.lbcbCps{cpsidx}.response.force(5);
            cdx = step.lbcbCps{cpsidx}.command.disp(1);
            mdx = step.lbcbCps{cpsidx}.response.disp(1);
            if(me.haveData)
                me.measuredMy = cat(1, me.measuredMy,my);
                me.commandDx = cat(1, me.commandDx,cdx);
                me.measuredDx = cat(1, me.measuredDx,mdx);
            else
                me.haveData = 1;
                me.measuredMy = my;
                me.commandDx = cdx;
                me.measuredDx = mdx;
            end
            me.plot.update([me.measuredMy'; me.measuredDx'],1);
            me.plot.update([me.measuredMy'; me.commandDx'],2);
        end
    end
end