classdef  Substeps < handle
    properties
    steps = {};
    sIdx = 1;
    endOfFile = 0;
    end
    methods
        function step = next(me)
            if me.sIdx > length(me.steps)
                step = [];
                me.endOfFile = 1;
                return;
            end
            step = me.steps{me.sIdx};
            me.sIdx = me.sIdx + 1;
        end
    end
end