classdef SetupLimitTest < handle
    properties
        cfg = {}
        infile = {}
        maxV = 5.0
        minV = -2.0
        tgts = [];
        cDofs = [];
        log = Logger;
    end
    methods
        function me = SetupLimitTest()
            me.cfg = Configuration;
            me.infile = InputFile;
            Logger.setCmdLevel('DEBUG');

        end
        function setDirection(me,isUpper)
            for idx = 1:4
                d = 3*(idx - 1) + 1;
                for i = d: d+ 2
                    me.setLimits(i);
                end
            end
            me.genFakeParameters(1);
            me.genInputFile(isUpper);
            lcfg = LogLevelsDao(me.cfg);
            lcfg.cmdLevel = 'DEBUG';
            ocfg = OmConfigDao(me.cfg);
            ocfg.useFakeOm = 1;
            sensorNames = cell(15,1);
            apply2Lbcb = cell(15,1);
            sensorNames(1:6,1) = {'Ext 1' 'Ext 2' 'Ext 3', 'Ext 4', 'Long Ext 5' 'Short Ext 6'}';
            apply2Lbcb(1:6,1) = {'LBCB1' 'LBCB1' 'LBCB1' 'LBCB2' 'LBCB2' 'LBCB2'}';
            ocfg.sensorNames = sensorNames;
            ocfg.apply2Lbcb = apply2Lbcb;
            ocfg.numLbcbs = '2';
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
            for d = 1:6
                s = me.getMultiplier(1);
                fcfg.eDerived{d} = derived.getState();
                fcfg.eScale(d) = s / m;
            end
        end
        function genInputFile(me,isUpper)
            numSteps = 100;
            me.tgts = zeros(numSteps,24);
            me.cDofs = zeros(1,24);
            for idx = 1:4
                me.genInputDof(idx,isUpper,numSteps);
            end
            me.infile.commandDofs = me.cDofs;
            me.infile.loadSteps(me.tgts);
        end
        function genInputDof(me, idx, isUpper,numSteps)
            d = 3*(idx - 1) + 1;
            m = me.getMultiplier(d);
            min = me.minV *m;
            max = me.maxV *m;
            itv = (max - min) / numSteps;
            if isUpper
                start = min + itv;
                inc = itv;
            else
                start = max - itv;
                inc = -itv;
            end
            me.log.debug(dbstack,sprintf('d=%d start=%f inc=%f',d,start,inc)); 
            for i = d: d + 2
                me.cDofs(1,i) = 1;
                me.cDofs(1,i+12) = 1;
                for s = 1:numSteps
                    me.tgts(s,i) = start + s * inc;
                    me.tgts(s,i+12) = start + s * inc;
                end
            end
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