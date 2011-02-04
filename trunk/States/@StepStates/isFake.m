function yes = isFake(me)
ocfg = OmConfigDao(me.cdp.cfg);
yes = ocfg.useFakeOm;
end
