classdef model2LbcbTransform < handle
    properties
        transform = [];
        scale = [];
    end
    methods
        function model2LbcbTransform(transform,scale)
            me.transform = transform;
            me.scale = scale;
        end
        function command = model2Lbcb(target)
            command = me.transform * (me.scale * target);
        end
        function target = lbcb2Model(command)
            target = inv(me.transform)*command./me.scale;
        end
    end
end