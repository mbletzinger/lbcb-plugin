function  calculate(me,prevStep, curStep,initialPosition,correctionTarget)
%calculate elastic deformations
ccfg = StepCorrectionConfigDao(me.cdp.cfg);
doC = ccfg.doCalculations;
funcs = ccfg.calculationFunctions;

if  doC(1)
    prdisp =[];
    for l = 1: me.cdp.numLbcbs()
        if isempty(prevStep) == false
            pcps = prevStep.lbcbCps{l};
        end
        ccps = curStep.lbcbCps{l};
        if isempty(correctionTarget)
            ctcps = curStep.lbcbCps{l};
        else
            ctcps = correctionTarget.lbcbCps{l};
        end
        stp = curStep.stepNum;
        if strcmp(funcs(1),'Test')
            me.ed{l}.loadConfig;
            rsp = me.ed{l}.calculateTest(ctcps.command.disp,stp);
        elseif strcmp(funcs{1},'Dx Only')
            me.dxed{l}.loadConfig;
            if isempty(pcps) == false
                prdisp = pcps.response.disp;
            end
            rsp = me.dxed{l}.calculate(prdisp,...
                ccps.externalSensors);
        else
            me.ed{l}.loadConfig;
            rsp = me.ed{l}.calculate(prdisp,...
                ccps.externalSensors);
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