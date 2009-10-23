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
classdef SimStep < handle
    properties
        step = 0;
        subStep = 0;
        id = 0;
        log = Logger;
    end
    methods
        function me = SimStep(step, subStep)
            me.step = step;
            me.subStep = subStep;
            me.id = SimStep.newId();
            me.log.debug(dbstack,sprintf('created /step=%d/substep=%d/id=%d',me.step,me.subStep,me.id));
        end
        % increment the step or substep and return in a new instance
        function simstate = next(me,useSubStep)
            stp = me.step;
            sStp = me.subStep;
            if(useSubStep)
                sStp = sStp+ 1;
            else
                stp = stp + 1;
                sStp = 0;
            end
            simstate = SimSteps(stp,sStp);
        end
        function str = toString(me)
            str = sprintf('%d\t%d',me.step, me.subStep);
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