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
classdef StepCorrectionConfigDao < handle
    properties (Dependent = true)
        doCalculations
        doCorrections
        calculationFunctions
        needsCorrectionFunctions
        adjustTargetFunctions
        prelimAdjustTargetFunction
    end
    properties
        dt;
    end
    methods
        function me = StepCorrectionConfigDao(cfg)
        me.dt = DataTypes(cfg);
        end
        function result = get.doCalculations(me)
            result = me.dt.getIntVector('step.calculations',[]);
        end
        function set.doCalculations(me,value)
            me.dt.setIntVector('step.calculations',value);
        end
        function result = get.doCorrections(me)
            result = me.dt.getIntVector('step.correction',[]);
        end
        function set.doCorrections(me,value)
            me.dt.setIntVector('step.correction',value);
        end
        function result = get.calculationFunctions(me)
             result = me.dt.getStringVector('step.calculation.function',[]);
        end
        function set.calculationFunctions(me,value)
            me.dt.setStringVector('step.calculation.function',value);
        end
        function result = get.needsCorrectionFunctions(me)
             result = me.dt.getStringVector('step.needsCorrection.function',[]);
        end
        function set.needsCorrectionFunctions(me,value)
            me.dt.setStringVector('step.needsCorrection.function',value);
        end
        function result = get.adjustTargetFunctions(me)
             result = me.dt.getStringVector('step.adjustTarget.function',[]);
        end
        function set.adjustTargetFunctions(me,value)
            me.dt.setStringVector('step.adjustTarget.function',value);
        end
        function result = get.prelimAdjustTargetFunction(me)
             result = me.dt.getString('step.prelimAdjustTarget.function',[]);
        end
        function set.prelimAdjustTargetFunction(me,value)
            me.dt.setString('step.prelimAdjustTarget.function',value);
        end
    end
end