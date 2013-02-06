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
classdef ControlDofConfigDao < handle
    properties (Dependent = true)
        cDofL1
        cDofL2
    end
    properties
        dt;
    end
    methods
        function me = ControlDofConfigDao(cfg)
        me.dt = DataTypes(cfg);
        end
        function result = get.cDofL1(me)
            result = me.dt.getBoolVector('control.dofs.lbcb1',false(12,1));
        end
        function set.cDofL1(me,value)
            me.dt.setBoolVector('control.dofs.lbcb1',value);
        end
        function result = get.cDofL2(me)
            result = me.dt.getBoolVector('control.dofs.lbcb2',false(12,1));
        end
        function set.cDofL2(me,value)
            me.dt.setBoolVector('control.dofs.lbcb2',value);
        end
    end
end