% generate a new LbcbStep based on the current step
function testDd0AdjustTarget(me,step,tcps)
dx = step.lbcbCps{1}.command.disp(1);
step.lbcbCps{1}.command.setDispDof(1,dx + 0.00111);
end
