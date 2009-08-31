function a = getAddress()
cfg = SimulationState.getCfg();
ncfg = NetworkConfigDao(cfg);
address = ncfg.address;
a = address;
end