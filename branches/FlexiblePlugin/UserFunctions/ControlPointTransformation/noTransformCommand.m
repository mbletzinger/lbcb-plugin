function noTransformCommand(me)
idx = 1;
for mdc = 1 : me.modelCps
    me.lbcbCps{idx}.command = mdc.command.clone();
    idx = idx + 1;
end
end