classdef OmState < States
    properties
        mdlLbcb = [];
        cdp = [];
        dd = [];
        ed = cell(2,1);
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
        function me = OmState()
            me = me@States();
        end
        
    end
end