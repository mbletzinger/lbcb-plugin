function offsets = loadOffsets(me,suffix)
names = {};
switch suffix
    case 'LBCB1'
        names = me.offstcfg.lbcbNames(1:6);
    case 'LBCB2'
        names = me.offstcfg.lbcbNames(1:6);
    case 'ExternalSensors'
        offsets = [];
        return;
end
offsets = zeros(length(names),1);
for d = 1:length(names)
    offsets(d) = me.offstcfg.getOffset(names(d));
end
end
