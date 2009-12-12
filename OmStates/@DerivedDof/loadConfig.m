function loadConfig(me)
ddcfg = DerivedDofDao(me.cdp.cfg);
me.kfactor = ddcfg.kfactor;
me.Fztarget = ddcfg.Fztarget;
end