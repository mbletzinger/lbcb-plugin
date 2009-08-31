function num = numLbcbs()
cfg = SimulationState.getCfg();
ocfg = OmConfigDao(cfg);
num = ocfg.numLbcbs;
end