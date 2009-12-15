classdef TargetConfigActions < handle
    properties
        handles = [];
        tcfg
        log = Logger('TargetConfigActions');
        selected
        flist
    end
    methods
        function me = TargetConfigActions(cfg)
            me.tcfg = TargetConfigDao(cfg);
            me.selected = 1;
            me.flist = FunctionLists('ControlPointTransformation');
        end
        function init(me,handles)
            me.handles = handles;
            set(me.handles.modelControlPoints,'String',me.tcfg.addresses);
            set(me.handles.s2lFunction,'String',me.flist.list);
            set(me.handles.l2sFunction,'String',me.flist.list);
            
            idx = me.flist.getIndex(me.tcfg.simCor2LbcbFunction);
            if idx > 0
               set(me.handles.s2lFunction,'Value',idx);
            end
            idx = me.flist.getIndex(me.tcfg.lbcb2SimCorFunction);
            if idx > 0
               set(me.handles.l2sFunction,'Value',idx);
            end
        end
        function setAddress(me,list)
            me.tcfg.addresses = list;
            me.tcfg.numControlPoints = length(list);
            set(me.handles.modelControlPoints,'String',list);
        end
        function [ str idx list ] = getSelected(me)
            list = get(me.handles.modelControlPoints,'String');
            idx = get(me.handles.modelControlPoints,'Value');
            str = list{idx};
        end
        function alAddr = getConfig(me)
            alAddr = me.tcfg.addresses;
        end
        function setLbcb2SimCorFunction(me,value)
            me.tcfg.lbcb2SimCorFunction = me.flist.list{value};
        end
        function setSimCor2LbcbFunction(me,value)
            me.tcfg.simCor2LbcbFunction = me.flist.list{value};
        end
        function edCps(me)
            [ str idx list ] = me.getSelected();
            answer = inputdlg('Address','Edit Address',1,{str});
            list{idx} = answer{1};
            me.setAddress(list);
        end
        function newCps(me)
            [ dum, idx dum, ] = me.getSelected(); %#ok<NASGU>
            answer = inputdlg('Address','New Address',1,{'MDL-00-00'});
            me.tcfg.insertControlPoint(idx,answer);
            set(me.handles.modelControlPoints,'String',me.tcfg.addresses);
        end
        function removeCps(me)
            [ dum, idx ,dum ] = me.getSelected();  %#ok<NASGU>
            me.tcfg.removeControlPoint(idx);
            set(me.handles.modelControlPoints,'String',me.tcfg.addresses);
        end
        function upCps(me)
            [ str idx olist ] = me.getSelected();
            if idx == 1
                return;
            end
            olist(idx) = olist(idx - 1);
            olist{idx - 1} = str;
            me.setAddress(olist);
        end
        function downCps(me)
            [ str idx olist ] = me.getSelected();
            if idx == me.tcfg.numControlPoints
                return;
            end
            olist(idx) = olist(idx + 1);
            olist{idx + 1} = str;
            me.setAddress(olist);
        end
    end
end
