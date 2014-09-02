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
        containsModelCps;
        stepTimes; % BG
        offstcfg
    end
    methods
        function me = StepData(cdp)
            me = me@CorrectionVariables(cdp);
            me.lbcbCps = {}; % Instances of LbcbControlPoint
            me.modelCps = {}; % Instances of model control points
            me.stepNum = {}; % StepNumber instance
            me.externalSensorsRaw = [];
            me.cData = CorrectionData;
            me.jid = {};
            me.mdlLbcb = [];
            me.mdlUiSimCor = [];
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
        offsets = loadOffsets(me,suffix)
    end
end
