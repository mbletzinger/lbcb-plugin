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
classdef DerivedDofDao < handle
    properties (Dependent = true)
    kfactor
    Fztarget
    end
    properties
        dt;
    end
    methods
        function me = DerivedDofDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.kfactor(me)
             result = me.dt.getDouble('derivedDofs.kfactor',1);
        end
        function set.kfactor(me,value)
            me.dt.setDouble('derivedDofs.kfactors',value);
        end
        function result = get.Fztarget(me)
             result = me.dt.getDouble('derivedDofs.Fztarget',1);
        end
        function set.Fztarget(me,value)
            me.dt.setDouble('derivedDofs.Fztarget',value);
        end
    end
end