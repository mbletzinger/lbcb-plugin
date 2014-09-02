classdef DisplayTable < DisplayControl
    properties
        name = '';
        table = [];
        cnames
        data
        rnames
        cdp
        log = Logger('DisplayTable');
        width = 1200
        height = 180
    end
    methods
        function me = DisplayTable(name, cnames)
            me.name = name;
            me.cnames = cnames;
        end
        function displayMe(me)
            lt = length(me.cnames);
            w = ((me.width - 70) / lt);
            widths = cell(1,lt);
            for i = 1:lt
                widths{i} = round(w);
            end
            me.fig = figure('Position',[100 100 (me.width + 4) (me.height + 4)], 'Name', me.name,'DeleteFcn',{'DisplayFactory.dispDeleted', me.name });
            me.table = uitable('ColumnName',me.cnames,'Parent',me.fig,...
                'Position',[5 5 me.width me.height],'ColumnFormat',repmat({'char'},1,lt));
            me.isDisplayed = true;
            set(me.table,'Data',me.data);
            set(me.table,'RowName',me.rnames);                
            set( me.table,'ColumnWidth',widths);
            tpos = get(me.table, 'Position');
            text = get(me.table, 'Extent');
            tpos(3) = text(3);
%            tpos(4) = text(4);
            set(me.table,'Position',tpos);
        end
        function update(me,data,rnames)
            me.data = data;
            me.rnames = rnames;
            if me.isDisplayed
                set(me.table,'RowName',rnames);                
                set(me.table,'Data',me.data);
            end
        end
    end
end