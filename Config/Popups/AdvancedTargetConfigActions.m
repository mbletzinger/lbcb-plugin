classdef AdvancedTargetConfigActions < handle
    properties
        handles = [];
        tcfg
        log = Logger
        xformTable = eye(6);
        offsets = zeros(3,1);
        address
        cpidx = 1;
        numCps
    end
    methods
        function me = AdvancedTargetConfigActions(cfg,idx)
            me.tcfg = TargetConfigDao(cfg);
            me.numCps = me.tcfg.numControlPoints;
            [alAddr alAp alOf alXf ] = me.getConfig();
            me.xformTable = alXf{idx};
            me.offsets = alOf{idx};
            me.address = alAddr{idx};
            me.cpidx = idx;
        end
        function init(me,handles)
            me.handles = handles;
            set(me.handles.Xform,'Data',me.xformTable);
            me.update();
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end
            me.xformsTable{indices(1),indices(2)} = data;
        end
        function setAddress(me,addr)
            me.address = addr;
        end
        function setOffset(me,dof,str)
            data = sscanf('%f',str)
            me.offsets(dof) = data;
        end
        function [alAddr alAp alOf alXf ] = getConfig(me)
            alAddr = me.tcfg.addresses;
            alOf = me.tcfg.offsets;
            alXf = me.tcfg.xforms;
            alAp = me.tcfg.apply2Lbcb;
        end
        function update(me)
            set(me.handles.Address,'String',me.address);
            set(me.handles.OffsetDx,'String',sprintf('%f',me.offsets(1)));
            set(me.handles.OffsetDy,'String',sprintf('%f',me.offsets(2)));
            set(me.handles.OffsetDz,'String',sprintf('%f',me.offsets(3)));
        end
        function save(me)
            [alAddr alAp alOf alXf ] = me.getConfig();
            alAddr{me.cpidx} = me.address;
            alOf{me.cpidx} = me.offsets;
            alXf{me.cpidx} = me.xformTable;
            me.tcfg.addresses = alAddr;
            me.tcfg.offsets = alOf;
            me.tcfg.xforms = alXf;
        end
    end
end
