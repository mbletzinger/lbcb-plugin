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
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = StepConfigDao(cfg)
            me.cfg = cfg;
        end
        function result = get.substepIncL1(me)
            result = Target;
            resultSL = me.cfg.props.getPropertyList('step.sensor.substepInc.lbcb1');
            if isempty(resultSL)
                return;
            end
            perts = me.su.sl2da(resultSL);
            for i = 1:6
                if perts(i) < 999
                    result.setDispDof(i,perts(i));
                end
            end
        end
           function set.substepIncL1(me,value)
               perts = zeros(6,1);
               for i = 1:6
                   if value.dispDofs(i)
                       perts(i) = value.disp(i);
                   else
                       perts(i) = 1000;
                   end
               end
            valS = me.su.da2sl(perts);
            me.cfg.props.setPropertyList('step.sensor.substepInc.lbcb1',valS);
        end
        function result = get.substepIncL2(me)
            result = Target;
            resultSL = me.cfg.props.getPropertyList('step.sensor.substepInc.lbcb2');
            if isempty(resultSL)
                return;
            end
            perts = me.su.sl2da(resultSL);
            for i = 1:6
                if perts(i) < 999
                    result.setDispDof(i,perts(i));
                end
            end
        end
           function set.substepIncL2(me,value)
               perts = zeros(6,1);
               for i = 1:6
                   if value.dispDofs(i)
                       perts(i) = value.disp(i);
                   else
                       perts(i) = 1000;
                   end
               end
            valS = me.su.da2sl(perts);
            me.cfg.props.setPropertyList('step.sensor.substepInc.lbcb2',valS);
           end
        
        
             
        function result = get.doEdCalculations(me)
              str = char(me.cfg.props.getProperty('step.ed.calculations'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doEdCalculations(me,value)
              me.cfg.props.setProperty('step.ed.calculations',sprintf('%d',value));
        end
        function result = get.doEdCorrection(me)
              str = char(me.cfg.props.getProperty('step.ed.correction'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doEdCorrection(me,value)
              me.cfg.props.setProperty('step.ed.correction',sprintf('%d',value));
        end
        function result = get.doDdofCalculations(me)
              str = char(me.cfg.props.getProperty('step.derivedDof.calculations'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doDdofCalculations(me,value)
              me.cfg.props.setProperty('step.derivedDof.calculations',sprintf('%d',value));
        end
        function result = get.doDdofCorrection(me)
              str = char(me.cfg.props.getProperty('step.derivedDof.correction'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doDdofCorrection(me,value)
              me.cfg.props.setProperty('step.derivedDof.correction',sprintf('%d',value));
        end
        function result = get.doStepSplitting(me)
              str = char(me.cfg.props.getProperty('step.stepSplitting'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doStepSplitting(me,value)
              me.cfg.props.setProperty('step.stepSplitting',sprintf('%d',value));
        end
        function result = get.correctEverySubstep(me)
              str = char(me.cfg.props.getProperty('step.correctEveryStep'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.correctEverySubstep(me,value)
              me.cfg.props.setProperty('step.correctEveryStep',sprintf('%d',value));
        end
    end
end