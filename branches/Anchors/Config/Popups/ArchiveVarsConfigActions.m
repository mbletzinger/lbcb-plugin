classdef ArchiveVarsConfigActions < handle
    properties
        handles = [];
        list;
        ccfg
        log = Logger('ArchiveVarsConfigActions')
    end
    methods
        function me = ArchiveVarsConfigActions(cfg)
            me.ccfg = ArchiveVarsDao(cfg);
            labels = me.ccfg.cfgLabels;
            me.list = cell(size(labels));
        end
        function add(me,var)
            labels = me.ccfg.cfgLabels;
            me.ccfg.cfgLabels = sort({ labels{:} var{:} }); %#ok<*CCAT>
            me.fillTable();
        end
        function remove(me)
            idx = get(me.handles.varList,'Value');
            labels = me.ccfg.cfgLabels;
            if isempty(labels) || size(labels,1) == 1
                labels = [];
            elseif idx == 1
                labels = labels(2:end);
            elseif idx == size(labels,2)
                labels = labels(1:end - 1);
            else
                labels = { labels{1:idx - 1} labels{idx + 1:end} };
            end
            me.ccfg.cfgLabels = labels;
            me.fillTable();
        end
        function initialize(me,handles)
            me.handles = handles;
            me.fillTable();
        end
        function fillTable(me)
            labels = me.ccfg.cfgLabels;
            me.list = labels;
            if isempty(labels)
                return;
            end
            val = get(me.handles.varList,'Value');
            if val > size(labels,1)
                set(me.handles.varList,'Value',size(labels,1));
            end
            set(me.handles.varList,'String',me.list);
        end
    end
end
