
loops = {'INCREMENT' 'UPPER' 'LOWER' 'STEP'};
%for l = 1:length(loops)
for l = 1:1
    cfg = Configuration;
    s = SetupTest();
    s.cfg = cfg;
    s.genOmConfig();
    s.genNetworkConfig();
    s.genLogConfig()
    hfact = HandleFactory([],cfg);
    s.hfact = hfact;
    hfact.arch.setArchiveOn(true);
    s.setTest(loops{l});
    tgtEx = hfact.tgtEx;
    tgtEx.inF = s.infile;
    prcsTgt = hfact.prcsTgt;
    prcsTgt.autoAccept = true;
    done = 0;
    tgtEx.targetSource.setState('INPUT FILE');
    LbcbPlugin('hfact',s.hfact,'notimer',0);
    delete(s);
end;
