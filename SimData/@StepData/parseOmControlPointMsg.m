function parseOmControlPointMsg(me,rsp)
[address contents] = rsp.getContents()
mdl = me.cdp.getAddress();
switch char(address.getSuffix())
    case 'LBCB1'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,mdl);
        me.lbcbCps{1}.response = lbcbR;
    case 'LBCB2'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,mdl);
        me.lbcbCps{2}.response = lbcbR;
    case 'ExternalSensors'
        [n se a ] = me.cdp.getExtSensors();
        readings = me.parseExternalSensorsMsg(n,contents);
        me.distributeExtSensorData(readings);
end
end
