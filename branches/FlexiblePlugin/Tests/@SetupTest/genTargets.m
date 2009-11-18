function genTargets(me,test)
me.infile = me.hfact.inF;
numSteps = 10;
me.tgts = zeros(numSteps,24);
me.cDofs = zeros(1,24);
switch test
    case { 'UPPER' 'LOWER' 'STEP' }
        for idx = 1:4
            me.genLimitTargets(idx,1,numSteps);
        end
    case 'INCREMENT'
        for idx = 1:4
            me.genIncrementTargets(idx,numSteps);
        end
    case 'RAMP'
        for idx = 1:4
            me.genRampTargets(idx,numSteps / 2);
        end
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',test));
end
me.infile.commandDofs = me.cDofs;
me.infile.loadSteps(me.tgts);
end
