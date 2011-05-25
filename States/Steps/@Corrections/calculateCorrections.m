function calculateCorrections(me)
scfg = StepCorrectionConfigDao(me.cdp.cfg);
doCorrections = scfg.doCorrections;

if isempty(doCorrections)
    return;
end

me.checkedStepNumber = me.dat.curStepData.stepNum;
me.neededCorrections = false(length(doCorrections),1);
for lv = 1:length(doCorrections)
    if doCorrections(lv) == true;
        switch lv
            case 1
                n1 = me.ed{1}.needsCorrection(me.dat.curStepData.lbcbCps{1},...
                    me.dat.correctionTarget.lbcbCps{1});
                n2 = 0;
                if me.cdp.numLbcbs() == 2
                    n2 = me.ed{2}.needsCorrection(me.dat.curStepData.lbcbCps{2},...
                        me.dat.correctionTarget.lbcbCps{2});
                end
                edCorrect = (n1 + n2) > 0;
                me.needsCorrections(lv) = edCorrect;
            case { 2 3 4 5 }
                ddCorrect = me.dd{lv-1}.needsCorrection();
                if ddCorrect
                    me.ddlevel = lv-1;
                    return;
                end
                me.needsCorrections(lv) = ddCorrect;
        end
    end
end
