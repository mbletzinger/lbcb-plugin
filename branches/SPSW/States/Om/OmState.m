classdef OmState < States
    properties
        mdlLbcb = [];
        cdp = [];
        gui = [];
        dat = [];
    end
    methods
        function me = OmState()
            me = me@States();
        end
        
    end
end