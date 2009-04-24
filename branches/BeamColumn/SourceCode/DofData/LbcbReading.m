classdef lbcbReading < handle
    properties
        lbcb = dofData();
        ed = dofData();
        m2d = msg2DofData();
    end
    methods
        function parse(msg)
            targets = m2d.parse(msg);
            me.lbcb = targets{1}.target;
            me.ed.force = me.lbcb.force;
        end
    end
end