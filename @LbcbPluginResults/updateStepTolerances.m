function updateStepTolerances(me,st)
within1 = st{1}.within;
within2 = st{1}.within2;
diffs1 = st{2}.diffs1;
diffs2 = st{2}.diffs2;

for f = 1:12
    if isempty(me.toleranceCurrentValueHandles1{f})
        me.log.info(dbstack,sprintf('LBCB 1 %s diff %f',...
            me.dofLabel{f},diffs1(f)));
        me.log.info(dbstack,sprintf('LBCB 2 %s diff %f',...
            me.dofLabel{f},diffs2(f)));
        continue;
    end
    set(me.toleranceCurrentValueHandles1{f},'String',sprintf('%f',diffs1(f)));
    set(me.toleranceCurrentValueHandles2{f},'String',sprintf('%f',diffs2(f)));
    LbcbPluginActions.colorToleranceText(me.commandTolerancesHandles1{f},within1(f));
    LbcbPluginActions.colorToleranceText(me.commandTolerancesHandles2{f},within2(f));
end
end