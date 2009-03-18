function testProposeMsgs()
clear classes
clc
mdl = MDL_LBCB();
for i = 1:6
    mdl.SubTgt.Lbcb1 = initTgtData();
    mdl.SubTgt.Lbcb1.Disp(i) = .002;
    mdl.SubTgt.Lbcb1.Cmd(i) = 1;
    [send_str transId] = assembleProposeMsg(mdl, mdl.SubTgt.Lbcb1,'LBCB1')
end
for i = 1:6
    mdl.SubTgt.Lbcb1 = initTgtData();
    mdl.SubTgt.Lbcb1.Forc(i) = 25;
    mdl.SubTgt.Lbcb1.Cmd(i) = 2;
    [send_str transId] = assembleProposeMsg(mdl, mdl.SubTgt.Lbcb1,'LBCB1')
end

mdl.SubTgt.Lbcb1 = initTgtData();
mdl.SubTgt.Lbcb1.Disp(1) = .003;
mdl.SubTgt.Lbcb1.Cmd(1) = 1;
mdl.SubTgt.Lbcb1.Disp(4) = .003;
mdl.SubTgt.Lbcb1.Cmd(4) = 1;
mdl.SubTgt.Lbcb1.Forc(2) = 35;
mdl.SubTgt.Lbcb1.Cmd(2) = 2;
mdl.SubTgt.Lbcb1.Forc(6) = 2000;
mdl.SubTgt.Lbcb1.Cmd(6) = 2;
[send_str transId] = assembleProposeMsg(mdl, mdl.SubTgt.Lbcb1,'LBCB1')
[send_str transId] = assembleProposeMsg(mdl, mdl.SubTgt.Lbcb1,'LBCB2')

