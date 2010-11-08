function needsCorrectionDD0 = needsCorrectionWallDD0(me)
needsCorrectionDD0 = false;

Mytol = me.getCfg('Mytol');
Myerr = me.getDat('Myerr');

if abs(Myerr) > Mytol
    needsCorrectionDD0 = true;
end
end
