% =====================================================================================================================
% Class containing the step count of the simulation.
%
% Members:
%   step - Step number.
%   subStep - Substep number.
%   id - internal step count
%   idCounter = static count of how many steps have been created
%
% $LastChangedDate: 2009-10-12 10:40:20 -0500 (Mon, 12 Oct 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef StepNumber < handle
    properties
        step = 0;
        subStep = 0;
        correctionStep = 0;
        id = 0;
        log = Logger('StepNumber');
    end
    methods
        function me = StepNumber(step, subStep, cStep)
            me.step = step;
            me.subStep = subStep;
            me.correctionStep = cStep;
            me.id = StepNumber.newId();
            %            me.log.debug(dbstack,sprintf('created step %s',me.toString()));
        end
        % increment the step or substep and return in a new instance
        function simstate = next(me,stepType)
            stp = me.step;
            sStp = me.subStep;
            cStp = me.correctionStep;
            switch stepType
                case 0
                    stp = stp + 1;
                    sStp = 0;
                    cStp = 0;
                case 1
                    sStp = sStp+ 1;
                    cStp = 0;
                case { 2 3 }
                    cStp = cStp+ 1;
                case { 4 5 }
                    cStp = cStp + 100^(stepType - 3);
                otherwise
                    me.log.error(dbstack, sprintf('%d not recognized',stepType));
            end
            simstate = StepNumber(stp,sStp,cStp);
        end
        function str = toString(me)
            str = sprintf('%d\t%d\t%d',me.step, me.subStep, me.correctionStep);
        end
        function str = toStringD(me,d)
            str = sprintf('%d%s%d%s%d',me.step, d, me.subStep,d,me.correctionStep);
        end
        function yes = isCorrectionStep(me)
            yes = me.correctionStep > 0;
        end
        function yes = isSubStep(me)
            yes = me.subStep > 0;
        end
        function yes = isStep(me)
            yes = me.isCorrectionStep() == false && me.isSubStep() == false;
        end
        
    end
    methods (Static, Access = private)
        function id = newId()
            global idCounter;
            idCounter = idCounter + 1;
            id = idCounter;
        end
    end
end