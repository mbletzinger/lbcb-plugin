classdef SimStates < States
    properties
        gui = [];
        cdp = [];
        ocOm = [];
        dat = [];
        nxtStep = [];
        sdf = [];
        ddisp = [];
        
    end
    methods
        function me = SimStates()
            me = me@States();
        end
        
    end
end
