classdef LbcbReading < handle
    properties
        lbcb = dofData();
        ed = dofData();
        m2d = msg2DofData();
        node = '';
    end
    methods
        function parse(msg,node)
            targets = m2d.parse(msg,node);
            me.lbcb = targets{1}.target;
            me.ed.force = me.lbcb.force;
        end
    end
end