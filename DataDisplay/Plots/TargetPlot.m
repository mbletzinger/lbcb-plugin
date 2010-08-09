classdef TargetPlot < DisplayControl
    properties
        xdata
        ydata
        groups
        legends
        figNum
        name
        log
        plotPars
        axis
        maxStp
    end
    methods
        function me = TargetPlot(name,lgnds)
            me=me@DisplayControl();
            me.log = Logger(sprintf('TargetPlot.%s',name));
            me.name = name;
            me.xdata = cell(8,1);
            me.ydata = cell(8,1);
            me.groups = [];
            lgth = length(lgnds);
            
            me.legends = lgnds;
            colorLabels = { 'b', 'r','g','k','c','m','y' };
            me.plotPars = cell(lgth);
            for i = 1:lgth
                me.plotPars{i} = { 0, 0,sprintf('-%s',colorLabels{i}), 0, 0,sprintf('d%s',colorLabels{i}) };
            end
            me.figNum = [];
        end
        function displayMe(me,ylab)
            me.fig = figure('DeleteFcn',{'DataDisplay.checkOff', me.figNum }, 'Name',me.name);
            me.axis = axes();
            lgth = length(me.legends);
            hold on;
            for i = 1:lgth
                pars = me.plotPars{i};
                xys = plot(me.axis,pars{:});
                grp = hggroup;
                set(xys,'Parent',grp); % set group as groups parent
                % get annotation property of the group which contains a
                % LegendEntry object in its LegendInformation property.
                % Set the IconDisplayStyle to display a legend for the
                % group
                set(get(get(grp,'Annotation'),'LegendInformation'),'IconDisplayStyle','on');
                me.groups(i) = grp;
            end
            hold off;
            xlabel('Step'); ylabel(ylab);
            me.displayData();
            me.displayMe2();
        end
        function update(me,d,idx)
            lst = length(d);
            me.maxStp = lst;
            me.ydata{idx} = d(:);
            me.xdata{idx} = ( 1:lst );
            if me.isDisplayed
                me.displayData();
            end
        end
    end
    methods (Access = private)
        function displayData(me)
            lst = length(me.groups);
            mx = 50;
            mn = 1;
            if me.maxStp > 50
                mx = me.maxStp;
                mn = me.maxStp - 50;
            end
            set(me.axis,'XLim',[mn mx]);
            for li = 1:lst
                grp = me.groups(li);
                ls = get(grp,'Children');
                xd = me.xdata{li};
                xlst = length(xd);
                yd = me.ydata{li};
                set(ls(2),'XData',xd);
                set(ls(1),'XData',xd(xlst));
                set(ls(2),'YData',yd);
                set(ls(1),'YData',yd(xlst));
            end
        end
    end
end