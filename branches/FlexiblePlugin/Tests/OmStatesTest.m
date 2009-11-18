cfg = Configuration;

s = SetupTest();
s.cfg = cfg;
s.genOmConfig();
s.genNetworkConfig();
hfact = HandleFactory([],cfg);
s.hfact = hfact;
s.setTest('UPPER');
NetworkConfig('cfg',s.cfg);
step = s.infile.steps{2};
mdlLbcb = hfact.mdlLbcb;
hfact.dat.nextStepData = step;
ocOm = hfact.ocOm;
peOm = hfact.peOm;
gpcOm = hfact.gcpOm;

