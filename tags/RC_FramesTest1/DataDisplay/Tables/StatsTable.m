classdef StatsTable < DisplayControl
    properties
        name = '';
        table = [];
        stats
        log = Logger('StatsTable');
        width = 400
        height = 120
        data
        plot
    end
    methods
        function me = StatsTable(stats)
            me.name = 'Test Statistics';
            me.stats = stats;
            rnames = {'Current Step';...
                'Finished';...
                'Current Step Time';...
                'Average Step Time';...
                'Estimated Time Remaining'...
                };
            me.data = cell(length(rnames),2);
            me.data(:,1) = rnames;
            spacer = '                    ';
            for i = 1:length(rnames)
                me.data{i,2} = spacer;
            end
            me.plot = me;
            
        end
        function displayMe(me)
            
            me.fig = figure('Position',[100 100 (me.width + 4) (me.height + 4)],...
                'Name', me.name,...
                'Menubar','none',....
                'DeleteFcn',{'DisplayFactory.dispDeleted', me.name });
            me.table = uitable('Parent',me.fig,...
                'Position',[0 0 me.width me.height ],...
                'ColumnFormat',{'char', 'char'}, ...
                'FontSize',12,...
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
        function update(me,target)
            if me.stats.ended == false
                return;
            end
                
            rs = me.stats.remainingSteps();
            stepn =  me.stats.currentStepNum;
            if stepn > 0
                stepn = stepn + 1;
            end
            me.data{1,2} = sprintf('%d',stepn);
            stp = me.stats.currentStep;
            if stp < 0
                stp = 0;
            end
            me.data{2,2} = sprintf('%d of %d',stp,me.stats.totalSteps);
            tm = me.stats.latestStepTime();
            me.data{3,2} = tm.toString();
            ast = me.stats.averageStepTime();
            me.data{4,2} = ast.toString();
            millis = ast.millis * rs;
            tm = TimeRep(millis);
            me.data{5,2} = tm.toString();
            if me.isDisplayed
                set(me.table,'Data',me.data);
            end
        end
    end
end