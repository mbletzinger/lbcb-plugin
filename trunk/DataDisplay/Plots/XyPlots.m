classdef XyPlots < DisplayControl
    properties
        xdata
        ydata
        groups
        legends
        figNum
        name
        plotPars
        log
        axs
    end
    methods
        function me = XyPlots(name,lgnds)
            me=me@DisplayControl();
            me.log = Logger(sprintf('XyPlots.%s',name));
            me.name = name;
            me.xdata = cell(8,1);
            me.ydata = cell(8,1);
            me.groups = [];
            me.legends = lgnds;
            lgth = length(lgnds);
            colorLabels = { 'b', 'r','g','k','c','m','y' };
            me.plotPars = cell(lgth);
            for i = 1:lgth
                me.plotPars{i} = { 0, 0,sprintf('-%s',colorLabels{i}), 0, 0,sprintf('d%s',colorLabels{i}) };
            end
            me.figNum = [];            
        end
        function displayMe(me,xlab,ylab)
            me.fig = figure('DeleteFcn',{'DisplayFactory.dispDeleted', me.name }, 'Name',me.name);            
            me.axs = axes();
            axis(me.axs, 'tight');
            lgth = length(me.legends);
            hold on;
            for i = 1:lgth
                pars = me.plotPars{i};
                xys = plot(me.axs,pars{:});
                grp = hggroup;
                set(xys,'Parent',grp); % set group as groups parent
                % get annotation property of the group which contains a
                % LegendEntry object in its LegendInformation property.
                % Set the IconDisplayStyle to display a legend for the
                % group
                set(get(get(grp,'Annotation'),'LegendInformation'),'IconDisplayStyle','on');
                me.groups(i) = grp;
            end
            legend(me.legends);
            hold off;
            xlabel(xlab); ylabel(ylab);
            set(me.axs, 'XGrid', 'on');
            set(me.axs, 'YGrid', 'on');
            set(me.axs, 'XLimMode','auto');
            set(me.axs, 'YLimMode','auto');
            me.displayData();
        end
        function update(me,d,idx)
            me.ydata{idx} = d(1,:);
            me.xdata{idx} = d(2,:);
            if me.isDisplayed
                me.displayData();
            end
        end
    end
    methods (Access = private)
        function displayData(me)
            lst = length(me.groups);
            for li = 1:lst
                grp = me.groups(li);
                ls = get(grp,'Children');
                xd = me.xdata{li};
                xlst = length(xd);
                if xlst == 0
                    return;
                end
                yd = me.ydata{li};
                set(ls(2),'XData',xd,'YData',yd);
                set(ls(1),'XData',xd(xlst),'YData',yd(xlst));
            end
        end
    end
end