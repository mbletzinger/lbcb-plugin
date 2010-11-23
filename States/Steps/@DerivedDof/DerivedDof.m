% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef DerivedDof < Corrections
    properties
        level
        log
    end
    methods
        function me = DerivedDof(cdp,level)
            me = me@Corrections(cdp);
            me.level = level;
            me.log = Logger(sprintf('DerivedDof L%d',me.level));
        end
        calculate(me,cstep)
        adjustTarget(me,step,tcps)
        yes = needsCorrection(me,step)
    end
end