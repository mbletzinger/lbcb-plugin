classdef ConfigDaoProvider < handle
    properties
        cfg = [];
    end
    methods
        function me = ConfigDaoProvider(cfg)
            me.cfg = cfg;
        end
        function a = getAddress(me)
            ncfg = NetworkConfigDao(me.cfg);
            address = ncfg.address;
            a = address;
        end
        function num = numLbcbs(me)
            ocfg = OmConfigDao(me.cfg);
            num = ocfg.numLbcbs;
        end
        function [n s a] = getExtSensors(me)
            ocfg = OmConfigDao(me.cfg);
            names = ocfg.sensorNames;
            sensitivities = ocfg.sensitivities;
            applied = ocfg.apply2Lbcb;
            n = names;
            s = sensitivities;
            a = applied;
        end
    end
end