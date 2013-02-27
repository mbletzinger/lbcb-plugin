function processArchiveOnOff(me,on)
if strcmp(on,'on')
    me.hfact.arch.setArchiveOn(false);
    me.hfact.gui.menuCheck('ARCHIVE',false);
else
    me.hfact.arch.setArchiveOn(true);
    me.hfact.gui.menuCheck('ARCHIVE',true);
end
end