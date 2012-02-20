function yes = CWallDd0NeedsCorrection(me)
er = me.getCfg('MyError');
pmy = me.getArch('ProposedMy');
mmy = me.getArch('MeasuredMy');
yes = abs(mmy - pmy) > er;
end