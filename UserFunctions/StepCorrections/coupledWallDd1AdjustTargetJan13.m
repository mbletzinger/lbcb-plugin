function coupledWallDd1AdjustTargetJan13(me,step,tcps)

ddx = me.getArch('ddx');    % Load dx increment

% Adjust OM dx command displacements by ddx
dx1Target = step.lbcbCps{1}.command.disp(1) - ddx;
dx2Target = step.lbcbCps{2}.command.disp(1) + ddx;
step.lbcbCps{1}.command.setDispDof(1,dx1Target);
step.lbcbCps{2}.command.setDispDof(1,dx2Target);

% Update target displacements
tcps.lbcbCps{1}.command.disp(1) = tcps.lbcbCps{1}.command.disp(1) - ddx;
tcps.lbcbCps{2}.command.disp(1) = tcps.lbcbCps{2}.command.disp(1) + ddx;

end