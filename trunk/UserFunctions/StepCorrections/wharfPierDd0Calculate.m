% generate a new LbcbStep based on the current step
function wharfPierDd0Calculate(me,cstep)
my = cstep.lbcbCps{1}.response.force(5);
fx = cstep.lbcbCps{1}.response.force(1);
fz = cstep.lbcbCps{1}.response.force(3);
dx = cstep.lbcbCps{1}.response.disp(1);
if cstep.isInitialPosition
    me.putDat('initialPosition',cstep.lbcbCps{1}.response.disp(1));
end

ip = me.getDat('initialPosition');
P_Delta = fz * (dx - ip);
Shear_L = fx * 84;
MomentY = -my;

myBottom = MomentY + Shear_L + P_Delta;
Inflec_Point = 12-myBottom/fx;
me.putArch('MyBottom',myBottom);
me.putArch('MomentY', MomentY);
me.putArch('InflecPoint',Inflec_Point);
me.putArch('PDelta', P_Delta);
me.putArch('ShearL', Shear_L);

end


