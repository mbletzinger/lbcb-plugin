function needsCorrectionDD0 = testDd0NeedsCorrection(me)
if me.existsDat('started')== false
    me.putDat('started',1)
    me.putDat('idx',1)
end
    idx = me.getDat('idx')
    if idx >= 4
        needsCorrectionDD0 = false
        me.putDat('idx',1)
        return
    end
    idx = idx + 1
    me.putDat('idx',idx)
    needsCorrectionDD0 = true
end
