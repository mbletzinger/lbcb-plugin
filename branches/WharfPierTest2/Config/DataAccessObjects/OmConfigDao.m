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
        numExtSensors
        sensorNames
        apply2Lbcb
        sensitivities
        fixedLocations
        pinLocations
        transPert
        rotPert
        optsetMaxFunEvals
        optsetMaxIter
        optsetTolFun
        optsetTolX
        optsetJacob
        initialCorrectionL1
        initialCorrectionL2
        
    end
    properties
        dt;
        empty;
    end
    methods
        function me = OmConfigDao(cfg)
            me.dt = DataTypes(cfg);
            me.empty = true;
            if isempty(me.sensorNames) == false
                me.empty = false;
            end
        end
        function result = get.numLbcbs(me)
            result = me.dt.getInt('om.numLbcbs',1);
        end
        function set.numLbcbs(me,value)
            me.dt.setInt('om.numLbcbs',value);
        end
        function result = get.numExtSensors(me)
            result = me.dt.getInt('om.numExtSensors',0);
        end
        function set.numExtSensors(me,value)
            me.dt.setInt('om.numExtSensors',value);
        end
        function result = get.sensorNames(me)
            result = me.dt.getStringVector('om.sensorNames',[]);
        end
        function set.sensorNames(me,value)
            me.dt.setStringVector('om.sensorNames',value);
        end
        function result = get.apply2Lbcb(me)
            result = me.dt.getStringVector('om.apply2Lbcb',[]);
        end
        function set.apply2Lbcb(me,value)
            me.dt.setStringVector('om.apply2Lbcb',value);
        end
        function result = get.sensitivities(me)
            result = me.dt.getDoubleVector('om.sensitivities',[1]); %#ok<*NBRAK>
        end
        function set.sensitivities(me,value)
            me.dt.setDoubleVector('om.sensitivities',value);
        end
        function result = get.fixedLocations(me)
            sz = me.numExtSensors;
            result = me.dt.getTransVector('om.location.fixedLocations','ext.sensor',sz);
        end
        function set.fixedLocations(me,value)
            sz = length(value);
            me.dt.setTransVector('om.location.fixedLocations','ext.sensor',sz,value);
        end
        function result = get.pinLocations(me)
            sz = me.numExtSensors;
            result = me.dt.getTransVector('om.location.pinLocations','ext.sensor',sz);
        end
        function set.pinLocations(me,value)
            sz = length(value);
            me.dt.setTransVector('om.location.pinLocations','ext.sensor',sz,value);
        end
        function result = get.transPert(me)
            result = me.dt.getDouble('om.sensor.perturbations.trans',0.000001);
        end
        function set.transPert(me,value)
            me.dt.setDouble('om.sensor.perturbations.trans',value);
        end
        function result = get.rotPert(me)
            result = me.dt.getDouble('om.sensor.perturbations.rot',0.0000001);
        end
        function set.rotPert(me,value)
            me.dt.setDouble('om.sensor.perturbations.rot',value);
        end
        function result = get.optsetMaxFunEvals(me)
            result = me.dt.getInt('om.optset.maxFunEvals',1000);
        end
        function set.optsetMaxFunEvals(me,value)
            me.dt.setInt('om.optset.maxFunEvals',value);
        end
        function result = get.optsetMaxIter(me)
            result = me.dt.getInt('om.optset.maxIter',100);
        end
        function set.optsetMaxIter(me,value)
            me.dt.setInt('om.optset.maxIter',value);
        end
        function result = get.optsetTolFun(me)
            result = me.dt.getDouble('om.optset.tolFun',1e-8);
        end
        function set.optsetTolFun(me,value)
            me.dt.setDouble('om.optset.tolFun',value);
        end
        function result = get.optsetTolX(me)
            result = me.dt.getDouble('om.optset.tolX',1e-12);
        end
        function set.optsetTolX(me,value)
            me.dt.setDouble('om.optset.tolX',value);
        end
        function result = get.optsetJacob(me)
            result = me.dt.getBool('om.optset.jacob',1);
        end
        function set.optsetJacob(me,value)
            me.dt.setBool('om.optset.jacob',value);
        end
        function result = get.initialCorrectionL1(me)
            result = me.dt.getTarget('step.om.initialCorrection.lbcb1');
        end
        function set.initialCorrectionL1(me,value)
            me.dt.setTarget('step.om.initialCorrection.lbcb1',value);
        end
        function result = get.initialCorrectionL2(me)
            result = me.dt.getTarget('step.om.initialCorrection.lbcb2');
        end
        function set.initialCorrectionL2(me,value)
            me.dt.setTarget('step.om.initialCorrection.lbcb2',value);
        end
    end
end