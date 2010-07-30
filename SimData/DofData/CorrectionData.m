classdef CorrectionData < handle
    properties
        labels = {};
        values = [];
    end
    methods
        function set.labels(me,lbls)
            me.labels = lbls;
        end
        function clone = clone(me)
            clone = DerivedData;
            clone.labels = me.labels;
            clone.values = me.values;
        end
        function str = toString(me)
            str = '';
            for v = 1:length(me.values)
                str = sprintf('%s/%s=%f',str,me.labels{v},me.values(v));
            end
        end
    end
end