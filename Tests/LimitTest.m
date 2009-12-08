
loops = {'INCREMENT' 'UPPER' 'LOWER' 'STEP'};
for l = 1:length(loops)
    cfg = Configuration;
    s = SetupTest();
    s.cfg = cfg;
    s.genOmConfig();
    s.genNetworkConfig();
    s.genLogConfig()
    hfact = HandleFactory([],cfg);
    s.hfact = hfact;
    s.setTest(loops{l});
    LbcbPlugin('hfact',s.hfact,'notimer',0);
    delete(s);
end;
