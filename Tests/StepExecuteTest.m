HandleTest
s = SetupLimitTest(hfact);
s.setTest('UPPER');
lcfg = LogLevelsDao(s.cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
NetworkConfig('cfg',s.cfg);
mdlLbcb = hfact.mdlLbcb;
cnEx = hfact.cnEx;
stpEx = hfact.stpEx;
tgtEx = hfact.tgtEx;
inF = hfact.inF;

