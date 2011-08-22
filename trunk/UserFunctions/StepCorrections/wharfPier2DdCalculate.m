% generate a new LbcbStep based on the current step
function wharfPier2DdCalculate(me,cstep)
my = cstep.lbcbCps{1}.response.force(5);
fx = cstep.lbcbCps{1}.response.force(1);
fz = cstep.lbcbCps{1}.response.force(3);
dx = cstep.lbcbCps{1}.response.disp(1);
if cstep.isInitialPosition
    me.putDat('initialPosition',cstep.lbcbCps{1}.response.disp(1));
end
pierHeight = me.getCfg('PierHeight');
infPFactor = me.getCfg('InfPFactor');
ip = me.getDat('initialPosition');
P_Delta = fz * (dx - ip);
Shear_L = fx * pierHeight;
MomentY = -my;

myBottom = MomentY + Shear_L + P_Delta;
Inflec_Point = infPFactor-myBottom/fx;
me.putArch('MyBottom',myBottom);
me.putArch('MomentY', MomentY);
me.putArch('InflecPoint',Inflec_Point);
me.putArch('PDelta', P_Delta);
me.putArch('ShearL', Shear_L);

end


