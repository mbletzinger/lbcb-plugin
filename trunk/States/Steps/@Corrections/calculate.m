function  calculate(me, curStep,initialPosition)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
funcs = ccfg.calculationFunctions;
if  doC(1)
    for l = 1: me.cdp.numLbcbs()
        ccps = curStep.lbcbCps{l};
        icps = initialPosition.lbcbCps{l};
        stp = curStep.stepNum;
        if strcmp(funcs(1),'Test')
            rsp = me.ed{l}.calculateTest(ccps.command.disp,stp);
        else
            rsp = me.ed{l}.calculate(ccps.response.disp,...
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