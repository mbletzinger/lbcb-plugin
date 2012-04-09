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
classdef ConfigVarsDao < handle
    properties (Dependent = true)
        cfgLabels
        cfgValues
    end
    properties
        dt;
    end
    methods
        function me = ConfigVarsDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.cfgLabels(me)
             result = me.dt.getStringVector('configVars.labels.cfg',[]);
        end
        function set.cfgLabels(me,value)
            me.dt.setStringVector('configVars.labels.cfg',value);
        end
        function result = get.cfgValues(me)
             result = me.dt.getDoubleVector('configVars.values.cfg',[]);
        end
        function set.cfgValues(me,value)
            me.dt.setDoubleVector('configVars.values.cfg',value);
        end
    end
end