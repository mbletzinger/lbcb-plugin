classdef XyPlots < DisplayControl
    properties
        xdata = cell(8,1);
        ydata = cell(8,1);
        lineSeries = [];
        legends = {};
        figNum
        name
    end
    methods
        function me = XyPlots(name)
            me.name = name;
        end
        function displayMe(me)
            me.fig = figure('DeleteFcn',{'DataDisplay.checkOff', me.figNum }, 'Name',me.name);
            xys = plot(0,0,'k',0,0,'b',0,0,'r',0,0,'g',0,0,'m',0,0,':k',0,0,':b',0,0,':r');
            me.lineSeries = xys;
            if isempty(me.legends) ==false
                legend(series,me.legends);
            end
            me.isDisplayed = true;
        end
        function update(me,d,idx)
            me.ydata{idx} = d(2,:);
            me.xdata{idx} = d(1,:);
            if me.isDisplayed
                set(me.lineSeries(idx),'XData',me.xdata{idx});
                set(me.lineSeries(idx),'YData',me.ydata{idx});
            end
        end
        function setLegends(me,lgnds)
            me.legends = lgnds;
            if me.isDisplayed && isempty(lgnds) == false
                legend(me.lineSeries,lgnds);
            end
        end
    end
end