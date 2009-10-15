classdef SimState < handle
    properties
        step = {};
        errors = '';
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        log = Logger;
        mdlLbcb = [];
        sd = [];
        cfg = [];
        dd = [];
        ed = cell(2,1);
        gui = [];
    end
end