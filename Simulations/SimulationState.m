classdef SimulationState < handle
    properties
        step = {};
        errors = '';
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
    end
    methods (Abstract)
        start(me)
        isDone(me)
    end
    methods (Static)
        function ml = getMdlLbcb(mlIn)
            persistent mdlLbcb;
            if isempty(mlIn)
                mdlLbcb = mlIn;
            end
            ml = mdlLbcb;
        end
    end
    
end