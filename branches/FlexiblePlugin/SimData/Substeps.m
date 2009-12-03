classdef  Substeps < handle
    properties
    sIdx = 1;
    endOfFile = false;
    end
    properties (Access = private)
        stps
    end
    properties (Dependent = true)
        steps
    end
    methods
        function step = next(me)
            if me.sIdx > length(me.steps)
                step = [];
                me.endOfFile = true;
                return;
            end
            step = me.steps{me.sIdx};
            me.sIdx = me.sIdx + 1;
        end
        function set.steps(me,s)
            me.stps = s;
            me.endOfFile = false;
        end
        function s = get.steps(me)
            s = me.stps;
        end
    end
end