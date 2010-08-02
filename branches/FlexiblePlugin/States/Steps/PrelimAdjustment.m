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
        function edPrelimAdjust(me,curStep,nextStep)
            me.prelimAdjust(curStep,nextStep,1);
        end
        function ddPrelimAdjust(me,curStep,nextStep)
            me.prelimAdjust(curStep,nextStep,2);
        end
    end
    methods (Access=private)
        function prelimAdjust(me,curStep, nextStep,idx)
            me.loadCfg();
            scfg = StepCorrectionConfigDao(me.cdp.cfg);
            func = scfg.prelimAdjustTargetFunctions;
            if strcmp(func{idx},'<NONE>')
                return;
            end
            pAdjust = str2func(func{idx});
            pAdjust(me,curStep, nextStep);
        end
    end
end