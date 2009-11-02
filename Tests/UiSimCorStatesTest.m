HandleTest
s = SetupTest(hfact);
s.setTest('UPPER');
lcfg = LogLevelsDao(s.cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
NetworkConfig('cfg',s.cfg);
step = s.infile.steps{2};
mdlLbcb = hfact.mdlLbcb;
hfact.dat.curTarget = step;
ocSimCor = hfact.ocSimCor;
tgtRsp = hfact.tgtRsp;

