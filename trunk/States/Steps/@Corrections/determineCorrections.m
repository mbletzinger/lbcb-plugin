function determineCorrections(me,ctarget,step)
scfg = StepCorrectionConfigDao(me.cdp.cfg);
doCorrections = scfg.doCorrections;

if isempty(doCorrections)
    me.ncorrections = false(5,1);
    return;
end

me.checkedStepNumber = step.stepNum;
me.ncorrections = false(length(doCorrections),1);

if me.canBeCorrected(step) == false
    return;
end

for lv = 1:length(doCorrections)
    if doCorrections(lv) == true;
        switch lv
            case 1
                n1 = me.ed{1}.needsCorrection(step.lbcbCps{1},...
                    ctarget.lbcbCps{1});
                n2 = 0;
                if me.cdp.numLbcbs() == 2
                    n2 = me.ed{2}.needsCorrection(step.lbcbCps{2},...
                        ctarget.lbcbCps{2});
                end
                edCorrect = (n1 + n2) > 0;
                me.ncorrections(lv) = edCorrect;
            case { 2 3 4 5 }
                ddCorrect = me.dd{lv-1}.needsCorrection(step);
                me.ncorrections(lv) = ddCorrect;
        end
    end
end
