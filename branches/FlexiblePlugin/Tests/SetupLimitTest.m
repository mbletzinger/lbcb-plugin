classdef SetupLimitTest < handle
    properties
        cfg = [];
        hfact = {}
        infile = {};
        maxV = 5.0;
        minV = -2.0;
        maxW = 0.5;
        tgts = [];
        cDofs = [];
        log = Logger;
        test = StateEnum({...
            'UPPER',...
            'LOWER',...
            'INCREMENT',...
            'STEP',...
            });
    end
    methods
        function me = SetupLimitTest(hfact)
            me.hfact = hfact;
            me.cfg = hfact.cfg;
            me.infile = me.hfact.inF;
            lcfg = LogLevelsDao(me.cfg);
            lcfg.cmdLevel = 'DEBUG';
            lcfg.msgLevel = 'INFO';
            
        end
        function setTest(me,test)
            switch test
                case 'UPPER'
                    me.genInputFile(1,0);
                    me.genFakeParameters(0);
                case 'LOWER'
                    me.genInputFile(0,0);
                    me.genFakeParameters(0);
                case 'INCREMENT'
                    me.genInputFile(1,1);
                    me.genFakeParameters(0);
                case 'STEP'
                    me.genInputFile(1,0);
                    me.genFakeParameters(1);
                otherwise
                    me.log.error(dbstack, sprintf('%s not recognized',test));
            end
            me.clearAll();
            for idx = 1:4
                d = 3*(idx - 1) + 1;
                for i = d: d+ 2
                    me.setLimits(i,test);
                end
            end
            lcfg = LogLevelsDao(me.cfg);
            lcfg.cmdLevel = 'DEBUG';
            ocfg = OmConfigDao(me.cfg);
            ocfg.useFakeOm = 1;
            sensorNames = cell(15,1);
            apply2Lbcb = cell(15,1);
            sensorNames(1:6,1) = {'Ext.Long.LBCB2' 'Ext.Tranv.TopLBCB2' 'Ext.Tranv.Bot.LBCB2',...
                'Ext.Long.LBCB1', 'Ext.Tranv.LeftLBCB1' 'Ext.Tranv.RightLBCB1'}';
            apply2Lbcb(1:6,1) = {'LBCB2' 'LBCB2' 'LBCB2' 'LBCB1' 'LBCB1' 'LBCB1'}';
            ocfg.sensorNames = sensorNames;
            ocfg.apply2Lbcb = apply2Lbcb;
            ocfg.numLbcbs = 2;
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
        function genFakeParameters(me,needsConverge)
            fcfg = FakeOmDao(me.cfg);
            derived = StateEnum(fcfg.derivedOptions);
            derived.idx = 1;
            m = me.getMultiplier(10);
            % external sensors
            for d = 1:6
                s = me.getMultiplier(1);
                fcfg.eDerived{d} = derived.getState();
                fcfg.eScale(d) = s / m;
            end
            if needsConverge
                fcfg.convergeSteps = 5;
                fcfg.convergeInc = me.maxW * m;
                for d = 1:12
                    derived.idx = d;
                    fcfg.derived1{d} = derived.getState();
                    fcfg.derived2{d} = derived.getState();
                    fcfg.scale1(d) = 1;
                    fcfg.scale2(d) = 1;
                end
            else
                % regular dofs
                for d = 1:12
                    s = me.getMultiplier(d);
                    fcfg.derived1{d} = derived.getState();
                    fcfg.derived2{d} = derived.getState();
                    fcfg.scale1(d) = s / m;
                    fcfg.scale2(d) = s / m;
                end
            end
        end
        function genInputFile(me,isUpper,needsIncrement)
            numSteps = 10;
            me.tgts = zeros(numSteps,24);
            me.cDofs = zeros(1,24);
            for idx = 1:4
                if needsIncrement
                    me.genIncInputDof(idx,numSteps);
                else
                    me.genInputDof(idx,isUpper,numSteps);
                end
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
                start = min +  2 * itv;
                inc = itv;
            else
                start = max - 2 * itv;
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
        function genIncInputDof(me, idx,numSteps)
            d = 3*(idx - 1) + 1;
            m = me.getMultiplier(d);
            min = me.minV *m;
            itv = me.maxW * m / (numSteps - 2);
            start = min + itv;
            me.log.debug(dbstack,sprintf('d=%d start=%f itv=%f',d,start,itv));
            for i = d: d + 2
                me.cDofs(1,i) = 1;
                me.cDofs(1,i+12) = 1;
                dsp = start;
                frc = start;
                for s = 1:numSteps
                    me.tgts(s,i) = dsp;
                    me.tgts(s,i+12) = frc;
                    dsp = dsp + s*itv;
                    frc = frc + s*itv;
%                    dsp - me.tgts(s,i)
                end
            end
        end
        function setLimits(me,d,test)
            lcfg = LimitsDao('command.limits',me.cfg);
            m = me.getMultiplier(d);
            
            icfg = WindowLimitsDao('increment.limits',me.cfg);
            scfg = WindowLimitsDao('command.tolerances',me.cfg);            
            switch test
                case {'UPPER' 'LOWER'}
                    lcfg.upper1(d) = me.maxV * m;
                    lcfg.lower1(d) = me.minV * m;
                    lcfg.used1(d) = 1;
                    lcfg.upper2(d) = me.maxV * m;
                    lcfg.lower2(d) = me.minV * m;
                    lcfg.used2(d) = 1;
                case 'INCREMENT'
                    icfg.window1(d) = me.maxW * m;
                    icfg.used1(d) = 1;
                    icfg.window2(d) = me.maxW * m;
                    icfg.used2(d) = 1;
                case 'STEP'
                    scfg.window1(d) = me.maxW * m;
                    scfg.used1(d) = 1;
                    scfg.window2(d) = me.maxW * m;
                    scfg.used2(d) = 1;
                otherwise
                    me.log.error(dbstack, sprintf('%s not recognized',test));
            end
        end
        function clearAll(me)
            lcfg = LimitsDao('command.limits',me.cfg);
            lcfg.lower1 = zeros(12,1);
            lcfg.upper1 = zeros(12,1);
            lcfg.used1 = zeros(12,1);
            lcfg.lower2 = zeros(12,1);
            lcfg.upper2 = zeros(12,1);
            lcfg.used2 = zeros(12,1);
            icfg = WindowLimitsDao('increment.limits',me.cfg);
            icfg.window1 = zeros(12,1);
            icfg.used1 = zeros(12,1);
            icfg.window2 = zeros(12,1);
            icfg.used2 = zeros(12,1);
            scfg = WindowLimitsDao('command.tolerances',me.cfg);
            scfg.window1 = zeros(12,1);
            scfg.used1 = zeros(12,1);
            scfg.window2 = zeros(12,1);
            scfg.used2 = zeros(12,1);
        end
    end
end