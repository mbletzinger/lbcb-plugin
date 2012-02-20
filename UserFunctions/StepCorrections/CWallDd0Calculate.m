function CWallDd0Calculate(me,step)
msr = me.getCfg('MomentShearRatio');
is = me.getCfg('InitialShear');
im = me.getCfg('InitialMoment');
pmy = (step.lbcbCps{1}.response.force(1) - is)* msr - im;
me.putArch('ProposedMy',pmy);
mmy = step.lbcbCps{1}.response.force(5) - im;
me.putArch('MeasuredMy',(step.lbcbCps{1}.response.force(5) - im));
me.log.debug(dbstack, sprintf('Dd0 proposed my = %f, measured my = %f',pmy,mmy));
me.log.debug(dbstack, sprintf('Dd0 fx = %f',step.lbcbCps{1}.response.force(1) - is));
me.log.debug(dbstack, sprintf('Dd0 init fx = %f, int my = %f',is,im));
end