function CWallDd0Calculate(me,step)
msr = me.getCfg('MomentShearRatio');
fx = step.lbcbCps{1}.response.force(1);
pmy = (step.lbcbCps{1}.response.force(1))* msr;
me.putArch('ProposedMy',pmy);
mmy = step.lbcbCps{1}.response.force(5);
mm2s = mmy / fx;
me.putArch('MeasuredMy',mmy);
me.putArch('MeasuredMoment2Shear',mm2s);
me.log.debug(dbstack, sprintf('Dd0 proposed my = %f, measured my = %f',pmy,mmy));
me.log.debug(dbstack, sprintf('Dd0 fx = %f',step.lbcbCps{1}.response.force(1)));
end