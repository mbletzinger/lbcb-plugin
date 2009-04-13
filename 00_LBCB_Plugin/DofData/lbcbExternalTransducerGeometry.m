classdef lbcbExternalTransducerGeometry < handle
    properties
        base = [];
        plat = [];
        lbcb2MdlXfrm = eye(3);
        motionCenter2SpecimanOffset = [0 0 0 0 0 0]';
        motionCenterXfrm = eye(3);
        motionCenter2LbcbOffset = [0 0 0]';
        sensorBounds = zeroes(1,2);
        numSensors = 0;
    end
    methods
        function setSensorBounds(me, bounds)
            me.sensorBounds = bounds;
            me.numSensors = bounds(2)- bounds(1) + 1;
        end
    end
end