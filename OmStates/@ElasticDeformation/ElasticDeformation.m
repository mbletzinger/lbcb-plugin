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
classdef ElasticDeformation < handle
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
        activeDofs = [];
        correctionDeltas = zeros(6,1);
        cdp = [];
        log = Logger;
        isLbcb1 = 0;
    end
    methods
        function me = ElasticDeformation(cdp,isLbcb1)
            me.cdp = cdp;
            me.isLbcb1 = isLbcb1;
        end
        function deltaDiff(me,curLbcbCp)
            me.correctionDeltas = curLbcbCp.command.disp - curLbcbCp.response.disp;
        end
        function adjustTarget(me,curLbcbCp)
            curLbcbCp.command.disp = curLbcbCp.command.disp + me.correctionDeltas;
            curLbcbCp.correctionDeltas = me.correctionDeltas;
            curLbcbCp.command.clearNonControlDofs();
        end
        % calculate LBCB position based on external sensor readings.
        calculate(me, curLbcbCp,prevLbcbCp)
        loadConfig(me)
    end
end