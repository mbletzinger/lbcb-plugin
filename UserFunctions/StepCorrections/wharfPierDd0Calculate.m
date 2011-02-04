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
myBottom = my + fx * 84 + fz * (dx - ip);
me.putArch('MyBottom',myBottom);
end
