classdef allExternalTransducers
    properties
        names = {}; %config
        numSensors = 0;
        raw = [];
        currentLengths = [];
        initialLengths = []; 
        sensitivities = []; %config
    end
    methods
        function me = allExternalTransducers(names)
            me.names = names;
            n = length(names);
            me.numSensors = n;
            me.raw = zeros(n,1);
            me.average = zeros(n,1);
            me.initialLengths = zeros(n,1);
        end
        function update(me, raw)
            me.raw = raw;
            me.currentLengths = raw * me.sensitivities;
        end
        function init(me,raw)
            me.update(raw);
            me.initialLengths = me.currentLengths();
        end
    end
end