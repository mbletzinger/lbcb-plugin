function CWallDd0Calculate(me,step)
msr = me.getCfg('MomentShearRatio')
fx = step.lbcbCps{1}.response.force(1)
mz = step.lbcbCps{1}.response.force(6)
mzshear = fx * 25.7 + mz

mmy = step.lbcbCps{1}.response.force(5)
mm2s = mmy / fx
myBot = mmy - 144 * fx

fz = step.lbcbCps{1}.response.force(3)
mx = step.lbcbCps{1}.response.force(4)
x_eccentricity = mx / fz

shearcenter = mz/ fx

cmy = (step.lbcbCps{1}.response.force(1))* msr
correction = cmy - mmy

if me.existsCfg('MyCorrectionFactor')
    cf = me.getCfg('MyCorrectionFactor')
else
    cf = 1
end

pmy = mmy + correction * cf
me.putArch('ProposedMy',pmy)

me.putArch('MeasuredMy',mmy)
me.putArch('MyBot',myBot)
me.putArch('MeasuredMoment2Shear',mm2s)
me.putArch('MzAtShearCenter',mzshear)
me.putArch('ShearCenter',shearcenter)
me.putArch('XEccentricity',x_eccentricity)

mmx = step.lbcbCps{1}.response.force(4)
me.putArch('MeasuredMx',mmx)

mmz = step.lbcbCps{1}.response.force(6)
me.putArch('MeasuredMz',mmz)
me.putArch('DoMx',0)
me.putArch('DoMz',0)

str = sprintf('Dd0 calculated My = %f, measured My = %f, proposed My = %f\n',cmy,mmy,pmy)
str = sprintf('%sfx = %f\n',str,step.lbcbCps{1}.response.force(1))
str = sprintf('%sproposed m2s = %f, measured m2s = %f\n',str,msr,mm2s)
str = sprintf('%smz at shear center= %f\n',str,mzshear)
me.log.debug(dbstack,str)
end