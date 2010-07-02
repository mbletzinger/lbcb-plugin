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
mdlBroadcast = hfact.mdlBroadcast;
hfact.dat.curStepData = step;
ssBrdcst = hfact.ssBrdcst;
brdcstRsp = hfact.brdcstRsp;

