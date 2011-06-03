function  calculate(me, curStep, prevStep, corTarget)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
if isempty(doC) || doC(1)
    for l = 1: me.cdp.numLbcbs()
        ccps = curStep.lbcbCps{l};
        pcps = {};
        if isempty(prevStep) == false
            pcps = prevStep.lbcbCps{l};
        end
        if isempty(corTarget)
            tcps = ccps;
        else
            tcps = corTarget.lbcbCps{l};
        end
        me.ed{l}.calculate(ccps,pcps,tcps);
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