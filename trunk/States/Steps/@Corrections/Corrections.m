classdef Corrections < handle
    properties
        ed
        dd
        pa
        correctStepNum
        needCorrections
        cdp
    end
    methods
        function me = Corrections(cdp)
            me.cdp = cdp;
            me.needCorrections = false(5,1);
        end
        function nc = needsCorrections(me,step)
            nc = canBeCorrected(step);
            if nc
                nc = sum(me.needsCorrections) > 0;
            end
        end
        adjustTarget(me, step)
        canBeCorrected(me,step)
        determineCorrections(me,ctarget,step)
        prelimAdjust(me,curStep, nextStep)
    end
end