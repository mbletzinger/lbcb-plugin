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
classdef OmConfigDao < handle
    properties (Dependent = true)
        numLbcbs
        sensorNames
        apply2Lbcb
        sensitivities
        baseX
        baseY
        baseZ
        platX
        platY
        platZ
        sensorErrorTol
        useFakeOm
        doEdCalculations
        doEdCorrection
        doDdofCalculations
        doDdofCorrection
        perturbationsL1
        perturbationsL2
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = OmConfigDao(cfg)
            me.cfg = cfg;
        end
        function result = get.numLbcbs(me)
              str = char(me.cfg.props.getProperty('om.numLbcbs'));
              if isempty(str)
                  result = 1;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.numLbcbs(me,value)
              me.cfg.props.setProperty('om.numLbcbs',sprintf('%d',value));
        end
        function result = get.useFakeOm(me)
              str = char(me.cfg.props.getProperty('om.useFakeOm'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.useFakeOm(me,value)
              me.cfg.props.setProperty('om.useFakeOm',sprintf('%d',value));
        end
        function result = get.sensorNames(me)
              resultSL = me.cfg.props.getPropertyList('om.sensorNames');
              if isempty(resultSL)
                  result = cell(15,1);
                  for s = 1:15
                      result{s} = '';
                  end
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.sensorNames(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('om.sensorNames',valS);
        end
        function result = get.apply2Lbcb(me)
              resultSL = me.cfg.props.getPropertyList('om.apply2Lbcb');
              if isempty(resultSL)
                  result = cell(15,1);
                  for i = 1:15
                      result{i} = 'LBCB1';
                  end
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.apply2Lbcb(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('om.apply2Lbcb',valS);
        end
        function result = get.sensitivities(me)
              resultSL = me.cfg.props.getPropertyList('om.sensitivities');
              if isempty(resultSL)
                  result = ones(15,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.sensitivities(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('om.sensitivities',valS);
        end
        function result = get.baseX(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.base.x');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.baseX(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.base.x',valS);
        end
        function result = get.baseY(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.base.y');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.baseY(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.base.y',valS);
        end
        function result = get.baseZ(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.base.z');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.baseZ(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.base.z',valS);
        end
        function result = get.platX(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.plat.x');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.platX(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.plat.x',valS);
        end
        function result = get.platY(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.plat.y');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.platY(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.plat.y',valS);
        end
        function result = get.platZ(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.location.plat.z');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.platZ(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.location.plat.z',valS);
        end
        function result = get.sensorErrorTol(me)
            resultSL = me.cfg.props.getPropertyList('om.sensor.error.tol');
            if isempty(resultSL)
                result = zeros(15,1);
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function set.sensorErrorTol(me,value)
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList('om.sensor.error.tol',valS);
        end
        function result = get.perturbationsL1(me)
            result = Target;
            resultSL = me.cfg.props.getPropertyList('om.sensor.perturbations.lbcb1');
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
           function set.perturbationsL1(me,value)
               perts = zeros(6,1);
               for i = 1:6
                   if value.dispDofs(i)
                       perts(i) = value.disp(i);
                   else
                       perts(i) = 1000;
                   end
               end
            valS = me.su.da2sl(perts);
            me.cfg.props.setPropertyList('om.sensor.perturbations.lbcb1',valS);
        end
        function result = get.perturbationsL2(me)
            result = Target;
            resultSL = me.cfg.props.getPropertyList('om.sensor.perturbations.lbcb2');
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
           function set.perturbationsL2(me,value)
               perts = zeros(6,1);
               for i = 1:6
                   if value.dispDofs(i)
                       perts(i) = value.disp(i);
                   else
                       perts(i) = 1000;
                   end
               end
            valS = me.su.da2sl(perts);
            me.cfg.props.setPropertyList('om.sensor.perturbations.lbcb2',valS);
           end
        
        
             
        function result = get.doEdCalculations(me)
              str = char(me.cfg.props.getProperty('om.ed.calculations'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doEdCalculations(me,value)
              me.cfg.props.setProperty('om.ed.calculations',sprintf('%d',value));
        end
        function result = get.doEdCorrection(me)
              str = char(me.cfg.props.getProperty('om.ed.correction'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doEdCorrection(me,value)
              me.cfg.props.setProperty('om.ed.correction',sprintf('%d',value));
        end
        function result = get.doDdofCalculations(me)
              str = char(me.cfg.props.getProperty('om.derivedDof.calculations'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doDdofCalculations(me,value)
              me.cfg.props.setProperty('om.derivedDof.calculations',sprintf('%d',value));
        end
        function result = get.doDdofCorrection(me)
              str = char(me.cfg.props.getProperty('om.derivedDof.correction'));
              if isempty(str)
                  result = 0;
                  return;
              end
              result = sscanf(str,'%d');
        end
        function set.doDdofCorrection(me,value)
              me.cfg.props.setProperty('om.derivedDof.correction',sprintf('%d',value));
        end
    end
end