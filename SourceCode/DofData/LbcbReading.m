classdef LbcbReading < handle
    properties
        lbcb = DofData();
        ed = DofData();
        m2d = Msg2DofData();
        node = '';
    end
    methods
        function parse(me,msg,node)
            targets = me.m2d.parse(msg,node);
            me.lbcb = targets{1}.data;
            me.ed.force = me.lbcb.force;
        end
    end
end