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
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = LimitsDao(label, cfg)
            me.cfg = cfg;
            me.label = label;
        end
        function result = get.upper1(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.upper1',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.upper1(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.upper1',me.label),valS);
        end
        function result = get.upper2(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.upper2',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.upper2(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.upper2',me.label),valS);
        end
        
        function result = get.lower1(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.lower1',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.lower1(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.lower1',me.label),valS);
        end
        function result = get.lower2(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.lower2',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.lower2(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.lower2',me.label),valS);
        end
        
        function result = get.used1(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.used1',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2ia(resultSL);
        end
        function set.used1(me,value)
            valS = me.su.ia2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.used1',me.label),valS);
        end
        
        function result = get.used2(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.used2',me.label));
            if isempty(resultSL)
                result = zeros(12,1);
                return;
            end
            result = me.su.sl2ia(resultSL);
        end
        function set.used2(me,value)
            valS = me.su.ia2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.used2',me.label),valS);
        end
    end
    
end
