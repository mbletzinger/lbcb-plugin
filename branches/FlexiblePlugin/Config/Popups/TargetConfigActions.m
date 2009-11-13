classdef TargetConfigActions < handle
    properties
        handles = [];
        tcfg
        log = Logger
        mcpTable
        aps
        selected
    end
    methods
        function me = TargetConfigActions(cfg)
            me.tcfg = TargetConfigDao(cfg);
            me.aps = StateEnum({'LBCB1','LBCB2','BOTH'});
            me.selected = 1;
            if me.tcfg.empty
                me.addControlPoint(0);
            else
                me.uDisplay(0);
            end
        end
        function init(me,handles)
            me.handles = handles;
            format = {'char',me.aps.states};
            set(me.handles.modelControlPoints,'ColumnFormat',format)
            set(me.handles.modelControlPoints,'Data',me.mcpTable);
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end

            [alAddr alAp of xf] = me.getConfig();
            switch indices(2)
                case 1
                    alAddr{indices(1)} = data;
                    me.tcfg.addresses = alAddr;
                case 2
                    alAp{indices(1)} = data;
                    me.tcfg.apply2Lbcb = alAp;
                 otherwise
                    me.log.error(dbstack,sprintf('Cannot handle column %d',indices(2)));
            end
            me.uDisplay(1);
        end
        function [alAddr alAp of xf] = getConfig(me)
            alAddr = me.tcfg.addresses;
            alAp = me.tcfg.apply2Lbcb;
            of = me.tcfg.offsets;
            xf = me.tcfg.xforms;
        end
        function addControlPoint(me,haveHandle)
            me.tcfg.addControlPoint();
            me.uDisplay(haveHandle);
        end
        function selectedRow(me,indices)
            if isempty(indices)
                return;
            end
            me.selected = indices(1);
        end        
        function removeControlPoint(me,haveHandle)
            me.mcpTable(me.selected,:) = [];
            me.ocfg.removeControlPoint(me.selected);
            if me.selected > me.ocfg.numExtSensors
                me.selected = me.ocfg.numExtSensors;
            end
            me.uDisplay(haveHandle);
        end
        function uDisplay(me,haveHandle)
            [alAddr alAp of xf] = me.getConfig();
            me.mcpTable = cell(me.tcfg.numControlPoints,2);
            for cps = 1:me.tcfg.numControlPoints
                me.mcpTable{cps,1} = alAddr{cps};
                me.mcpTable{cps,2} = alAp{cps};
            end
            if haveHandle
                set(me.handles.modelControlPoints,'Data',me.mcpTable);
            end
        end

    end
end
