JavaTest
s = SetupLimitTest;
s.setTest('STEP');
LbcbPlugin('cfg',s.cfg,'infile',s.infile,'notimer',0);
s = SetupLimitTest;
s.setTest('INCREMENT');
LbcbPlugin('cfg',s.cfg,'infile',s.infile,'notimer',0);
s = SetupLimitTest;
s.setTest('UPPER');
LbcbPlugin('cfg',s.cfg,'infile',s.infile,'notimer',0);
s = SetupLimitTest;
s.setTest('LOWER');
LbcbPlugin('cfg',s.cfg,'infile',s.infile,'notimer',0);
