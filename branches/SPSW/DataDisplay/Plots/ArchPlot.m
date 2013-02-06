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
        cdp
        log
        noValues
    end
    methods
        function me = ArchPlot(name,isLbcb1,xdof,ylabel)
            me.plot = XyPlots(name,{'measured','commanded'});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
            me.xdof = xdof;
            me.ylabel = ylabel;
            me.yidx = -1;
            me.log = Logger('ArchPlot');
            me.noValues = false;
        end
        function displayMe(me)
                me.plot.displayMe(me.plot.lbl{me.xdof},me.ylabel);
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            if isempty(step.cData.values) || me.noValues
                return;
            end
            if me.cdp.numLbcbs() == 1 && me.isLbcb1 == false
                return
            end
            if me.yidx < 0 
                lt = length(step.cData.labels);
                for i = 1:lt
                    if strcmp(me.ylabel,step.cData.labels{i})
                        me.yidx = i;
                        break;
                    end
                end
                if me.yidx < 0
                    me.log.error(dbstack,sprintf('"%s" not found in arch data',me.ylabel));
                    me.noValues = true; %#ok<UNRCH>
                    return;
                end
            end
                
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            yd = step.cData.values(me.yidx);
            if me.xdof > 6
                xmd = step.lbcbCps{cpsidx}.response.force(me.xdof - 6);
                xcd = step.lbcbCps{cpsidx}.command.force(me.xdof - 6);
            else
                xmd = step.lbcbCps{cpsidx}.response.disp(me.xdof);
                xcd = step.lbcbCps{cpsidx}.command.disp(me.xdof);
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
