classdef OmState < handle
    properties
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        mdlLbcb = [];
        cdp = [];
        dd = [];
        ed = cell(2,1);
        gui = [];
        dat = [];
        sdf = [];
    end
    methods
    end
end