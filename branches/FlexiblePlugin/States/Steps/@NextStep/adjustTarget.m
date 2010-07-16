function adjustTarget(me, target)
if me.edCorrect
    me.ed{1}.adjustTarget(target.lbcbCps{1});
    if me.cdp.numLbcbs() == 2
        me.ed{2}.adjustTarget(target.lbcbCps{2});
    end
end

if me.ddlevel > 0
    me.dd{me.ddlevel}.adjustTarget(target);
end
me.gui.updateCorrections((me.edCorrect || me.ddlevel),me.edCorrect,(me.ddlevel - 1))