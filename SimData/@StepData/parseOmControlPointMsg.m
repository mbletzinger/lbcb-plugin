function good = parseOmControlPointMsg(me,rsp)
[address contents] = rsp.getContents();
good = 1;
if isempty(address)
    good = 0;
    return;
end
switch char(address.getSuffix())
    case 'LBCB1'
        lbcbR = me.lbcbCps{1}.response.clone();
        offsets = me.loadOffsets('LBCB1');
        lbcbR.parse(contents, offsets);
        me.lbcbCps{1}.response = lbcbR;
    case 'LBCB2'
        lbcbR = me.lbcbCps{1}.response.clone();
        offsets = me.loadOffsets('LBCB2');
        lbcbR.parse(contents, offsets);
        me.lbcbCps{2}.response = lbcbR;
    case 'ExternalSensors'
        [n se a ] = me.cdp.getExtSensors();
        mcontents = char(contents);
        % temp fix Java library needs to strip leading tabs
        readings = me.parseExternalSensorsMsg(n,mcontents(2:end));
        me.distributeExtSensorData(readings);
end
end
