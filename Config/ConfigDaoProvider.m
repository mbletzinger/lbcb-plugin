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
            tcfg = TargetConfigDao(me.cfg);
            num = tcfg.numControlPoints;
            if tcfg.empty
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
        function num = getNumExtSensors(me)
            ocfg = OmConfigDao(me.cfg);
            num = ocfg.numExtSensors;
        end
        function [n s a] = getFilteredExtSensors(me,isLbcb1)
            il = 1;
            [rn rs ra] = me.getExtSensors();
            ns = me.getNumExtSensors();
            an = cell(ns,1);
            as = ones(ns,1);
            aa = cell(ns,1);
            for i = 1:ns
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
        function yes = forceAcceptStep(me)
            scfg = StepTimingConfigDao(me.cfg);
            as = scfg.acceptStep;
            if isempty(as)
                yes = false;
                return;
            end
            yes = as(1) > 0;
        end
        function inc = getSubstepInc(me,isLbcb1)
            scfg = StepTimingConfigDao(me.cfg);
            if isLbcb1
                inc = scfg.substepIncL1;
            else
                inc = scfg.substepIncL2;
            end
        end
        function cmd = getTriggerCommand(me,step)
            scfg = StepTimingConfigDao(me.cfg);
            ces =  scfg.triggerEveryStep;
            cmd = 'subtrigger';
            if step.stepNum.isLastSubstep
                if rem(step.stepNum.step,ces) == 0
                    cmd = 'trigger';
                end
            end
        end
        function [ cdofl1 cdofl2 ] = getControlDofs(me)
            cdofs = ControlDofConfigDao(me.cfg);
            cdofl1 = cdofs.cDofL1;
            cdofl2 = cdofs.cDofL2;
        end
    end
end