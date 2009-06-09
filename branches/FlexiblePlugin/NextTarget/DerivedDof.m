% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef DerivedDof < handle
    properties
    end
    methods
        % generate a new LbcbStep based on the current step
        function nstep = newStep(cstep)
            % asking for trouble
            targets = {cstep.lbcb{1}.command, cstep.lbcb{2}.command };
            nstep = LbcbStep(cstep.simstep.nextStep(1),targets);            
        end
    end
end