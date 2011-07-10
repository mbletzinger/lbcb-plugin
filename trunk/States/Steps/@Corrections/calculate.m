function  calculate(me, curStep,initialPosition)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
if isempty(doC) || doC(1)
    for l = 1: me.cdp.numLbcbs()
        ccps = curStep.lbcbCps{l};
        icps = initialPosition.lbcbCps{l};
        rsp = me.ed{l}.calculate(ccps.response.disp,...
            ccps.externalSensors,icps.externalSensors);
        ccps.response.ed.disp = rsp;
    end
end
for d = 1:4
    if isempty(doC) || doC(1 + d) == false
        continue;
    end
    me.dd{d}.calculate(curStep);
end
me.ed{1}.saveData(curStep);
end