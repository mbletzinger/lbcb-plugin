classdef TargetConfigActions < handle
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
        function me = TargetConfigActions(cfg)
            me.tcfg = TargetConfigDao(cfg);
            me.numCps = me.tcfg.numControlPoints;
            [alAddr alOf alXf ] = me.getConfig();
            me.xformTable = alXf{1};
            me.offsets = alOf{1};
            me.address = alAddr{1};
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.Xform,'Data',me.xformTable);
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end
            me.xformsTable(indices(1),indices(2)) = data;
        end
        function setAddress(me,addr)
            me.address = addr;
        end
        function setOffset(me,dof,data)
            me.offsets(dof) = data;
        end
        function [alAddr alOf alXf ] = getConfig(me)
            alAddr = me.tcfg.addresses;
            alOf = me.tcfg.offsets;
            alXf = me.tcfg.xforms;
        end
        function switchCps(me,isForward)
            me.save();
            if isForward
                if me.cpidx < me.numCps
                    me.cpidx = me.cpidx + 1;
                end
            else
                if me.cpidx > 1
                    me.cpidx = me.cpidx - 1;
                end
            end
            [alAddr alOf alXf ] = me.getConfig();
            me.xformTable = alXf{me.cpidx};
            me.offsets = alOf{me.cpidx};
            me.address = alAddr{me.cpidx};
            me.update();
        end
        function update(me)
            set(me.handles.Address,'String',me.address);
            set(me.handles.OffsetDx,'String',sprintf('%f',me.offsets(1)));
            set(me.handles.OffsetDy,'String',sprintf('%f',me.offsets(2)));
            set(me.handles.OffsetDz,'String',sprintf('%f',me.offsets(3)));
        end
        function save(me)
            [alAddr alOf alXf ] = me.getConfig();
            alAddr{me.cpidx} = me.address;
            alOf{me.cpidx} = me.offsets;
            alXf{me.cpidx} = me.xformTable;
            me.tcfg.addresses = alAddr;
            me.tcfg.offsets = alOf;
            me.tcfg.xforms = alXf;
        end
        function new(me)
            me.save();
            [alAddr alOf alXf ] = me.getConfig();
            
        end
    end
end
