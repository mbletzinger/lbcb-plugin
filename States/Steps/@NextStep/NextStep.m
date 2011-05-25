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
        checkedStepNumber
        neededCorrections
    end
    methods
        function me = NextStep()
            me = me@Step();
            me.neededCorrections = false(10); % guessing how many levels are configured
        end
        function start(me,shouldBeCorrected)
            me.stepsCompleted = false;
            me.ddlevel = 1;
            me.shouldBeCorrected = shouldBeCorrected;
        end
        done = isDone(me)
        needsCorrection = needsCorrection(me,shouldBeCorrected)
    end
    methods (Access='private')
        adjustTarget(me,target,tcps)
        prelimAdjust(me,target)
    end
end