% =====================================================================================================================
% Class which manages the operations manager configuration data
%
% Members:
%   cfg - a Configuration instance
%   numLbcbs, sensorNames, apply2Lbcb are all
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef Datatypes < handle
    properties
        cfg;
        su = StringListUtils();
    end
    methods
        function me = DataTypes(cfg)
            me.cfg = cfg;
        end
        function result = getInt(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = sscanf(str,'%d');
        end
        function setInt(me,key,value)
            me.cfg.props.setProperty(key,sprintf('%d',value));
        end
        function result = getBool(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = sscanf(str,'%d');
        end
        function setBool(me,key,value)
            me.cfg.props.setProperty(key,sprintf('%d',value));
        end
        function result = getStringVector(me,key,default)
            resultSL = me.cfg.props.getPropertyList(key);
            if isempty(resultSL)
                result = default;
                return;
            end
            result = me.su.sl2ca(resultSL);
        end
        function setStringVector(me,key,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList(key,valS);
        end
        function result = getDoubleVector(me,key,default)
            resultSL = me.cfg.props.getPropertyList(key);
            if isempty(resultSL)
                result = default;
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function setDoubleVector(me,key,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(key,valS);
        end
    end
end