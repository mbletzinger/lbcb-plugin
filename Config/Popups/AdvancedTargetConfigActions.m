classdef AdvancedTargetConfigActions < handle
    properties
        handles = [];
        tcfg
        log = Logger
        xformTable = eye(6);
        offsets = zeros(3,1);
        address
        cpidx;
    end
    methods
        function me = AdvancedTargetConfigActions(cfg)
            me.tcfg = TargetConfigDao(cfg);
            [alAddr alAp alOf alXf ] = me.getConfig();
            idx = 1;
            me.xformTable = alXf{idx};
            me.offsets = alOf{idx};
            me.address = alAddr{idx};
            me.cpidx = idx;
        end
        function init(me,handles)
            me.handles = handles;
            me.uDisplay();
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end            
            me.xformTable(indices(1),indices(2)) = data;
            me.tcfg.xforms{me.cpidx} = me.xformTable;
            me.uDisplay();
        end
        function setAddress(me,addr)
            me.tcfg.addresses{me.cpidx} = addr;
        end
        function setOffset(me,dof,str)
            data = sscanf(str,'%f');
            me.offsets(dof) = data;
            me.tcfg.offsets{me.cpidx} = me.offsets;
        end
        function [alAddr alAp alOf alXf ] = getConfig(me)
            alAddr = me.tcfg.addresses;
            alOf = me.tcfg.offsets;
            alXf = me.tcfg.xforms;
            alAp = me.tcfg.apply2Lbcb;
        end
        function uDisplay(me)
            set(me.handles.Address,'String',me.address);
            set(me.handles.OffsetDx,'String',sprintf('%f',me.offsets(1)));
            set(me.handles.OffsetDy,'String',sprintf('%f',me.offsets(2)));
            set(me.handles.OffsetDz,'String',sprintf('%f',me.offsets(3)));
            set(me.handles.Xform,'Data',me.xformTable);
        end
    end
end
