classdef StepData < CorrectionVariables
    properties
        lbcbCps;
        modelCps;
        stepNum;
        externalSensorsRaw;
        cData;
        log = Logger('StepData');
        jid;
        mdlLbcb;
        mdlUiSimCor;
        cdp;
        containsModelCps;
        stepTimes; % BG
    end
    methods
        function me = StepData()
            me.lbcbCps = {}; % Instances of LbcbControlPoint
            me.modelCps = {}; % Instances of model control points
            me.stepNum = {}; % StepNumber instance
            me.externalSensorsRaw = [];
            me.cData = CorrectionData;
            me.jid = {};
            me.mdlLbcb = [];
            me.mdlUiSimCor = [];
            me.cdp = [];
            me.containsModelCps = 0;
            me.stepTimes=[];
        end
        str = toString(me)
        jmsg = generateOmProposeMsg(me)
        jmsg = generateSimCorResponseMsg(me)
        goodMsg = parseOmControlPointMsg(me,rsp)
        goodMsg = parseOmGetInitialPositionMsg(me,msg)
        goodMsg = parseSimCorControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
        transformCommand(me)
        transformResponse(me)
        [ disp dDofs force fDofs] = cmdData(me)
        [ disp force ] = respData(me)
    end
end
