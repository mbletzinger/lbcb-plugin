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
        jmsg = generateOmProposeMsg(me)
        jmsg = generateSimCorResponseMsg(me)
        parseOmControlPointMsg(me,rsp)
        parseSimCorControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
        transformCommand(me)
        transformResponse(me)
        [ disp dDofs force fDofs] = cmdData(me)
        [ disp force ] = respData(me)
    end
end