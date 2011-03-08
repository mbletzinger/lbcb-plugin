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
            if isempty(me.sensorNames{1}) == false
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
            sz = length(value);
            me.dt.setTransVector('om.location.base','ext.sensor',sz,value);
        end
        function result = get.plat(me)
            sz = me.numExtSensors;
            result = me.dt.getTransVector('om.location.plat','ext.sensor',sz);
        end
        function set.plat(me,value)
            sz = length(value);
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
        function insertSensor(me,s)
            n = me.numExtSensors;
            if me.empty
                me.numExtSensors = 1;
                me.empty = false;
                
                me.sensorNames = {' '};
                me.apply2Lbcb = {'BOTH'};
                me.base = {zeros(3,1)};
                me.plat = {zeros(3,1)};
                
            else
                me.sensorNames = me.insertIntoArray(s,me.sensorNames,true);
                me.apply2Lbcb = me.insertIntoArray(s,me.apply2Lbcb,true);
                me.sensitivities = me.insertIntoArray(s,me.sensitivities,false);
                me.base = me.insertIntoArray(s,me.base,true);
                me.plat = me.insertIntoArray(s,me.plat,true);
                me.sensorErrorTol = me.insertIntoArray(s,me.sensorErrorTol,false);
                
                me.sensorNames{s} = ' ';
                me.apply2Lbcb{s} = 'BOTH';
                me.base{s} = zeros(3,1);
                me.plat{s} = zeros(3,1);
                me.numExtSensors = n+1;
                
            end
        end
        function removeSensor(me,s)
            
            
            n = me.numExtSensors;
            if n == 1
                me.empty = true;
                me.numExtSensors = 0;
            else
                me.sensorNames = me.removeFromArray(s,me.sensorNames);
                me.apply2Lbcb = me.removeFromArray(s,me.apply2Lbcb);
                me.sensitivities = me.removeFromArray(s,me.sensitivities);
                me.base = me.removeFromArray(s,me.base);
                me.plat = me.removeFromArray(s,me.plat);
                me.sensorErrorTol = me.removeFromArray(s,me.sensorErrorTol);
                me.numExtSensors = n-1;
            end
        end
        function out = insertIntoArray(me,s,in,isCell)
            n = me.numExtSensors;
            if isCell
                out = cell(n + 1,1);
            else
                out = zeros(n + 1,1);
            end
            if s < n
                out(1:s) = in(1:s);
            else
                out(1:n) = in(1:n);
            end
            if s < n + 1
                out(s + 1 : n + 1) = in(s:n);
            end
        end
        function out = removeFromArray(me,s,in)
            n = me.numExtSensors;
            out = in;
            out(s) = [];
            if n == 1
                out = {};
            end
        end
    end
end