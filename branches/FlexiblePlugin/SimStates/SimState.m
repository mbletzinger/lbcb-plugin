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
    methods
        function a = getAddress(me)
            ncfg = NetworkConfigDao(me.cfg);
            address = ncfg.address;
            a = address;
        end
        function num = numLbcbs(me)
            ocfg = OmConfigDao(me.cfg);
            num = ocfg.numLbcbs;
        end
    end
end