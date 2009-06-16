classdef LbcbPluginActions < handle
    properties
        handle = [];
        commandLimitsHandles1 = {};
        commandLimitsHandles2 = {};
        commandTolerancesHandles1 = {};
        commandTolerancesHandles2 = {};
        incrementLimitsHandles1 = {};
        incrementLimitsHandles2 = {};
        
        commandCurrentValueHandles1 = {};
        commandCurrentValueHandles2 = {};
        toleranceCurrentValueHandles1 = {};
        toleranceCurrentValueHandles2 = {};
        incrementCurrentValueHandles1 = {};
        incrementCurrentValueHandles2 = {};
    end
    methods
        function me  = LbcbPlugin(handle)
            me.handle = handle;
        end
        initialize(me)
        updateCommandLimits(me)
        updateIncrementLimits(me)
        updateDofData(me)
        updateStepTolerances(me)
        shutdown(me);
    end
end