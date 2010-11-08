function needsCorrection = needsCorrection(me)
needsCorrection = false;
me.edCorrect = false;
me.ddlevel = 0;
if isempty(me.dat.curStepData)
    return;
end
if me.dat.curStepData.needsCorrection == false
    return;
end
scfg = StepCorrectionConfigDao(me.cdp.cfg);
doCorrections = scfg.doCorrections;
if isempty(doCorrections)
    return;
end
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
                me.edCorrect = (n1 + n2) > 0;
                needsCorrection = me.edCorrect;
            case { 2 3 4 5 }
                ddCorrect = me.dd{lv-1}.needsCorrection();
                if ddCorrect
                    me.ddlevel = lv-1;
                    needsCorrection = ddCorrect;
                    return;
                end
                needsCorrection = me.edCorrect;
                if lv == 2 && me.edCorrect % Only do first level DD with ED
                    return;
                end
        end
    end
end
