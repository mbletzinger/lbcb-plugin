function needsCorrectionDD1 = coupledWallDd1NeedsCorrectionJan13(me)
needsCorrectionDD1 = false;

dFTol = me.getCfg('dFTol');
dFError = me.getArch('dFError');

if abs(dFError) > dFTol
    needsCorrectionDD1 = true;
end
end
