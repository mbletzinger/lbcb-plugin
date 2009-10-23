JavaTest
cfg = Configuration;
cfg.load;
loops = {'INCREMENT' 'UPPER' 'LOWER' 'STEP'};
for l = 1:length(loops)
    s = SetupLimitTest(cfg);
    s.setTest(loops{l});
    LbcbPlugin('hfact',s.hfact,'notimer',0);
    delete(s);
end;
