JavaTest
s = SetupLimitTest;
for d = 1:4
    s.setDirection(0);
    LbcbPlugin('cfg',s.cfg,'infile',s.infile,'notimer',1);
%    s.setCommandLimitDof(d,1);
%    LbcbPlugin('cfg',s.cfg,'infile',s.infile);
end