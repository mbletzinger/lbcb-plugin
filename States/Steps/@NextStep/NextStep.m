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
classdef NextStep < Step
    properties
        steps = [];
        stepsCompleted = 0;
        log = Logger('NextStep');
        ddlevel
        edCorrect
        shouldBeCorrected
    end
    methods
        function me = NextStep()
            me = me@Step();
        end
        function start(me,shouldBeCorrected)
            me.stepsCompleted = false;
            me.ddlevel = 1;
            me.edCorrect = false;
            me.shouldBeCorrected = shouldBeCorrected;
        end
        done = isDone(me)
    end
    methods (Access='private')
        needsCorrection = needsCorrection(me)
        adjustTarget(me,target,tcps)
        prelimAdjust(me,target)
    end
end