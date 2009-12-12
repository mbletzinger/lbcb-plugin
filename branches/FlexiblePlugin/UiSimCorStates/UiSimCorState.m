classdef UiSimCorState < handle
    properties
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        mdlUiSimCor = [];
        cdp = [];
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
    end
end