classdef CorrectionSettingsConfigActions < handle
    properties
        handles = [];
        table;
        ccfg
        log = Logger('CorrectionSettingsConfigActions')
    end
    methods
        function me = CorrectionSettingsConfigActions(cfg)
            me.ccfg = CorrectionsSettingsDao(cfg);
            me.table = cell(20,2);
            me.fillTable();
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<UNRCH>
            end
            old = size(me.ccfg.cfgLabels,1);
            if old < 1
                me.ccfg.cfgLabels = repmat({''},20,1);
                me.ccfg.cfgValues = zeros(20,1);
            end
            switch indices(2)
                case 1
                    cols = me.ccfg.cfgLabels;
                    cols{indices(1)} = data;
                    me.ccfg.cfgLabels = cols;
                case 2
                    cols = me.ccfg.cfgValues;
                    cols(indices(1)) = data;
                    me.ccfg.cfgValues = cols;
                otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.CfgSettings,'Data',me.table);
            format = {'char','numeric'};
            set(me.handles.CfgSettings,'ColumnFormat',format);
        end
        function fillTable(me)
            for i = 1:20
                me.table{i,1} = '';
                me.table{i,2} = 0.0;
            end
            if isempty(me.ccfg.cfgLabels)
                return;
            end
            cfgLabels = me.ccfg.cfgLabels;
            cfgValues = me.ccfg.cfgValues;
            sz = size(cfgLabels,1);
            for i = 1:sz
                if isempty(cfgLabels{i}) == false
                    me.table{i,1} = cfgLabels{i};
                end
                me.table{i,2} = cfgValues(i);
            end
        end
    end
end
