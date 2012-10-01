classdef BroadcasterState < States
    properties
        mdlBroadcast = [];
        cdp = [];
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
        function me = BroadcasterState()
            me = me@States();
        end
    end
end