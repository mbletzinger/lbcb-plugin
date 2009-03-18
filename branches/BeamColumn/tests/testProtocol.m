function testProtocol()
clear classes
mdl = MDL_LBCB();
mdl.IP = 'localhost';
mdl.Port = 6342;
mdl.Comm_obj = tcpip(mdl.IP,mdl.Port);            % create TCPIP obj(objInd)ect
set(mdl.Comm_obj,'InputBufferSize', 1024*100);                    % set buffer size
open(mdl);
mdl = query(mdl);
query_lbcb1RawDisp = mdl.Raw.Lbcb1.Disp
query_lbcb1RawForc = mdl.Raw.Lbcb1.Forc
query_lbcb2RawDisp = mdl.Raw.Lbcb2.Disp
query_lbcb2RawForc = mdl.Raw.Lbcb2.Forc
query_extransRaw = mdl.Raw.ExtTrans


% Initialize Elastic Deformation Calculations
mdl.ElastDef.Lbcb1 = ResetElastDefState(mdl.ElastDef.Lbcb1,...
    mdl.ExtTrans.Config.Lbcb1.NumSensors);
mdl.ElastDef.Lbcb2 = ResetElastDefState(mdl.ElastDef.Lbcb2,...
    mdl.ExtTrans.Config.Lbcb2.NumSensors);
mdl = query_mean(mdl,1);
lbcb1RawDisp = mdl.Raw.Lbcb1.Disp
lbcb1RawForc = mdl.Raw.Lbcb1.Forc
lbcb2RawDisp = mdl.Raw.Lbcb2.Disp
lbcb2RawForc = mdl.Raw.Lbcb2.Forc
extransRaw = mdl.Raw.ExtTrans
lbcb1AvgDisp = mdl.Avg.Lbcb1.Disp
lbcb1AvgForc = mdl.Avg.Lbcb1.Forc
lbcb2AvgDisp = mdl.Avg.Lbcb2.Disp
lbcb2AvgForc = mdl.Avg.Lbcb2.Forc
extransAvg = mdl.Avg.ExtTrans
lbcb1MeasDisp = mdl.Meas.Lbcb1.Disp
lbcb1MeasForc = mdl.Meas.Lbcb1.Forc
lbcb2MeasDisp = mdl.Meas.Lbcb2.Disp
lbcb2MeasForc = mdl.Meas.Lbcb2.Forc

close(mdl);