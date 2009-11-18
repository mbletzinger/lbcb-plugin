function genNetworkConfig(me)
ncfg = NetworkConfigDao(me.cfg);
ncfg.omHost = '127.0.0.1';
ncfg.omPort = '6342';
ncfg.simcorPort = '6445';
ncfg.triggerPort = '6446';
ncfg.timeout = '40000';
ncfg.address = 'MDL-00-01';
end
