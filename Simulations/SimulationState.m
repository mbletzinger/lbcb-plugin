% =====================================================================================================================
% Class containing the state of the simulation.
%
% Members:
%   step - Step number.
%   subStep - Substep number.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef SimulationState < handle
    properties
        step = 0;
        subStep = 0;
        startTime = clock;
    end
    methods
        % sets the starting step and starts the clock
        function start(me,startStep)
            me.startTime = clock;
            me.step = startStep;
        end
        % increment the step or substep
        function next(me,useSubStep)
            if(useSubStep)
                me.subStep = me.subStep + 1;
                return;
            end
                me.step = me.step + 1;
                me.subStep = 1;
        end
        % return how much time has elapsed
        function et = getElapsedTime(me)
            et = clock - me.startTime;
        end
    end
end