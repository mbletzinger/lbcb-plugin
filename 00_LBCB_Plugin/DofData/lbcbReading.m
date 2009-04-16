classdef lbcbReading < handle
    properties
        lbcb = dofData();
        ed = dofData();
    end
    methods
        function parse(msg)
            [me.lbcb.disp me.lbcb.force] = parseLbcbMsg(msg);
            me.ed.force = me.lbcb.force;
        end
    end
end