classdef allExternalTransducers
    properties
        names = {};
        numSensors = 0;
        raw = [];
        average = [];
        currentLengths = [];
        initialLengths = [];
        sensitivities = [];
    end
    methods
        function me = allExternalTransducers(names)
            me.names = names;
            n = length(names);
            me.numSensors = n
            me.raw = zeros(n,1);
            me.average = zeros(n,1);
            me.initialLengths = zeros(n,1);
        end
    end
end