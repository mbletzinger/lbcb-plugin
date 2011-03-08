% =====================================================================================================================
% Class which manages upper and lower limits
%
% Members:
%   cfg - a Configuration instance
%   upper1, upper2, lower1, lower2, used1, used2, are all
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef LimitsDao < handle
    properties (Dependent = true)
        upper1 = [];
        upper2 = [];
        lower1 = [];
        lower2 = [];
        used1 = [];
        used2 = [];
    end
    properties
        label = 'limits';
        dt;
    end
    methods
        function me = LimitsDao(label, cfg)
            me.dt = DataTypes(cfg);
            me.label = label;
        end
        function result = get.upper1(me)
            result = me.dt.getDoubleVector(sprintf('%s.upper1',me.label),zeros(12,1));
        end
        function set.upper1(me,value)
            me.dt.setDoubleVector(sprintf('%s.upper1',me.label),value);
        end
        function result = get.upper2(me)
            result = me.dt.getDoubleVector(sprintf('%s.upper2',me.label),zeros(12,1));
        end
        function set.upper2(me,value)
            me.dt.setDoubleVector(sprintf('%s.upper2',me.label),value);
        end
        
        function result = get.lower1(me)
            result = me.dt.getDoubleVector(sprintf('%s.lower1',me.label),zeros(12,1));
        end
        function set.lower1(me,value)
            me.dt.setDoubleVector(sprintf('%s.lower1',me.label),value);
        end
        function result = get.lower2(me)
            result = me.dt.getDoubleVector(sprintf('%s.lower2',me.label),zeros(12,1));
        end
        function set.lower2(me,value)
            me.dt.setDoubleVector(sprintf('%s.lower2',me.label),value);
        end
        
        function result = get.used1(me)
            result = me.dt.getIntVector(sprintf('%s.used1',me.label),zeros(12,1));
        end
        function set.used1(me,value)
            me.dt.setDoubleVector(sprintf('%s.used1',me.label),value);
        end
        function result = get.used2(me)
            result = me.dt.getIntVector(sprintf('%s.used2',me.label),zeros(12,1));
        end
        function set.used2(me,value)
            me.dt.setIntVector(sprintf('%s.used2',me.label),value);
        end
    end
    
end
