function good = parseOmGetInitialPositionMsg(me,msg)
[address contents] = msg.getContents();
good = 1;
if isempty(address)
    good = 0;
    return;
end
switch char(address.getSuffix())
    case 'LBCB1'
        lbcbR = me.lbcbCps{1}.command.clone();
        lbcbR.parse(contents);
        me.lbcbCps{1}.command = lbcbR;
    case 'LBCB2'
        lbcbR = me.lbcbCps{1}.command.clone();
        lbcbR.parse(contents);
        me.lbcbCps{2}.command = lbcbR;
end
end
