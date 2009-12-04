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
        function num = numModelCps(me)
            ocfg = TargetConfigDao(me.cfg);
            num = ocfg.numControlPoints;
        end
        function [n s a] = getExtSensors(me)
            ocfg = OmConfigDao(me.cfg);
            names = ocfg.sensorNames;
            sensitivities = ocfg.sensitivities;
            applied = ocfg.apply2Lbcb;
            lgth = 1;
            while isempty(applied{lgth}) == 0
                lgth = lgth + 1;
            end
            lgth = lgth - 1;
            n = names(1:lgth);
            s = sensitivities(1:lgth);
            a = applied(1:lgth);
        end
        function [n s a] = getFilteredExtSensors(me,isLbcb1)
            il = 1;
            [rn rs ra] = me.getExtSensors();
            an = cell(length(ra),1);
            as = ones(length(ra),1);
            aa = cell(length(ra),1);
            for i = 1:length(ra)
                if strcmp(ra{i},'LBCB1')
                    if isLbcb1
                        an(il) = rn(i);
                        as(il) = rs(i);
                        aa(il) = ra(i);
                        il = il + 1;
                    end
                else
                    if isLbcb1 == 0
                        an(il) = rn(i);
                        as(il) = rs(i);
                        aa(il) = ra(i);
                        il = il + 1;
                    end
                end
            end
            n = an(1:il - 1);
            s = as(1:il - 1);
            a = aa(1:il - 1);
        end
        function yes = useEd(me)
            scfg = StepConfigDao(me.cfg);
            yes = scfg.doEdCalculations;
        end
        function yes = doStepSplitting(me)
            scfg = StepConfigDao(me.cfg);
            yes = scfg.doStepSplitting; 
        end
        function inc = getSubstepInc(me,isLbcb1)
            scfg = StepConfigDao(me.cfg);
            if isLbcb1
                inc = scfg.substepIncL1;
            else
                inc = scfg.substepIncL2;
            end
        end

    end
end