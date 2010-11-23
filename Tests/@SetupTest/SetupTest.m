classdef SetupTest < handle
    properties
        cfg = [];
        hfact = {}
        infile = {};
        
        % The following define the limit settings used by the test
        % programs.  These are expressed in DOF neutral units.  The
        % getMultiplier function is used to 'size' the limit to the correct
        % range for a DOF type.
        maxV = 5.0;  % maximum limit
        minV = -2.0; % minimum limit 
        maxW = 0.005; % step tolerance window size
        tgts = [];
        cDofs = [];
        log = Logger('SetupTest');;
        test = StateEnum({...
            'UPPER',...
            'LOWER',...
            'INCREMENT',...
            'STEP',...
            'RAMP',...
            });
    end
    methods
        setTest(me,test)
        m = getMultiplier(me, d)
        genFakeParameters(me,idx,needsConverge)
        genOmConfig(me)
        genLogConfig(me)
        genNetworkConfig(me)
        genStepConfigSettings(me,requireCorrection, doStepSplitting)
        genTargets(me,isUpper,needsIncrement)
        genLimitTargets(me, idx, isUpper,numSteps)
        genIncrementTargets(me, idx,numSteps)
        genRampTargets(me, idx, halfSteps)
        setLimits(me,d,test)
        clearAll(me)
    end
end