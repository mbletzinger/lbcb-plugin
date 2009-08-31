function [n s a] = getExtSensors()
cfg = SimulationState.getCfg();
ocfg = OmConfigDao(cfg);
names = ocfg.sensorNames;
sensitivities = ocfg.sensitivities;
applied = ocfg.apply2Lbcb;
n = names;
s = sensitivities;
a = applied;
end
