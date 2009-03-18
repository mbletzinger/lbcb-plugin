function me = query(me)

msg = queryOM(me,'LBCB1');

[disp forces] = parseLbcbMsg(me,msg);
me.Raw.Lbcb1.Disp = disp;
me.Raw.Lbcb1.Forc = forces;

msg = queryOM(me,'LBCB2');

[disp forces] = parseLbcbMsg(me,msg);
me.Raw.Lbcb2.Disp = disp;
me.Raw.Lbcb2.Forc = forces;

msg = queryOM(me,'ExternalTransducers');

values = parseExternalTransducersMsg(me,msg);
me.Raw.ExtTrans = values;
