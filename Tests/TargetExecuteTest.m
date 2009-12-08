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
prcsTgt = hfact.prcsTgt;
prcsTgt.autoAccept = true;
done = 0;
tgtEx.targetSource.setState('INPUT FILE');
display('****Starting Target test w/o step splitting****');
tgtEx.start(1);

while done ==0
    done = tgtEx.isDone;
end
display('****Done****');
display('****Starting Target test with step splitting****');

s.setTest('SUBSTEPS');
mdlLbcb = hfact.mdlLbcb;
tgtEx = hfact.tgtEx;
s.infile.reset();
tgtEx.inF = s.infile;
prcsTgt = hfact.prcsTgt;
prcsTgt.autoAccept = true;
done = 0;
tgtEx.targetSource.setState('INPUT FILE');
tgtEx.start(1);

while done ==0
    done = tgtEx.isDone;
end
display('****Done****');
