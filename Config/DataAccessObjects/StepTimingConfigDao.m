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
classdef StepTimingConfigDao < handle
    properties (Dependent = true)
        acceptStep
        doStepSplitting
        correctEverySubstep
        substepIncL1
        substepIncL2
        triggerEverySubstep
        triggerDelay
    end
    properties
        dt;
    end
    methods
        function me = StepTimingConfigDao(cfg)
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
        
        function result = get.doStepSplitting(me)
            result = me.dt.getBool('step.stepSplitting',0);
        end
        function set.doStepSplitting(me,value)
            me.dt.setBool('step.stepSplitting',value);
        end
        function result = get.acceptStep(me)
            result = me.dt.getBool('step.forceAccept',0);
        end
        function set.acceptStep(me,value)
            me.dt.setBool('step.forceAccept',value);
        end
        function result = get.correctEverySubstep(me)
             result = me.dt.getInt('step.correctEveryStep',0);
        end
        function set.correctEverySubstep(me,value)
            me.dt.setInt('step.correctEveryStep',value);
        end
        function result = get.triggerEverySubstep(me)
             result = me.dt.getInt('step.triggerEveryStep',0);
        end
        function set.triggerEverySubstep(me,value)
            me.dt.setInt('step.triggerEveryStep',value);
        end
        function result = get.triggerDelay(me)
             result = me.dt.getInt('step.triggerDelay',0);
        end
        function set.triggerDelay(me,value)
            me.dt.setInt('step.triggerDelay',value);
        end
    end
end