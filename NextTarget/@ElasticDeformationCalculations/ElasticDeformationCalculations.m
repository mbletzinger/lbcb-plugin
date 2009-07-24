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
        previousLengths = [];
        currentLengths = [];
        jacobian = [];
        calcPlatCtr = [];
        MeasPltCtr = [];
        perturbations = [];
        potTol = [];
    end
    methods
        function me = ElasticDeformationCalculations(cfg,isLbcb1)
            config = ConfigExternalSensors(cfg);
            if isLbcb1
                me.base = config.Lbcb1.Base;
                me.plat = config.Lbcb1.Plat;
%                 me.previousLengths = some math from base and plat
%                 me.potTol = configs.Lbcb1.potTol;

            else
                me.base = config.Lbcb2.Base;
                me.plat = config.Lbcb2.Plat;
%                 me.previousLengths = some math from base and plat
%                 me.potTol = configs.Lbcb2.potTol;
            end
            % Change to vector config.Params.pert
            me.perturbations = [config.Params.pertDx, config.Params.pertDz, config.Params.pertRy ];
        end
        
        % calculate LBCB position based on external sensor readings.
        calculate(me, curLbcbCP,prevLbcbCP)
        lengths = dof2act(me,deltas,v0,p0,q0)
        end
    end
end