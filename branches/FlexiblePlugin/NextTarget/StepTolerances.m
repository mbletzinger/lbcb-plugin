% =====================================================================================================================
% Class which determines if the step is within tolerances.
%
% Members:
%   lower - Lower tolerance.
%   upper - Upper tolerance.
%   used - flag array indicating which DOFs need to be checked.
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef StepTolerances < handle
    properties
        lower1 = [];
        upper1 = [];
        used1 = [];

        lower2 = [];
        upper2 = [];
        used2= [];
    end
    methods
        function yes = withinTolerances(me, currentStep)
            yes = 1;
        end
    end
end
