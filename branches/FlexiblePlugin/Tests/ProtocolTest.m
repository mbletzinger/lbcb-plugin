JavaTest
s = SetupLimitTest;
s.setTest('UPPER');
s.cfg.load;
lcfg = LogLevelsDao(s.cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
NetworkConfig('cfg',s.cfg);
StepData.setConfig(s.cfg);
stp = s.infile.steps{2};
SimulationState.setMdlLbcb(MdlLbcb(s.cfg));
mlbcb = SimulationState.getMdlLbcb();
opc = OpenClose;
pe = ProposeExecuteOm;
pe.step = stp;
gpc = GetControlPointsOm;
gpc.step = stp;

