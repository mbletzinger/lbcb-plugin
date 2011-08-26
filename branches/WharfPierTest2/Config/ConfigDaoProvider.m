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
            if ocfg.empty
                num = 0;
            end
        end
        function addr = getAddresses(me)
            ocfg = TargetConfigDao(me.cfg);
            addr = ocfg.addresses;
        end
        function [n s a] = getExtSensors(me)
            ocfg = OmConfigDao(me.cfg);
            n = ocfg.sensorNames;
            s = ocfg.sensitivities;
            a = ocfg.apply2Lbcb;
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
            scfg = StepCorrectionConfigDao(me.cfg);
            dos = scfg.doCalculations;
            if isempty(dos)
                yes = false;
                return;
            end
            yes = dos(1) > 0;
        end
        function yes = useDd(me, level)
            scfg = StepCorrectionConfigDao(me.cfg);
            dos = scfg.doCalculations;
            if isempty(dos)
                yes = false;
                return;
            end
            yes = dos(level + 1) > 0;
        end
        function yes = doStepSplitting(me)
            scfg = StepTimingConfigDao(me.cfg);
            dos = scfg.doStepSplitting;
            if isempty(dos)
                yes = false;
                return;
            end
            yes = dos(1) > 0;
        end
        function inc = getSubstepInc(me,isLbcb1)
            scfg = StepTimingConfigDao(me.cfg);
            if isLbcb1
                inc = scfg.substepIncL1;
            else
                inc = scfg.substepIncL2;
            end
        end        
    end
end