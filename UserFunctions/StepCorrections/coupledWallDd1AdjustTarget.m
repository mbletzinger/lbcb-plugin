function coupledWallDd1AdjustTarget(me,step,tcps)
ddx = me.getArch('ddx');    % Load dx increment

% Adjust OM dx command displacements by ddx
dx1Target = step.lbcbCps{1}.command.disp(1) - ddx;
dx2Target = step.lbcbCps{2}.command.disp(1) + ddx;
step.lbcbCps{1}.command.setDispDof(1,dx1Target);
step.lbcbCps{2}.command.setDispDof(1,dx2Target);

% Adjust OM ry command displacements through dx2ry
dx2ryBase = me.getCfg('dx2ryBase');
dx2ryRedRate = me.getCfg('dx2ryRedRate');
maxDisp = me.getArch('maxDisp');
dx2ry = dx2ryRedRate*maxDisp + dx2ryBase;

ry1Target = step.lbcbCps{1}.command.disp(5) - ddx*dx2ry;
ry2Target = step.lbcbCps{2}.command.disp(5) + ddx*dx2ry;
step.lbcbCps{1}.command.setDispDof(5,ry1Target);
step.lbcbCps{2}.command.setDispDof(5,ry2Target);

% Update target displacements
tcps.lbcbCps{1}.command.disp(1) = tcps.lbcbCps{1}.command.disp(1) - ddx;
tcps.lbcbCps{2}.command.disp(1) = tcps.lbcbCps{2}.command.disp(1) + ddx;
tcps.lbcbCps{1}.command.disp(5) = tcps.lbcbCps{1}.command.disp(1)*dx2ry;
tcps.lbcbCps{2}.command.disp(5) = tcps.lbcbCps{2}.command.disp(1)*dx2ry;
me.putDat('dd1Flag',1);
end