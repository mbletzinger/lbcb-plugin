function needsCorrectionDD1 = steelFrameDd1NeedsCorrection(me)
needsCorrectionDD1 = false;

dFTol = me.getCfg('dFTol');
dFError = me.getArch('dFError');

if abs(dFError) > dFTol
    needsCorrectionDD1 = true;
end
end
