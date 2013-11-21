function offsets = loadOffsets(suffix)
names = {};
switch suffix
    case 'LBCB1'
        names = offstcfg.lbcbNames(1:6);
    case 'LBCB2'
        names = offstcfg.lbcbNames(1:6);
    case 'ExternalSensors'
        return [];
end
offsets = zeros(length(names));
for d = 1:length(names)
    offsets(d) = offstcfg.getOffset(name);
end
end
