function CWallDd0Calculate(me,step)
msr = me.getCfg('MomentShearRatio');
fx = step.lbcbCps{1}.response.force(1);
pmy = (step.lbcbCps{1}.response.force(1))* msr;
me.putArch('ProposedMy',pmy);
mmy = step.lbcbCps{1}.response.force(5);
mm2s = mmy / fx;
myBot = mmy + 12 * fx;
me.putArch('MeasuredMy',mmy);
me.putArch('MyBot',myBot);
me.putArch('MeasuredMoment2Shear',mm2s);
str = sprintf('Dd0 proposed my = %f, measured my = %f\n',pmy,mmy);
str = sprintf('%sfx = %f\n',str,step.lbcbCps{1}.response.force(1));
str = sprintf('%sproposed m2s = %f, measured m2s = %f\n',str,msr,mm2s);
me.log.debug(dbstack,str);
end