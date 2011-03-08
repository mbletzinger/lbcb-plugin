classdef UiSimCorState < States
    properties
        mdlUiSimCor = [];
        cdp = [];
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
        function me = UiSimCorState()
            me = me@States();
        end
    end
end