classdef SimulationState < handle
    properties
        step = {};
        errors = '';
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        log = Logger;
    end
    methods (Static)
        function ml = getMdlLbcb()
            global mdlLbcb;
            ml = mdlLbcb;
        end
        function setMdlLbcb(mlIn)
            global mdlLbcb;
            mdlLbcb = mlIn;
        end
    end
    
end