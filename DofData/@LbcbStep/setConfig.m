function setConfig(cfg)
global names;
global sensitivities;
global applied;
global address;
ocfg = OmConfigDao(cfg);
names = ocfg.sensorNames;
sensitivities = ocfg.sensitivities;
applied = ocfg.apply2Lbcb;
ncfg = NetworkConfigDao(cfg);
address = ncfg.address;
end
