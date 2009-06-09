% =====================================================================================================================
% Class containing the step count of the simulation.
%
% Members:
%   step - Step number.
%   subStep - Substep number.
%   id - internal step count
%   idCounter = static count of how many steps have been created
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef SimulationSteps < handle
    properties
        step = 0;
        subStep = 0;
    end
    methods
        function me = SimulationState(step, subStep)
            me.step = step;
            me.subStep = subStep;
            me.id = newId();
        end
        % increment the step or substep and return in a new instance
        function simstate = nextStep(me,useSubStep)
            stp = me.step;
            sStp = me.substep;
            if(useSubStep)
                sStp = sStp+ 1;
            else
                stp = stp + 1;
            end
            simstate = SimulationState(stp,sStp);
        end
    end
    methods (Static, Access = private)
        function id = newId()
            persistent idCounter;
            idCounter = idCounter + 1;
            id = idCounter;
        end
    end
end