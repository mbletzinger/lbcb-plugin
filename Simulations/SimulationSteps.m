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
        time = [];
    end
    methods
        function me = SimulationState(step, subStep)
            me.step = step;
            me.subStep = subStep;
            me.id = newId();
            me.time = clock;
        end
        % increment the step or substep and return in a new instance
        function simstate = nextStep(me,useSubStep)
            step = me.step;
            subStep = me.substep;
            if(useSubStep)
                subStep = subStep+ 1;
            else
                step = step + 1;
            end
            simstate = SimulationState(step,subStep);
        end
        % return how much time has elapsed
        function et = getElapsedTime(me)
            et = me.time - getStartTime();
        end
    end
    methods (Static, Access = private)
        function id = newId()
            persistent idCounter;
            idCounter = idCounter + 1;
            id = idCounter;
        end
        % sets the start time if empty and returns it
        function startTime = getStartTime()
            persistent sTime;
            if isempty(sTime)
                sTime = clock;
            end
            startTime = sTime;
        end
    end
end