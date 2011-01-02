function processArchiveOnOff(me,on)
if strcmp(on,'on')
    me.hfact.arch.setArchiveOn(true);
else
    me.hfact.arch.setArchiveOn(false);
end
end