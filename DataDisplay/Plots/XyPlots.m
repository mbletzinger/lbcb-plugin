classdef XyPlots < DisplayControl
    properties
        xdata
        ydata
        lineSeries
        legends
        figNum
        name
    end
    methods
        function me = XyPlots(name,lgnds)
            me=me@DisplayControl();
            me.name = name;
            me.xdata = cell(8,1);
            me.ydata = cell(8,1);
            me.lineSeries = [];
            me.legends = lgnds;
            me.figNum = [];            
        end
        function displayMe(me)
            name=me.name;
            indice=findstr(name,'vs');
            ylab=name(indice(1)-3:indice(1)-2);
            xlab=name(indice(1)+3:indice(1)+4);
            me.fig = figure('DeleteFcn',{'DataDisplay.checkOff', me.figNum }, 'Name',me.name);            
            xys = plot(0,0,'b',0,0,'--r',0,0,'r',0,0,'g',0,0,'m',0,0,':k',0,0,':b',0,0,':r');
            xlabel(xlab); ylabel(ylab);
            me.lineSeries = xys;
            if isempty(me.legends) ==false
                legend(xys,me.legends);
            end
            me.displayMe2();
        end
        function update(me,d,idx)
            me.ydata{idx} = d(1,:);
            me.xdata{idx} = d(2,:);
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