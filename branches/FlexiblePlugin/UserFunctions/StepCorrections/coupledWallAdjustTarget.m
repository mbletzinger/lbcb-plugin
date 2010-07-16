% generate a new LbcbStep based on the current step
function coupledWallAdjustTarget(me,step)
Fz1tar = me.getDat('Fz1tar');
Fz2tar = me.getDat('Fz2tar');
step.lbcbCps{1}.command.setForceDof(3,Fz1tar);
step.lbcbCps{2}.command.setForceDof(3,Fz2tar);
end
