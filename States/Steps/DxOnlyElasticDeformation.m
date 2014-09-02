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
classdef DxOnlyElasticDeformation < ElasticDeformation
    methods
        function me = DxOnlyElasticDeformation(cdp,isLbcb1)
            me = me@ElasticDeformation(cdp, isLbcb1);
        end
        function curResponse = calculate(me, prevResponse,curReadings)
            if me.isLbcb1
                disp = curReadings - me.initialReadings;
                avgdisp = mean(disp);
                me.putArch('EdDz', avgdisp);
            else
                avgdisp = me.getArch('EdDz');
            end
            
            dof = 1;
            if me.existsCfg('EdSingleDof')
                dof = me.getCfg('EdSingleDof');
            end
            curResponse = prevResponse;
            curResponse(dof) = avgdisp;
        end
    end
end