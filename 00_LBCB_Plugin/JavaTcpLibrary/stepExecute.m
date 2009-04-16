classdef stepExecute < handle
    properties
        factory = {};
    end
    methods
        function me = stepExecute(simState)
            me.factory = commandMsgFactory(simState);
        end
        function status = execute(displacements,forces)
        end
    end
end