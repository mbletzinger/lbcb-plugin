cfg = Configuration;

s = SetupTest();
s.cfg = cfg;
s.genOmConfig();
s.genNetworkConfig();
s.genLogConfig()
hfact = HandleFactory([],cfg);
s.hfact = hfact;
s.setTest('UPPER');
NetworkConfig('cfg',s.cfg);
step = s.infile.steps{2};
mdlUiSimCor = hfact.mdlUiSimCor;
hfact.dat.curStepTgt = step;
ocSimCor = hfact.ocSimCor;
tgtRsp = hfact.tgtRsp;

