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
        apply2Lbcb
        addresses
        offsets
        xforms
        simCor2LbcbFunction
        lbcb2SimCorFunction
    end
    methods
        function me = TargetConfigDao(cfg)
            me.dt = DataTypes(cfg);
            me.empty = true;
        end
        function result = get.numControlPoints(me)
            result = me.dt.getInt('uisimcor.numControlPoints',1);
        end
        function set.numControlPoints(me,value)
            me.dt.setInt('uisimcor.numControlPoints',value);
        end
        function result = get.apply2Lbcb(me)
            result = me.dt.getStringVector('uisimcor.apply2Lbcb',cell(1,1));
        end
        function set.apply2Lbcb(me,value)
            me.dt.setStringVector('uisimcor.apply2Lbcb',value);
        end
        function result = get.offsets(me)
            sz = me.numControlPoints;
            result = me.dt.getTransVector('uisimcor.offsets','cp',sz);
        end
        function set.offsets(me,value)
            sz = me.numControlPoints;
            me.dt.setTransVector('uisimcor.offsets','cp',sz,value);
        end
        function result = get.xforms(me)
            sz = me.numControlPoints;
            result = me.dt.getDofMatrix('uisimcor.xforms','cp',sz);
        end
        function set.xforms(me,value)
            sz = me.numControlPoints;
            me.dt.setDofMatrix('uisimcor.xforms','cp',sz,value);
        end
        function result = get.addresses(me)
            result = me.dt.getStringVector('uisimcor.addresses',cell(1,1));
        end
        function set.addresses(me,value)
            me.dt.setStringVector('uisimcor.addresses',value);
        end
        function result = get.simCor2LbcbFunction(me)
            result = me.dt.getString('target.simCor2Lbcb.transformation.function',0);
        end
        function set.simCor2LbcbFunction(me,value)
            me.dt.setString('target.simCor2Lbcb.transformation.function',value);
        end
         function result = get.lbcb2SimCorFunction(me)
            result = me.dt.getString('target.lbcb2SimCor.transformation.function',0);
        end
        function set.lbcb2SimCorFunction(me,value)
            me.dt.setString('target.lbcb2SimCor.transformation.function',value);
        end
       
        function addControlPoint(me)
            n = me.numControlPoints;
            if me.empty
                me.empty = false;
            else
                me.numControlPoints = n+1;
            end
            addr = cell(me.numControlPoints,1);
            ap = cell(me.numControlPoints,1);
            of = cell(me.numControlPoints,1);
            xf = cell(me.numControlPoints,1);
            addr(1:n) = me.addresses(1:n);
            ap(1:n) = me.apply2Lbcb(1:n);
            of(1:n) = me.offsets(1:n);
            xf(1:n) = me.xforms(1:n);
            addr{me.numControlPoints} = ' ';
            ap{me.numControlPoints} = 'BOTH';
            of{me.numControlPoints} = zeros(3,1);
            xf{me.numControlPoints} = eye(6);
            me.addresses = addr;
            me.apply2Lbcb = ap;
            me.offsets = of;
            me.xforms = xf;
        end
        function removeControlPoint(me,s)
            addr = me.addresses;
            ap = cell(me.numControlPoints,1);
            of = me.offsets;
            xf = me.xforms;
            addr(s) = [];
            ap(s) = [];
            of(s) = [];
            xf(s) = [];
            n = me.numControlPoints;
            if n == 1
                me.empty = true;
            else
                me.numControlPoints = n-1;
            end
            me.addresses = addr;
            me.apply2Lbcb = ap;
            me.offsets = of;
            me.xforms = xf;
        end
    end
end