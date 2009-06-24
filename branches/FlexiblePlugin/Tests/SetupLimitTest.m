classdef SetupLimitTest < handle
    properties
        cfg = Configuration
        infile = InputFile
        maxV = 5.0
        minV = -2.0
    end
    methods
        function setCommandLimitDof(me,idx, isUpper)
            d = 3*(idx - 1) + 1;
            for i = d: d+ 2
                me.setLimits(i);
            end
            me.genFakeParameters(d);
            me.genInputFile(idx,isUpper);
            lcfg = LogLevelsDao(me.cfg);
            lcfg.cmdLevel = 'DEBUG';
        end
        function m = getMultiplier(me, d)
            if d <=3
                m = 1;
                return;
            end
            if d > 3 && d <= 6
                m = .5;
                return;
            end
            if d > 6 && d <= 9
                m = 5;
                return;
            end
            m = 12;
        end
        function genFakeParameters(me,idx)
            fcfg = FakeOmDao(me.cfg);
            derived = StateEnum(fcfg.derivedOptions);
            derived.idx = idx;
            m = me.getMultiplier(idx);
            for d = 1:12
                s = me.getMultiplier(d);
                fcfg.derived1{d} = derived.getState();
                fcfg.derived2{d} = derived.getState();
                fcfg.scale1(d) = s / m;
                fcfg.scale2(d) = s / m;
            end
        end
        function genInputFile(me, idx, isUpper)
            m = me.getMultiplier(idx);
            min = me.minV *m;
            max = me.maxV *m;
            itv = 0.1 * m;
            if isUpper
                start = min + itv;
                stop= max + itv;
                inc = itv;
            else
                start = max - itv;
                stop= min - itv;
                inc = -itv;
            end
            numTgts = round(abs(stop - start) / itv);
            tgts = zeros(numTgts,24);
            cDofs = zeros(1,24);
            d = 3*(idx - 1) + 1;
            for i = d: d+ 2
                cDofs(1,i) = 1;
                cDofs(1,i+12) = 1;
                for s = 1:numTgts
                    tgts(s,i) = start + s * inc;
                end
            end
            me.infile.commandDofs = cDofs;
            me.infile.loadSteps(tgts);
        end
        function setLimits(me,d)
            lcfg = LimitsDao('command.limits',me.cfg);
            m = me.getMultiplier(d);
            lcfg.upper1(d) = me.maxV * m;
            lcfg.lower1(d) = me.minV * m;
            lcfg.used1(d) = 1;
            lcfg.upper2(d) = me.maxV * m;
            lcfg.lower2(d) = me.minV * m;
            lcfg.used2(d) = 1;
        end
        function clearAll(me)
            lcfg = LimitsDao('command.limits',me.cfg);
            lcfg.lower1 = zeros(12,1);
            lcfg.upper1 = zeros(12,1);
            lcfg.used1 = zeros(12,1);
            lcfg.lower2 = zeros(12,1);
            lcfg.upper2 = zeros(12,1);
            lcfg.used2 = zeros(12,1);
        end
    end
end