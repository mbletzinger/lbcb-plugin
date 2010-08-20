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
            me.loadCfg();
            scfg = StepCorrectionConfigDao(me.cdp.cfg);
            func = scfg.prelimAdjustTargetFunctions;
            if isempty(func)
                return;
            end
            if strcmp(func{1},'<NONE>')
                return;
            end
            pAdjust = str2func(func{1});
            pAdjust(me,curStep, nextStep);
        end
        function ddPrelimAdjust(me)
            me.loadCfg();
            scfg = StepCorrectionConfigDao(me.cdp.cfg);
            func = scfg.prelimAdjustTargetFunctions;
            if isempty(func)
                return;
            end
            if strcmp(func{2},'<NONE>')
                return;
            end
            pAdjust = str2func(func{2});
            pAdjust(me);
        end
    end
end