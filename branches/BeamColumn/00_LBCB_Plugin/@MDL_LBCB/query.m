function me = query(me)

msg = queryOM(me,'LBCB1');

[disp forces] = parseLbcbMsg(me,msg);
me.Lbcb1.LbcbDispReadings = disp;
me.Lbcb1.MeasForc = forces;

msg = queryOM(me,'LBCB2');

[disp forces] = parseLbcbMsg(me,msg);
me.Lbcb2.LbcbDispReadings = disp;
me.Lbcb2.MeasForc = forces;

msg = queryOM(me,'ExternalTransducers');

values = parseExternalTransducersMsg(me,msg);
me.ExtTrans.State.Meas = values;
