classdef Step < States
    properties
        cdp = [];
        ed = cell(2,1);
        dd = cell(4,1);
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
        function me = Step()
            me = me@States();
        end
        
    end
end