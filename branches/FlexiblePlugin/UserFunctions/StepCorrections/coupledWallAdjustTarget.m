% generate a new LbcbStep based on the current step
function coupledWallAdjustTarget(me,step)
step.lbcbCps{1}.command.setForceDof(3,me.Fz1tar);
step.lbcbCps{2}.command.setForceDof(3,me.Fz2tar);
end
