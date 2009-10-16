classdef SimState < handle
    properties
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        log = Logger;
        mdlLbcb = [];
        cfg = [];
        dd = [];
        ed = cell(2,1);
        gui = [];
        dat = [];
    end
end