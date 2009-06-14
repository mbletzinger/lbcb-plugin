classdef LbcbPluginActions < handle
    properties
        handle = [];
    end
    methods
        function me  = LbcbPlugin(handle)
            me.handle = handle;
        end
        initialize(me)
        update(me)
        shutdown(me);
    end
end