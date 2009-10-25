HandleTest
s = SetupTest(hfact);
s.setTest('RAMP');
lcfg = LogLevelsDao(s.cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
mdlLbcb = hfact.mdlLbcb;
stpEx = hfact.stpEx;
stpEx.start(s.infile)
done = 0;
while done ==0
    done = stpEx.isDone;
end