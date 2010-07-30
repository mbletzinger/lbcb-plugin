% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef PrelimAdjustment < Corrections
    properties
        log
    end
    methods
        function me = PrelimAdjustment(cdp)
            me = me@Corrections(cdp);
            me.log = Logger('PrelimAdjustment');
        end
        function prelimAdjust(me,curStep, nextStep)
            me.loadCfg();
            scfg = StepCorrectionConfigDao(me.cdp.cfg);
            func = scfg.prelimAdjustTargetFunction;
            if strcmp(func,'<NONE>')
                return;
            end
            pAdjust = str2func(func);
            pAdjust(me,curStep, nextStep);
        end
    end
end