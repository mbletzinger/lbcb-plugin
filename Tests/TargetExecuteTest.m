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
tgtEx = hfact.tgtEx;
tgtEx.inF = s.infile;
done = 0;
tgtEx.targetSource.setState('INPUT FILE');
tgtEx.start;

while done ==0
    done = tgtEx.isDone;
end