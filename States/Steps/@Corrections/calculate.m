function  calculate(me,prevStep, curStep,initialPosition,correctionTarget)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
ocfg = OmConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
funcs = ccfg.calculationFunctions;
icors = { ocfg.initialCorrectionL1 ocfg.initialCorrectionL2 };

if  doC(1)
    for l = 1: me.cdp.numLbcbs()
        pcps = prevStep.lbcbCps{l};
        ccps = curStep.lbcbCps{l};
        icps = initialPosition.lbcbCps{l};
        if isempty(correctionTarget)
            ctcps = curStep.lbcbCps{l};
        else
            ctcps = correctionTarget.lbcbCps{l};
        end
        stp = curStep.stepNum;
        if strcmp(funcs(1),'Test')
            rsp = me.ed{l}.calculateTest(ctcps.command.disp,stp);
        else
            me.ed{l}.loadConfig;
            rsp = me.ed{l}.calculate(pcps.response.disp,...
                ccps.externalSensors,icps.externalSensors);
        end
        % initial offset added back in
%        rsp = rsp + icps.command.disp - icors{l}.disp;
        ccps.response.ed.disp = rsp;
    end
end
for d = 1:4
    if doC(1 + d)
        me.dd{d}.calculate(curStep);
    end
end
me.ed{1}.saveData(curStep);
end