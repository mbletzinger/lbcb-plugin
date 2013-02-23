classdef StatsTable < DisplayControl
    properties
        name = '';
        table = [];
        stats
        cdp
        log = Logger('StatsTable');
        width = 500
        height = 150
        data
    end
    methods
        function me = StatsTable()
            me.name = 'Test Statistics';
            rnames = {'Current Step';...
                'Finished';...
                'Average Step Time';... 
                'Estimated Time Remaining'...
                };
            me.data = cell(length(rnames),2);
            me.data(:,1) = rnames;
            spacer = '                    ';
            for i = 1:length(rnames)
                me.data{i,2} = spacer;
            end
        end
        function displayMe(me)

            me.fig = figure('Position',[100 100 (me.width + 4) (me.height + 4)], 'Name', me.name,'DeleteFcn',{'DisplayFactory.dispDeleted', me.name });
            me.table = uitable('Parent',me.fig,...
                'Position',[0 0 me.width me.height ],...
                'ColumnFormat',{'char', 'char'}, ...
                'FontSize',18,...
                'ColumnName',[],...
                'RowName',[],...
                'ColumnWidth',{ me.width * 0.6 me.width * 0.4});
            me.isDisplayed = true;
            set(me.table,'Data',me.data);
            tpos = get(me.table, 'Position');
            text = get(me.table, 'Extent');
            tpos(3) = text(3);
            set(me.table,'Position',tpos);
        end
        function update(me)
            me.data{1,2} = sprintf('%d', me.stats.currentStepNum);
            me.data{2,2} = sprintf('%d of %d',me.stats.currentStep - 1,me.stats.totalSteps);
            ast = me.stats.averageStepTime();
            me.data{3,2} = ast.toString();
            millis = ast.millis * rs;
            tm = TimeRep(millis);
            me.data{4,2} = tm.toString();
            if me.isDisplayed
                set(me.table,'Data',me.data);
            end
        end
    end
end