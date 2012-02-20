classdef Corrections < handle
    properties
        ed
        dxed
        dd
        pa
        correctStepNum
        ncorrections
        cdp
        ddlevel
    end
    methods
        function me = Corrections(cdp)
            me.cdp = cdp;
            me.ncorrections = false(5,1);
        end
        function nc = needsCorrection(me)
                nc = sum(me.ncorrections) > 0;
        end
        function st = stepType(me)
            % 0 = step
            % 1 = substep
            % 2 = ed correction
            % 3 4 5 = dd corrections
            st = 0;
            for c = 1:length(me.ncorrections)
                if me.ncorrections(c)
                    st = c + 1;
                end
            end
        end
        adjustTarget(me, ctarget, curStep,nextStep)
        canBeCorrected = canBeCorrected(me,step)
        determineCorrections(me,ctarget,step)
        prelimAdjust(me,curStep, nextStep)
        calculate(me,prevStep, curStep, initialPosition, correctionTarget)
    end
end