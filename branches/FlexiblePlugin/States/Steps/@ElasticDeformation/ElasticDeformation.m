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
classdef ElasticDeformation < Corrections
    properties
        base = [];
        plat = [];
        perturbations = [];
        potTol = [];
        activeDofs = [];
        st = [];
        log = Logger('ElasticDeformation');
        isLbcb1 = 0;
    end
    methods
        function me = ElasticDeformation(cdp,isLbcb1)
            me = me@Corrections(cdp);
            me.isLbcb1 = isLbcb1;
        end
        adjustTarget(me,curLbcbCp)
        % calculate LBCB position based on external sensor readings.
        calculate(me, curLbcbCp,prevLbcbCp)
    end
end