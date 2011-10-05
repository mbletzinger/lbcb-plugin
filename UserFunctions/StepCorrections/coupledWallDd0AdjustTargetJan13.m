% generate a new LbcbStep based on the current step
function coupledWallDd0AdjustTargetJan13(me,step,tcps)
step.lbcbCps{1}.command.setForceDof(3,me.getDat('Fz1Target'));
step.lbcbCps{2}.command.setForceDof(3,me.getDat('Fz2Target'));
step.lbcbCps{1}.command.setForceDof(5,me.getDat('My1Target'));
step.lbcbCps{2}.command.setForceDof(5,me.getDat('My1Target'));
end
