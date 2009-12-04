classdef SimStates < handle
    properties
        gui = [];
        cdp = [];
        ocOm = [];
        log = Logger;
        dat = [];
        nxtStep = [];
        state = StateEnum({...
            'BUSY',...
            'COMPLETED',...
            'ERRORS EXIST'...
            });
        
    end
    methods
    end
end