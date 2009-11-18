cfg = Configuration;

hfact = HandleFactory([],cfg);
s = SetupTest(hfact);
s.setTest('RAMP');
% FakeOmProperties('cfg',hfact.cfg);
lcfg = LogLevelsDao(hfact.cfg);
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