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
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = WindowLimitsDao(label, cfg)
            me.cfg = cfg;
            me.label = label;
        end
        function result = get.window1(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.window1',me.label));
            if isempty(resultSL)
                result = [];
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.window1(me,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.window1',me.label),valS);
        end
        function result = get.window2(me)
            resultSL = me.cfg.props.getPropertyList(sprintf('%s.window2',me.label));
            if isempty(resultSL)
                result = [];
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.window2(me,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList(sprintf('%s.lower1',me.label),valS);
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