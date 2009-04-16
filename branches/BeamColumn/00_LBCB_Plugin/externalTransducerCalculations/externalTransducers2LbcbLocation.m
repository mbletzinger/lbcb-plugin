classdef externalTransducers2LbcbLocation < handle
    properties
        base = [];
        plat  = [];
        lengths  = [];
        startLengths = [];
        platformCtrMeas = []; 
        jacob = [];
        lengthDiff = [];
        platformCtrCalc = [];  
        geometry = {};
    end
    methods
        function me = externalTransducers2LbcbLocation(geometry)
            me.geometry = geometry;
            numSensors = geometry.numSensors;
            me.base           = zeros(numSensors,3); % Base pin coordinates these should not move
            me.plat       = zeros(numSensors,3);     % Current platform pin coordinates
            me.lengths        = zeros(numSensors,1); % Calculated string pot lengths
            me.startLengths   = zeros(numSensors,1); % Calculated start lengths based on coordinates in
            % geometry
            me.platformCtrMeas   = zeros(numSensors,1); % Platform coordinates returned as measured displacement.
            me.jacob          = zeros(numSensors,numSensors);
            me.lengthDiff      = zeros(numSensors,1); % Differences from calculated start lengths
            me.platformCtrCalc   = zeros(numSensors,1); % Current calculated platform coordinates.
        end
        function init(me)
            cfg = me.geometry;
            for s=1:cfg.numSensors
                %Base pins with offset considered
                me.base(s,:) = cfg.base(s,:) - (cfg.lbcb2SpecimanXfrm * cfg.motionCenter2LbcbOffset)';
                %Platform pins with offset considered
                me.plat(s,:) = cfg.plat(s,:) - (cfg.lbcb2SpecimanXfrm * cfg.motionCenter2LbcbOffset)';
                %String lengths
                me.lengths(s,1) = sqrt(sum((me.base(s,:) - me.plat(s,:)).^2));
            end
            me.reset();
        end
        function reset(me)
            me.startLengths   = me.lengths;
            numSensors = me.geometry.numSensors;
            me.platformCtrMeas   = zeros(numSensors,1);
            me.jacob          = zeros(numSensors,numSensors);
            me.lengthDiff      = zeros(numSensors,1);
        end
    end
end