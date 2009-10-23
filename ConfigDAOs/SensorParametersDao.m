classdef SensorParametersDao
    properties
        lbcb1SensorNames = {};
        lbcb2SensorNames = {};
    end
    methods
        function me = SensorParametersDao(cfg)
            ocfg = OmConfigDao(cfg);
            names = ocfg.sensorNames;
            flags = ocfg.apply2Lbcb;
            lgth = length(names);
            l1 = cell(lgth,1);
            l2 = cell(lgth,1);
            i1 = 1;
            i2 = 1;
            for s = 1:lgth
                if isempty(names{s})
                    break;
                end
                if strcmp(flags{s},'LBCB 1')
                    l1{i1} = names{s};
                    i1 = i1+1;
                else
                    l2{i2} = names{s};
                    i2 = i2+1;
                end
            end
            i1 = i1 - 1;
            i2 = i2 - 1;
            me.lbcb1SensorNames = cell(i1,1);
            me.lbcb1SensorNames = l1(1:i1,1);
            me.lbcb2SensorNames = cell(i2,1);
            me.lbcb2SensorNames = l1(1:i2,1);
        end
        function num = numSensors(me, isLbcb2)
            if isLbcb2
                num = length(me.lbcb2SensorNames);
            else
                num = length(me.lbcb1SensorNames);
            end
        end
    end
end