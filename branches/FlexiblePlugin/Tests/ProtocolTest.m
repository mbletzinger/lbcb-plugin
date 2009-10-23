HandleTest
s = SetupLimitTest(hfact);
s.setTest('UPPER');
lcfg = LogLevelsDao(s.cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
NetworkConfig('cfg',s.cfg);
stp = s.infile.steps{2};
mlbcb = hfact.mdlLbcb;
opc = hfact.ocOm;
pe = hfact.peOm;
pe.step = stp;
gpc = hfact.gcpOm;
gpc.step = stp;

