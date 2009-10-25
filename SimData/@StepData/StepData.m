classdef StepData < handle
    properties
        lbcbCps = {}; % Instances of LbcbControlPoint
        modelCps = {}; % Instances of model control points
        stepNum = {}; % StepNumber instance
        externalSensorsRaw = [];
        dData = DerivedData;
        log = Logger;
        jid = {};
        mdlLbcb = [];
        cdp = [];
        needsCorrection = 0;
    end
    methods
        str = toString(me)
        jmsg = generateProposeMsg(me)
        parseControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
    end
end