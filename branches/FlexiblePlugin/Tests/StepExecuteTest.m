cfg = Configuration;

s = SetupTest();
s.cfg = cfg;
s.genOmConfig();
s.genNetworkConfig();
s.genLogConfig()
hfact = HandleFactory([],cfg);
s.hfact = hfact;
s.setTest('RAMP');
mdlLbcb = hfact.mdlLbcb;
stpEx = hfact.stpEx;
stpEx.start(s.infile)
done = 0;
while done ==0
    done = stpEx.isDone;
end