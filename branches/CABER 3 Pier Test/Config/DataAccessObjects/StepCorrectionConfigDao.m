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
        prelimAdjustTargetFunctions
        errorTolerance
    end
    properties
        dt;
    end
    methods
        function me = StepCorrectionConfigDao(cfg)
        me.dt = DataTypes(cfg);
        end
        function result = get.doCalculations(me)
            result = me.dt.getIntVector('step.calculations',false(5,1));
        end
        function set.doCalculations(me,value)
            me.dt.setIntVector('step.calculations',value);
        end
        function result = get.doCorrections(me)
            result = me.dt.getIntVector('step.correction',false(5,1));
        end
        function set.doCorrections(me,value)
            me.dt.setIntVector('step.correction',value);
        end
        function result = get.calculationFunctions(me)
             result = me.dt.getStringVector('step.calculation.function',{'Standard' 'Test' 'Test' 'Test' 'Test'});
        end
        function set.calculationFunctions(me,value)
            me.dt.setStringVector('step.calculation.function',value);
        end
        function result = get.needsCorrectionFunctions(me)
             result = me.dt.getStringVector('step.needsCorrection.function',{'Standard' 'Test' 'Test' 'Test' 'Test'});
        end
        function set.needsCorrectionFunctions(me,value)
            me.dt.setStringVector('step.needsCorrection.function',value);
        end
        function result = get.adjustTargetFunctions(me)
             result = me.dt.getStringVector('step.adjustTarget.function',{'Standard' 'Test' 'Test' 'Test' 'Test'});
        end
        function set.adjustTargetFunctions(me,value)
            me.dt.setStringVector('step.adjustTarget.function',value);
        end
        function result = get.prelimAdjustTargetFunctions(me)
             result = me.dt.getStringVector('step.prelimAdjustTarget.function',{'<NONE>' '<NONE>'});
        end
        function set.prelimAdjustTargetFunctions(me,value)
            me.dt.setStringVector('step.prelimAdjustTarget.function',value);
        end
        function result = get.errorTolerance(me)
             result = me.dt.getStringVector('step.prelimAdjustTarget.function',{'<None>' '<None>' });
        end
        function set.errorTolerance(me,value)
            me.dt.setStringVector('step.prelimAdjustTarget.function',value);
        end
    end
end