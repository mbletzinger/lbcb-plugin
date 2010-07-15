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
for lv = 1:length(doCorrections)
    if doCorrections{lv} == true;
        switch lv
            case 1
                n1 = me.ed{1}.needsCorrection(me.dat.correctionTarget.lbcbCps{1}.command,...
                    me.dat.curStepData.lbcbCps{1}.response);
                n2 = 0;
                if me.cdp.numLbcbs() == 2
                    n2 = me.ed{2}.needsCorrection(me.dat.correctionTarget.lbcbCps{2}.command,...
                        me.dat.curStepData.lbcbCps{2}.response);
                end
                me.correctEd = n1 || n2;
            case { 2 3 4 5 }
                needsCorrection = me.dd{lv-1}.needsCorrection(me.dat.curStepData);
                if needsCorrection
                    me.ddlevel = lv-1;
                    return;
                end
                if lv == 2 && me.correctEd % Only do first level DD with ED
                    return;
                end
        end
    end
end
