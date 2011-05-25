classdef Step < States
    properties
        cdp = [];
        gui = [];
        dat = [];
        sdf = [];
        corrections
    end
    methods
        function me = Step()
            me = me@States();
        end
        
    end
end