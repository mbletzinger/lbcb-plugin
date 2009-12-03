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
classdef StepConfigDao < handle
    properties (Dependent = true)
        doEdCalculations
        doEdCorrection
        doDdofCalculations
        doDdofCorrection
        doStepSplitting
        correctEverySubstep
        substepIncL1
        substepIncL2
        edCalculationFunction
        ddCalculationFunction
        ddCorrectionFunction
    end
    properties
        dt;
    end
    methods
        function me = StepConfigDao(cfg)
        me.dt = DataTypes(cfg);
        end
        function result = get.substepIncL1(me)
            result = me.dt.getTarget('step.sensor.substepInc.lbcb1');
        end
        function set.substepIncL1(me,value)
            me.dt.setTarget('step.sensor.substepInc.lbcb1',value);
        end
        function result = get.substepIncL2(me)
            result = me.dt.getTarget('step.sensor.substepInc.lbcb2');
        end
        function set.substepIncL2(me,value)
            me.dt.setTarget('step.sensor.substepInc.lbcb2',value);
        end
        
        function result = get.doEdCalculations(me)
            result = me.dt.getBool('step.ed.calculations',0);
        end
        function set.doEdCalculations(me,value)
            me.dt.setBool('step.ed.calculations',value);
        end
        function result = get.doEdCorrection(me)
            result = me.dt.getBool('step.ed.correction',0);
        end
        function set.doEdCorrection(me,value)
            me.dt.setBool('step.ed.correction',value);
        end
        function result = get.doDdofCalculations(me)
            result = me.dt.getBool('step.derivedDof.calculations',0);
        end
        function set.doDdofCalculations(me,value)
            me.dt.setBool('step.derivedDof.calculations',value);
        end
        function result = get.doDdofCorrection(me)
            result = me.dt.getBool('step.derivedDof.correction',0);
        end
        function set.doDdofCorrection(me,value)
            me.dt.setBool('step.derivedDof.correction',value);
        end
        function result = get.doStepSplitting(me)
            result = me.dt.getBool('step.stepSplitting',0);
        end
        function set.doStepSplitting(me,value)
            me.dt.setBool('step.stepSplitting',value);
        end
        function result = get.correctEverySubstep(me)
             result = me.dt.getInt('step.correctEveryStep',0);
        end
        function set.correctEverySubstep(me,value)
            me.dt.setInt('step.correctEveryStep',value);
        end
        function result = get.edCalculationFunction(me)
             result = me.dt.getString('step.ed.calculation.function','noEdCalculate');
        end
        function set.edCalculationFunction(me,value)
            me.dt.setString('step.ed.calculation.function',value);
        end
        function result = get.ddCalculationFunction(me)
             result = me.dt.getString('step.dd.calculation.function','noDdCalculate');
        end
        function set.ddCalculationFunction(me,value)
            me.dt.setString('step.dd.calculation.function',value);
        end
        function result = get.ddCorrectionFunction(me)
             result = me.dt.getString('step.dd.correction.function','noDdAdjustTarget');
        end
        function set.ddCorrectionFunction(me,value)
            me.dt.setString('step.dd.correction.function',value);
        end
    end
end