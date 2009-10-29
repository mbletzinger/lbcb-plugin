classdef XyPlots < handle
    properties
        xdata = cell(8,1);
        ydata = cell(8,1);
        lineSeries = [];
        legends = {};
        isDisplayed = 0;
        fig = {};
    end
    methods
        function displayPlot(me,turnOn)
            if turnOn
                me.fig = figure;
                xys = plot(0,0,'k',0,0,'b',0,0,'r',0,0,'g',0,0,'m',0,0,':k',0,0,':b',0,0,':r');
                me.lineSeries = xys;
                legend(series,me.legends);
                me.isDisplayed = 1;
            else
                close(me.fig);
                me.isDisplayed = 0;
            end
        end
        function update(me,d,idx)
            me.ydata{idx} = d(2,:);
            me.xdata{idx} = d(1,:);
            if me.isDisplayed
                set(me.lineSeries{idx},'XData',me.xdata);
                set(me.lineSeries{idx},'YData',me.ydata);
            end
        end
        function setLegends(me,lgnds)
            me.legends = lgnds;
            if me.isDisplayed
                legend(me.lineSeries,lgnds);
            end
        end
    end
end