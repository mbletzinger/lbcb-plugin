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
crackPosition = me.getCfg('CrackPosition');
crackSlipTTerm = me.getCfg('CrackSlipTTerm');
crackSlipBTerm = me.getCfg('CrackSlipBTerm');
ip = me.getDat('initialPosition');
P_Delta = fz * (dx - ip);
Shear_L = fx * pierHeight;
MomentY = -my;
MCrack = MomentY + crackPosition * fx + fz * dx * crackSlipTTerm/crackSlipBTerm;
myBottom = MomentY + Shear_L + P_Delta;
Inflec_Point = pierHeight-myBottom/fx;
me.putArch('MyBottom',myBottom);
me.putArch('MomentY', MomentY);
me.putArch('MCrack', MCrack);
me.putArch('InflecPoint',Inflec_Point);
me.putArch('PDelta', P_Delta);
me.putArch('ShearL', Shear_L);

end


