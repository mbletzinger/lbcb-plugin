classdef TargetConfigActions < handle
    properties
        handles = [];
        tcfg
        log = Logger
        mcpTable = cell(15,2);
        numCps
        aps
    end
    methods
        function me = TargetConfigActions(cfg)
            me.tcfg = TargetConfigDao(cfg);
            me.aps = StateEnum({'LBCB1','LBCB2','BOTH'});
            me.numCps = me.tcfg.numControlPoints;
            [alAddr alAp] = me.getConfig();
            for cps = 1: length(alAddr)
                me.mcpTable{cps,1} = alAddr{cps};
                me.mcpTable{cps,2} = alAp{cps};
            end
        end
        function init(me,handles)
            me.handles = handles;
            format = {'char',me.aps.states};
            set(me.handles.modelControlPoints,'ColumnFormat',format)
            set(me.handles.modelControlPoints,'Data',me.mcpTable);
        end
        function setCell(me,indices,data,errString)
            mydata = data
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end
            me.mcpTable{indices(1),indices(2)} = data;
            table = me.mcpTable
            set(me.handles.modelControlPoints,'Data',me.mcpTable);
        end
        function setAddress(me,addr)
            me.address = addr;
        end
        function setOffset(me,dof,data)
            me.offsets(dof) = data;
        end
        function [alAddr alAp ] = getConfig(me)
            alAddr = me.tcfg.addresses;
            alAp = me.tcfg.apply2Lbcb;
        end
        function save(me)
            lg = length(me.mcpTable{:,1});
            alAddr = cell(lg + 1,1);
            alAp = cell(lg + 1,1);
            for cps = 1 : lg
                alAddr{cps} = me.mcpTable{cps,1};
                alAp{cps} = me.mcpTable{cps,2};
            end
            me.tcfg.addresses = alAddr;
            me.tcfg.apply2Lbcb = alAp;
        end
    end
end
