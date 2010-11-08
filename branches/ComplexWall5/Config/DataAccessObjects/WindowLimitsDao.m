% =====================================================================================================================
% Class which manages window limits
%
% Members:
%   cfg - a Configuration instance
%   window1, window2 are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef WindowLimitsDao < handle
    properties (Dependent = true)
        window1 = [];
        window2 = [];
        used1 = [];
        used2 = [];
    end
    properties
        label = 'limits';
        dt;
    end
    methods
        function me = WindowLimitsDao(label, cfg)
            me.dt = DataTypes(cfg);
            me.label = label;
        end
        function result = get.window1(me)
            result = me.dt.getDoubleVector(sprintf('%s.window1',me.label),zeros(12,1));
        end
        function set.window1(me,value)
            me.dt.setDoubleVector(sprintf('%s.window1',me.label),value);
        end
        function result = get.window2(me)
            result = me.dt.getDoubleVector(sprintf('%s.window2',me.label),zeros(12,1));
        end
        function set.window2(me,value)
            me.dt.setDoubleVector(sprintf('%s.window2',me.label),value);
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