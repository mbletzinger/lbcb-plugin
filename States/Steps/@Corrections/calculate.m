function  calculate(me,prevStep, curStep,initialPosition,correctionTarget)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
funcs = ccfg.calculationFunctions;
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
            me.ed{1}.loadConfig;
            rsp = me.ed{l}.calculate(pcps.response.disp,...
                ccps.externalSensors,icps.externalSensors);
        end
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