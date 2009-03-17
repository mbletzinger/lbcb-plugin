function testProtocol()
clear classes
mdl = MDL_LBCB();
mdl.IP = 'localhost';
mdl.Port = 6342;
mdl.Comm_obj = tcpip(mdl.IP,mdl.Port);            % create TCPIP obj(objInd)ect
set(mdl.Comm_obj,'InputBufferSize', 1024*100);                    % set buffer size
open(mdl);


% Initialize Elastic Deformation Calculations
mdl.ElastDef.Lbcb1 = ResetElastDefState(mdl.ElastDef.Lbcb1,...
    mdl.ExtTrans.Config.Lbcb1.NumSensors)
mdl.ElastDef.Lbcb2 = ResetElastDefState(mdl.ElastDef.Lbcb2,...
    mdl.ExtTrans.Config.Lbcb2.NumSensors)
query_mean(mdl,1);
close(mdl);