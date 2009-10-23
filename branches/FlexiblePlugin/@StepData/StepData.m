classdef StepData < handle
    properties
        lbcbCps = {}; % Instances of LbcbControlPoint
        modelCps = {}; % Instances of model control points
        simstep = {}; % SimulationStep instance
        externalSensorsRaw = [];
        dData = DerivedData;
        log = Logger;
        jid = {};
        mdlLbcb = [];
        cfg = [];
        needsCorrection = 0;
    end
    methods
        str = toString(me)
        jmsg = generateProposeMsg(me)
        parseControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
        [n s a] = getExtSensors(me)
        num = numLbcbs(me)
        a = getAddress(me)
    end
end