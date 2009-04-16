classdef lbcbExternalTransducerGeometry < handle
    properties
        base = []; %config
        plat = []; %config
        lbcb2SpecimanXfrm = eye(3); %config
        motionCenter2SpecimanOffset = [0 0 0 0 0 0]'; %config
        motionCenterXfrm = eye(3); %config
        motionCenter2LbcbOffset = [0 0 0]'; %config
        sensorBounds = zeros(1,2); %config
        numSensors = 0;
    end
    methods
        function setSensorBounds(me, bounds)
            me.sensorBounds = bounds;
            me.numSensors = bounds(2)- bounds(1) + 1;
        end
        function values = sensorValuesSubset(svalues)
            values = svalues(me.sensorBounds(1),me.sensorBounds(2));
        end
    end
end