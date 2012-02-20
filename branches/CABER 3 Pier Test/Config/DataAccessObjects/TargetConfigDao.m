% =====================================================================================================================
% Class which manages the operations manager configuration data
%
% Members:
%   cfg - a Configuration instance
%   numControlPoints, addresses, apply2Lbcb are all
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef TargetConfigDao < handle
    properties
        dt;
        empty;
    end
    properties (Dependent = true)
        numControlPoints
        addresses
        simCor2LbcbFunction
        lbcb2SimCorFunction
    end
    methods
        function me = TargetConfigDao(cfg)
            me.dt = DataTypes(cfg);
            me.empty = true;
            if isempty(me.addresses{1}) == false
                me.empty = false;
            end
        end
        function result = get.numControlPoints(me)
            result = me.dt.getInt('uisimcor.numControlPoints',1);
        end
        function set.numControlPoints(me,value)
            me.dt.setInt('uisimcor.numControlPoints',value);
        end
        function result = get.addresses(me)
            result = me.dt.getStringVector('uisimcor.addresses',cell(1,1));
        end
        function set.addresses(me,value)
            me.dt.setStringVector('uisimcor.addresses',value);
        end
        function result = get.simCor2LbcbFunction(me)
            result = me.dt.getString('target.simCor2Lbcb.transformation.function','noTransformCommand');
        end
        function set.simCor2LbcbFunction(me,value)
            me.dt.setString('target.simCor2Lbcb.transformation.function',value);
        end
        function result = get.lbcb2SimCorFunction(me)
            result = me.dt.getString('target.lbcb2SimCor.transformation.function','noTransformResponse');
        end
        function set.lbcb2SimCorFunction(me,value)
            me.dt.setString('target.lbcb2SimCor.transformation.function',value);
        end
        
        function insertControlPoint(me,s,str)
            n = me.numControlPoints;
            if me.empty
                me.empty = false;
                me.numControlPoints = 1;
            else
                me.numControlPoints = n+1;
            end
            addr = cell(me.numControlPoints,1);
            if s < n
                addr(1:s) = me.addresses(1:s);
            else
                addr(1:n) = me.addresses(1:n);
            end
            addr{s} = str;
            if s < me.numControlPoints
                addr(s + 1 : me.numControlPoints) = me.addresses(s:n);
            end
            me.addresses = addr;
        end
        function removeControlPoint(me,s)
            addr = me.addresses;
            addr(s) = [];
            n = me.numControlPoints;
            if n == 1
                me.empty = true;
                me.addresses = {};
                me.numControlPoints = 0;
            else
                me.numControlPoints = n-1;
                me.addresses = addr;
            end
        end
    end
end