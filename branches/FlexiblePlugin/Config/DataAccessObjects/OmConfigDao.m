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
        base
        plat
        sensorErrorTol
        useFakeOm
        perturbationsL1
        perturbationsL2
    end
    properties
        dt;
        empty;
    end
    methods
        function me = OmConfigDao(cfg)
        me.dt = DataTypes(cfg);
        me.empty = true;
        end
        function result = get.numLbcbs(me)
            result = me.dt.getInt('om.numLbcbs',1);
        end
        function set.numLbcbs(me,value)
            me.dt.setInt('om.numLbcbs',value);
        end
        function result = get.numExtSensors(me)
            result = me.dt.getInt('om.numExtSensors',1);
        end
        function set.numExtSensors(me,value)
            me.dt.setInt('om.numExtSensors',value);
        end
        function result = get.useFakeOm(me)
            result = me.dt.getBool('om.useFakeOm',0);
        end
        function set.useFakeOm(me,value)
            me.dt.setBool('om.useFakeOm',value);
        end
        function result = get.sensorNames(me)
            result = me.dt.getStringVector('om.sensorNames',{''});
        end
        function set.sensorNames(me,value)
            me.dt.setStringVector('om.sensorNames',value);
        end
        function result = get.apply2Lbcb(me)
            result = me.dt.getStringVector('om.apply2Lbcb',{'BOTH'});
        end
        function set.apply2Lbcb(me,value)
            me.dt.setStringVector('om.apply2Lbcb',value);
        end
        function result = get.sensitivities(me)
            result = me.dt.getDoubleVector('om.sensitivities',[1]);
        end
        function set.sensitivities(me,value)
            me.dt.setDoubleVector('om.sensitivities',value);
        end
        function result = get.base(me)
            sz = me.numExtSensors;
            result = me.dt.getTransVector('om.location.base','ext.sensor',sz);
        end
        function set.base(me,value)
            sz = me.numExtSensors;
            me.dt.setTransVector('om.location.base','ext.sensor',sz,value);
        end
        function result = get.plat(me)
            sz = me.numExtSensors;
            result = me.dt.getTransVector('om.location.plat','ext.sensor',sz);
        end
        function set.plat(me,value)
            sz = me.numExtSensors;
            me.dt.setTransVector('om.location.plat','ext.sensor',sz,value);
        end
        function result = get.sensorErrorTol(me)
            result = me.dt.getDoubleVector('om.sensor.error.tol',[0]);
        end
        function set.sensorErrorTol(me,value)
            me.dt.setDoubleVector('om.sensor.error.tol',value);
        end
        function result = get.perturbationsL1(me)
            result = me.dt.getTarget('om.sensor.perturbations.lbcb1');
        end
        function set.perturbationsL1(me,value)
            me.dt.setTarget('om.sensor.perturbations.lbcb1',value);
        end
        function result = get.perturbationsL2(me)
            result = me.dt.getTarget('om.sensor.perturbations.lbcb2');
        end
        function set.perturbationsL2(me,value)
            me.dt.setTarget('om.sensor.perturbations.lbcb2',value);
        end
        function addSensor(me)
            n = me.numExtSensors;
            if me.empty
                me.empty = false;
            else
                me.numExtSensors = n+1;
            end
            sn = cell(me.numExtSensors,1);
            ap = cell(me.numExtSensors,1);
            se = ones(me.numExtSensors,1);
            bs = cell(me.numExtSensors,1);
            pl = cell(me.numExtSensors,1);
            et = zeros(me.numExtSensors,1);
            
            sn(1:n) = me.sensorNames(1:n);
            ap(1:n) = me.apply2Lbcb(1:n);
            se(1:n) = me.sensitivities(1:n);
            bs(1:n) = me.base(1:n);
            pl(1:n) = me.plat(1:n);
            et(1:n) = me.sensorErrorTol(1:n);
            sn{me.numExtSensors} = ' ';
            ap{me.numExtSensors} = 'BOTH';
            bs{me.numExtSensors} = zeros(3,1);
            pl{me.numExtSensors} = zeros(3,1);
            me.sensorNames = sn;
            me.apply2Lbcb = ap;
            me.sensitivities = se;
            me.base = bs;
            me.plat = pl;
            me.sensorErrorTol = et;
        end
        function removeSensor(me,s)
            
            sn = me.sensorNames;
            ap = me.apply2Lbcb;
            se = me.sensitivities;
            bs = me.base;
            pl = me.plat;
            et = me.sensorErrorTol;

            sn(s) = [];
            ap(s) = [];
            se(s) = [];
            bs(s) = [];
            pl(s) = [];
            et(s) = [];

            n = me.numExtSensors;
            if n == 1
                me.empty = true;
            else
                me.numExtSensors = n-1;
            end
            
            me.sensorNames = sn;
            me.apply2Lbcb = ap;
            me.sensitivities = se;
            me.base = bs;
            me.plat = pl;
            me.sensorErrorTol = et;
        end

    end
end