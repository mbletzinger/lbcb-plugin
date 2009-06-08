% =====================================================================================================================
% Class which calculates the position of an LBCB platform based on external
% sensors
%
% Members:
%   base - position of the sensor base bin in LBCB coordinates
%   plat - position of the sensor platform bin in LBCB coordinates
%   perturbations - The amount of displacement applied to a difference
%   calculation.
%   jacobian - matrix which transforms calculated sensor length differences
%   based on the perturbation applied.
%
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef ElasticDeformationCalculations < handle
    properties
        base = [];
        plat = [];
        initialLengths = [];
        currentLengths = [];
        jacobian = [];
        calcPlatCtr = [];
        MeasPltCtr = [];
        perturbations = [];
    end
    methods
        function me = ElasticDeformationCalculations(cfg,isLbcb2)
            config = ConfigExternalSensors(cfg);
            if isLbcb2
                me.base = config.Lbcb2.Base;
                me.plat = config.Lbcb2.Plat;
            else
                me.base = config.Lbcb1.Base;
                me.plat = config.Lbcb1.Plat;
            end
            me.perturbations = [config.Params.pertDx, config.Params.pertDz, config.Params.pertRy ];
        end
        function lbcbRout = calculate(me, lbcbRin)
            lbcbRout = LbcbReading;
            lbcbRout.ed.force = lbcbRin.lbcb.force;
            %  Ken's work goes here
        end
    end
end