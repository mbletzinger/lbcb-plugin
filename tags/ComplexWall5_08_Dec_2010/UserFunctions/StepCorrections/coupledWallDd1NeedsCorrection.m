function needsCorrectionDD1 = coupledWallDd1NeedsCorrection(me)
needsCorrectionDD1 = false;

dFtol = me.getCfg('dFtol');
dFerr = me.getDat('dFerr');

if abs(dFerr) > dFtol
    needsCorrectionDD1 = true;
end
end
