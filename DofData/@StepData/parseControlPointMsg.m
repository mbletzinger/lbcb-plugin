function parseControlPointMsg(me,rsp)
[address contents] = rsp.getContents();
mdl = LbcbStep.getAddress();
switch char(address.getSuffix())
    case 'LBCB1'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,mdl);
        me.lbcb{1}.response = lbcbR;
    case 'LBCB2'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,mdl);
        me.lbcb{2}.response = lbcbR;
    case 'ExternalSensors'
        [n se a ] = LbcbStep.getExtSensors();
        readings = me.parseExternalSensorsMsg(n,contents);
        me.distributeExtSensorData(readings);
end
end
