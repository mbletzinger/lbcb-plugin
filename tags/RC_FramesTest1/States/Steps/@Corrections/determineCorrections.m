function determineCorrections(me,ctarget,step)
scfg = StepCorrectionConfigDao(me.cdp.cfg);
doCorrections = scfg.doCorrections;

if isempty(doCorrections)
    me.ncorrections = false(5,1);
    return;
end

me.ncorrections = false(length(doCorrections),1);

if me.canBeCorrected(step) == false
    return;
end
funcs = scfg.needsCorrectionFunctions;

for lv = 1:length(doCorrections)
    if doCorrections(lv) == true;
        switch lv
            case 1
                need = 0;
                for lbcb = 1:me.cdp.numLbcbs()
                    ed = me.ed{lbcb};
                    if strcmp(funcs{1},'Dx Only')
                        ed = me.dxed{lbcb};
                    end
                    
                    n = ed.needsCorrection(step.lbcbCps{lbcb}.response,...
                        ctarget.lbcbCps{lbcb}.command);
                    need = need + n;
                end
                edCorrect = need > 0;
                me.ncorrections(lv) = edCorrect;
            case { 2 3 4 5 }
                ddCorrect = me.dd{lv-1}.needsCorrection();
                me.ncorrections(lv) = ddCorrect;
        end
    end
end
me.ed{1}.saveData(step);
end