function parseControlPointMsg(me,rsp)
[address contents] = rsp.getContent();
switch char(address,getSuffix())
    case 'LBCB1'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,rsp,me.lbcb,command(1).node);
        me.lbcb{1}.response = lbcbR;
    case 'LBCB2'
        lbcbR = LbcbReading;
        lbcbR.parse(contents,rsp,me.lbcb.command(1).node);
        me.lbcb{2}.response = lbcbR;
    case 'ExternalSensors'
        [n se a ] = LbcbStep.getExtSensors();
        readings = ParseExternalTransducersMsg(n,contents);
        me.distributeExtSensorData(readings);
end
end
