JavaTest
s = SetupLimitTest;
s.setDirection(0);
s.cfg.load;
NetworkConfig('cfg',s.cfg);
LbcbStep.setConfig(s.cfg);
stp = s.infile.steps{2};
SimulationState.setMdlLbcb(MdlLbcb(s.cfg));
mlbcb = SimulationState.getMdlLbcb();
opc = OpenClose;
pe = ProposeExecuteOm;
pe.step = stp;
gpc = GetControlPointsOm;
gpc.step = stp;

