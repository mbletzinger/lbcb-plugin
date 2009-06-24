function setExtSensors(cfg)
global names;
global sensitivities;
global applied;
ocfg = OmConfigDao(cfg);
names = ocfg.sensorNames;
sensitivities = ocfg.sensitivities;
applied = ocfg.apply2Lbcb;
end
