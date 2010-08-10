function update(me)
target = me.dat.curStepData;
me.log.debug(dbstack, sprintf('Displaying %s',target.toString()));
me.dataTable.update(target);
me.MyVsDxL1.update(target);
me.RyVsDxL1.update(target);
me.FxVsDxL1.update(target);
me.DxStepL1.update();
me.RyStepL1.update();
me.DzStepL1.update();
me.FzStepL1.update();
if me.cdp.numLbcbs() > 1
    me.totalFxVsLbcbDxL1.update(target);
    me.totalFxVsLbcbDxL2.update(target);
    me.totalMyVsLbcbDxL1.update(target);
    me.totalMyVsLbcbDxL2.update(target);
    me.MyVsDxL2.update(target);
    me.RyVsDxL2.update(target);
    me.DxStepL2.update();
    me.RyStepL2.update();
    me.DzStepL2.update();
    me.FzStepL2.update();
end
end
