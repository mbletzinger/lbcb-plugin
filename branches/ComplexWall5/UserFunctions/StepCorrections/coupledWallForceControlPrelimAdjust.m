function coupledWallForceControlPrelimAdjust(me,curStep, nextStep)

if me.getCfg('PrelimForceControlFlag') == 1
    nextStep.lbcbCps{1}.command.setForceDof(3,curStep.lbcbCps{1}.response.force(3));
    nextStep.lbcbCps{2}.command.setForceDof(3,curStep.lbcbCps{2}.response.force(3));
    nextStep.lbcbCps{1}.command.setForceDof(5,curStep.lbcbCps{1}.response.force(5));
    nextStep.lbcbCps{2}.command.setForceDof(5,curStep.lbcbCps{2}.response.force(5));
end

end