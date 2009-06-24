classdef LbcbStep < handle
    properties
        lbcb = {}; % Number of LBCBs Instances of LbcbControlPoint 
        simstep = {}; % SimulationStep instance 
        externalSensorRaw = [];
    end
    methods
        function me = LbcbStep(simstep, targets)
            me.simstep = simstep;
            lgth = length(targets);
            me.lbcb = cell(lgth,1);
            for t = 1:lgth
                me.lbcb{t} = LbcbControlPoint;
                me.lbcb{t}.command = targets{t};
            end
        end
        jmsg = generateProposeMsg(me)
        parseControlPointMsg(me,rsp)
        distributeExtSensorData(me,readings)
    end
    methods (Static)
        ml = getMdlLbcb()
        setMdlLbcb(ml)
        [n s a] = getExtSensors()
        setExtSensors(cfg)
    end
end