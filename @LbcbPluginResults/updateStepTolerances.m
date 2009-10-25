function updateStepTolerances(me,st)
within1 = st{1}.within;
within2 = st{2}.within;
diffs1 = st{1}.diffs;
diffs2 = st{2}.diffs;

for f = 1:12
    t1 = [];
    t2 = [];
    if isempty(me.toleranceCurrentValueHandles1)
        me.log.info(dbstack,sprintf('LBCB 1 %s diff %f',...
            me.dofLabel{f},diffs1(f)));
        me.log.info(dbstack,sprintf('LBCB 2 %s diff %f',...
            me.dofLabel{f},diffs2(f)));
    else
        t1 = me.commandTolerancesHandles1{f};
        t2 = me.commandTolerancesHandles2{f};
        set(me.toleranceCurrentValueHandles1{f},'String',sprintf('%f',diffs1(f)));
        set(me.toleranceCurrentValueHandles2{f},'String',sprintf('%f',diffs2(f)));
    end
    me.colorToleranceText(t1,within1(f),1,f);
    me.colorToleranceText(t2,within2(f),0,f);
end
end