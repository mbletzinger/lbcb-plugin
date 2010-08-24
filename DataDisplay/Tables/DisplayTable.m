classdef DisplayTable < DisplayControl
    properties
        name = '';
        table = [];
        cnames
        data
        cdp
        log = Logger('DisplayTable');
    end
    methods
        function me = DisplayTable(name, cnames)
            me.name = name;
            me.cnames = cnames;
            lt = length(cnames);
            dt = zeros(1,lt);
            me.data = cell(1,lt);
            for i = 1:lt
                me.data{i} = sprintf('%+12.7e',dt(i));
            end
        end
        function displayMe(me)
            lt = length(me.cnames);
            w = 1075 / (lt + 1);
            widths = cell(1,lt);
            for i = 1:lt
                widths{i} = round(w);
            end
            me.fig = figure('Position',[100 100 1075 220], 'Name', me.name,'DeleteFcn',{'DisplayFactory.dispDeleted', me.name });
            me.table = uitable('ColumnName',me.cnames,'Parent',me.fig,...
                'Position',[5 5 1065 180],'ColumnFormat',repmat({'char'},1,lt));
            me.isDisplayed = true;
            set(me.table,'Data',me.data);
            set( me.table,'ColumnWidth',widths);
        end
        function update(me,data,rnames)
            me.data = data;
            if me.isDisplayed
                set(me.table,'RowName',rnames);                
                set(me.table,'Data',me.data);
            end
        end
    end
end