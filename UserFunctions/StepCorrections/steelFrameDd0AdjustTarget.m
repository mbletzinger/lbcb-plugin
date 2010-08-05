% generate a new LbcbStep based on the current step
function steelFrameDd0AdjustTarget(me,step)
Fz1Target = me.getDat('Fz1Target');
Fz2Target = me.getDat('Fz2Target');
step.lbcbCps{1}.command.setForceDof(3,Fz1Target);
step.lbcbCps{2}.command.setForceDof(1,Fz2Target);
end
