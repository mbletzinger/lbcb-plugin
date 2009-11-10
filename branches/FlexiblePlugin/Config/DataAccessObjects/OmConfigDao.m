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
        perturbationsL1
        perturbationsL2
    end
    properties
        dt;
        defAp;
    end
    methods
        function me = OmConfigDao(cfg)
        me.dt = Datatypes(cfg);
                me.defSn = cell(15,1);
                for s = 1:15
                    me.defSn{s} = '';
                end
                me.defAp = cell(15,1);
                for s = 1:15
                    me.defAp{s} = 'LBCB1';
                end
        end
        function result = get.numLbcbs(me)
            result = me.dt.getInt('om.numLbcbs',1);
        end
        function set.numLbcbs(me,value)
            me.dt.getInt('om.numLbcbs',value);
        end
        function result = get.useFakeOm(me)
            result = me.dt.getBool('om.useFakeOm',0);
        end
        function set.useFakeOm(me,value)
            me.dt.setBool('om.useFakeOm',value);
        end
        function result = get.sensorNames(me)
            result = me.dt.getStringVector('om.sensorNames',me.defSn);
        end
        function set.sensorNames(me,value)
            me.dt.setStringVector('om.sensorNames',value);
        end
        function result = get.apply2Lbcb(me)
            result = me.dt.getStringVector('om.apply2Lbcb',me.defAp);
        end
        function set.apply2Lbcb(me,value)
            me.dt.setStringVector('om.apply2Lbcb',value);
        end
        function result = get.sensitivities(me)
            result = me.dt.getDoubleVector('om.sensitivities',ones(15,1));
        end
        function set.sensitivities(me,value)
            me.dt.setDoubleVector('om.sensitivities',value);
        end
        function result = get.baseX(me)
            result = me.dt.getDoubleVector('om.location.base.x',zeros(15,1));
        end
        function set.baseX(me,value)
            me.dt.setDoubleVector('om.location.base.x',value);
        end
        function result = get.baseY(me)
            result = me.dt.getDoubleVector('om.location.base.y',zeros(15,1));
        end
        function set.baseY(me,value)
            me.dt.setDoubleVector('om.location.base.y',value);
        end
        function result = get.baseZ(me)
            result = me.dt.getDoubleVector('om.location.base.z',zeros(15,1));
        end
        function set.baseZ(me,value)
            me.dt.setDoubleVector('om.location.base.z',value);
        end
        function result = get.platX(me)
            result = me.dt.getDoubleVector('om.location.plat.x',zeros(15,1));
        end
        function set.platX(me,value)
            me.dt.setDoubleVector('om.location.plat.x',value);
        end
        function result = get.platY(me)
            result = me.dt.getDoubleVector('om.location.plat.y',zeros(15,1));
        end
        function set.platY(me,value)
            me.dt.setDoubleVector('om.location.plat.y',value);
        end
        function result = get.platZ(me)
            result = me.dt.getDoubleVector('om.location.plat.z',zeros(15,1));
        end
        function set.platZ(me,value)
            me.dt.setDoubleVector('om.location.plat.z',value);
        end
        function result = get.sensorErrorTol(me)
            result = me.dt.getDoubleVector('om.sensor.error.tol',zeros(15,1));
        end
        function set.sensorErrorTol(me,value)
            me.dt.setDoubleVector('om.sensor.error.tol',value);
        end
        function result = get.perturbationsL1(me)
            result = Target;
            perts = me.dt.getDoubleVector('om.sensor.perturbations.lbcb1',ones(6,1) * 999);

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
    end
    methods (Static)
        function yes = hasLbcb2(cfg)
            ocfg = OmConfig(cfg);
            yes = ocfg.numLbcbs > 1;
        end
    end
end