function [n s a] = getExtSensors(me)
ocfg = OmConfigDao(me.cfg);
names = ocfg.sensorNames;
sensitivities = ocfg.sensitivities;
applied = ocfg.apply2Lbcb;
n = names;
s = sensitivities;
a = applied;
end
