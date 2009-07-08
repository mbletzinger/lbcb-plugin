function updateStepTolerances(me)
within1 = me.st.within1;
within2 = me.st.within2;
diffs1 = me.st.diffs1;
diffs2 = me.st.diffs2;

for f = 1:12
    set(me.toleranceCurrentValueHandles1{f},'String',sprintf('%f',diffs1(f)));
    set(me.toleranceCurrentValueHandles2{f},'String',sprintf('%f',diffs2(f)));
    LbcbPluginActions.colorToleranceText(me.commandTolerancesHandles1{f},within1(f));
    LbcbPluginActions.colorToleranceText(me.commandTolerancesHandles2{f},within2(f));
end
end