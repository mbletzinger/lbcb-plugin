function genTargets(me,test)
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
        me.genRampTargets(numSteps / 2);
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',test));
end
me.infile.commandDofs = me.cDofs;
me.infile.loadSteps(me.tgts);
end
