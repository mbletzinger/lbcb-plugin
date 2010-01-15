classdef RyVsDx < handle
    properties
        plot = {};
        measuredRy = [];
        commandDx = [];
        measuredDx = [];
        isLbcb1 = 1;
        haveData = 0;
    end
    methods
        function me = RyVsDx(isLbcb1)
            me.plot = XyPlots(sprintf('LBCB %d  Ry vs Dx',1 + (isLbcb1 == false)));
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
            ry = step.lbcbCps{cpsidx}.response.disp(5);
            cdx = step.lbcbCps{cpsidx}.command.disp(1);
            mdx = step.lbcbCps{cpsidx}.response.disp(1);
            if(me.haveData)
                me.measuredRy = cat(1, me.measuredRy,ry);
                me.commandDx = cat(1, me.commandDx,cdx);
                me.measuredDx = cat(1, me.measuredDx,mdx);
            else
                me.haveData = 1;
                me.measuredRy = ry;
                me.commandDx = cdx;
                me.measuredDx = mdx;
            end
            me.plot.update([me.measuredRy'; me.measuredDx'],1);
            me.plot.update([me.measuredRy'; me.commandDx'],2);
        end
    end
end