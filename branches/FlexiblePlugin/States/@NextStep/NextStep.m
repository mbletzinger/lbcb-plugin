% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%  steps - InputFile instance
%  curStep - The current LbcbStep
%  nextStep - The next LbcbStep as calculated by this class
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef NextStep < States
    properties
        steps = [];
        stepsCompleted = 0;
        st = [];
        log = Logger('NextStep');
        
    end
    methods
        function me = NextStep()
            me = me@States();
        end
        function start(me)
            me.stepsCompleted = false;
        end
        done = isDone(me)
    end
    methods (Access='private')
        needsCorrection = needsCorrection(me)
        edAdjust(me)
        prelimAdjust(me)
        derivedDofAdjust(me)
    end
end