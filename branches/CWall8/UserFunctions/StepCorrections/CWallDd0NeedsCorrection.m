function yes = CWallDd0NeedsCorrection(me)
er = me.getCfg('MyError')
pmy = me.getArch('ProposedMy')
mmy = me.getArch('MeasuredMy')
yesy = abs(mmy - pmy) > er


yesx = 0
yesz = 0
smx = true
if me.existsCfg('setMx')
    spmx = me.getCfg('setMx')
    smx = spmx == 1
end
if smx
    er = me.getCfg('MxError')
    pmx = me.getCfg('MxTarget')
    mmx = me.getArch('MeasuredMx')
    yesx = abs(mmx - pmx) > er
end
smz = true;
if me.existsCfg('setMz')
    spmz = me.getCfg('setMz')
    smz = spmz == 1
end
if smz
    er = me.getCfg('MzError')
    pmz = me.getCfg('MzTarget')
    mmz = me.getArch('MeasuredMz')
    yesz = abs(mmz - pmz) > er
end

me.putArch('DoMx',yesx)
me.putArch('DoMz',yesz)

yes = (yesy + yesx + yesz) > 0
end