classdef FxVsDx < handle
    properties
        plot = {};
        measuredFx = [];
        commandDx = [];
        measuredDx = [];
        isLbcb1 = 1;
        haveData = 0;
    end
    methods
        function me = FxVsDx(isLbcb1)
            me.plot = XyPlots(sprintf('LBCB %d  Fx vs Dx',1 + (isLbcb1 == false)),{'ed','lbcb'});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
%             me.legends = XyPlots.setLegends({'ed','lbcb'});
        end
        function displayMe(me)
                me.plot.displayMe('Dx','Fx');
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            Fx = step.lbcbCps{cpsidx}.response.force(1);
            cdx = step.lbcbCps{cpsidx}.command.disp(1);
            mdx = step.lbcbCps{cpsidx}.response.disp(1);
            if(me.haveData)
                me.measuredFx = cat(1, me.measuredFx,Fx);
                me.commandDx = cat(1, me.commandDx,cdx);
                me.measuredDx = cat(1, me.measuredDx,mdx);
            else
                me.haveData = 1;
                me.measuredFx = Fx;
                me.commandDx = cdx;
                me.measuredDx = mdx;
            end
            me.plot.update([me.measuredFx'; me.measuredDx'],1);
            me.plot.update([me.measuredFx'; me.commandDx'],2);
        end
    end
end
