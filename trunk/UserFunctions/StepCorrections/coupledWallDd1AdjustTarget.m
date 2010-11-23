function coupledWallDd1AdjustTarget(me,step)

command_xL = step.lbcbCps{1}.command.disp(1);
command_xR = step.lbcbCps{2}.command.disp(1);

ddx = me.getArch('ddx');

command_xL = command_xL - ddx;
command_xR = command_xR + ddx;

step.lbcbCps{1}.command.setDispDof(1,command_xL);
step.lbcbCps{2}.command.setDispDof(1,command_xR);

end