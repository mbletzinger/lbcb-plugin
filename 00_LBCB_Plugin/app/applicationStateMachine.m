classdef  applicationStateMachine < handle
    properties
        state = stateEnum({'STOPPED','RUNNING','PAUSED'});
        loadHistorySource = stateEnum({'InputFile','SimCor'});
        useElasticDeformation = 0;
        startTime = 0;
    end
    methods
    end
end