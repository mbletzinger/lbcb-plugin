classdef DerivedData < handle
    properties
        labels = {};
        values = [];
    end
    methods
        function set.labels(me,lbls)
            me.labels = lbls;
            me.values = zeros(size(me.labels));
        end
    end
end