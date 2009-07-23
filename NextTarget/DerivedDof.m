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
        function nstep = newStep(me,cstep)
            % asking for trouble
            targets = {cstep.lbcbCps{1}.command, cstep.lbcbCps{2}.command };
            nstep = StepData('simstep',cstep.simstep.nextStep(1),'lbcb_tgts',targets);            
        end
    end
end