classdef ArchiveVarsConfigActions < handle
    properties
        handles = [];
        list;
        ccfg
        log = Logger('ArchiveVarsConfigActions')
        index
    end
    methods
        function me = ArchiveVarsConfigActions(cfg)
            me.ccfg = ArchiveVarsDao(cfg);
            labels = me.ccfg.cfgLabels;
            me.list = cell(size(labels));
            me.fillTable();
        end
        function add(me)
        end
        function remove(me)
        end
        function select(me,idx)
            me.index = idx;
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.varList,'String',me.list);
        end
        function fillTable(me)
            labels = me.ccfg.cfgLabels;
            me.list = labels;
        end
    end
end
