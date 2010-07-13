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
classdef CorrectionsSettingsDao < handle
    properties (Dependent = true)
        cfgLabels
        cfgValues
        datLabels
        archLabels
    end
    properties
        dt;
    end
    methods
        function me = CorrectionsSettingsDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.cfgLabels(me)
             result = me.dt.getStringVector('correctionSettings.labels.cfg',[]);
        end
        function set.cfgLabels(me,value)
            me.dt.setStringVector('correctionSettings.labels.cfg',value);
        end
        function result = get.cfgValues(me)
             result = me.dt.getDoubleVector('correctionSettings.values.cfg',[]);
        end
        function set.cfgValues(me,value)
            me.dt.setDoubleVector('correctionSettings.values.cfg',value);
        end
        function result = get.datLabels(me)
             result = me.dt.getStringVector('correctionSettings.labels.dat',[]);
        end
        function set.datLabels(me,value)
            me.dt.setStringVector('correctionSettings.labels.dat',value);
        end
        function result = get.archLabels(me)
             result = me.dt.getStringVector('correctionSettings.labels.arch',[]);
        end
        function set.archLabels(me,value)
            me.dt.setStringVector('correctionSettings.labels.arch',value);
        end
    end
end