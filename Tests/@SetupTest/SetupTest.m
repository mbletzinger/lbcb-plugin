classdef SetupTest < handle
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
            'RAMP',...
            });
    end
    methods
        function me = SetupTest(hfact)
            me.cfg = hfact.cfg;
            me.hfact = hfact;
            me.infile = me.hfact.inF;
            lcfg = LogLevelsDao(me.cfg);
            lcfg.cmdLevel = 'DEBUG';
            lcfg.msgLevel = 'INFO';
        end
        setTest(me,test)
        m = getMultiplier(me, d)
        genFakeParameters(me,needsConverge)
        genStepConfigSettings(me)
        genTargets(me,isUpper,needsIncrement)
        genLimitTargets(me, idx, isUpper,numSteps)
        genIncrementTargets(me, idx,numSteps)
        genRampTargets(me, halfSteps)
        setLimits(me,d,test)
        clearAll(me)
    end
end