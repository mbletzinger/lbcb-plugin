classdef StepData < handle
    properties
        lbcbCps;
        modelCps;
        stepNum;
        externalSensorsRaw;
        dData;
        log = Logger('StepData');
        jid;
        mdlLbcb;
        mdlUiSimCor;
        cdp;
        needsCorrection;
    end
    methods
        function me = StepData()
            me.lbcbCps = {}; % Instances of LbcbControlPoint
            me.modelCps = {}; % Instances of model control points
            me.stepNum = {}; % StepNumber instance
            me.externalSensorsRaw = [];
            me.dData = DerivedData;
            me.jid = {};
            me.mdlLbcb = [];
            me.mdlUiSimCor = [];
            me.cdp = [];
            me.needsCorrection = 0;
        end
        str = toString(me)
        jmsg = generateOmProposeMsg(me)
        jmsg = generateSimCorResponseMsg(me)
        goodMsg = parseOmControlPointMsg(me,rsp)
        goodMsg = parseSimCorControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
        transformCommand(me)
        transformResponse(me)
        [ disp dDofs force fDofs] = cmdData(me)
        [ disp force ] = respData(me)
    end
end