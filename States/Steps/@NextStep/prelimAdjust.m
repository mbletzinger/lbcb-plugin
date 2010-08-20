function prelimAdjust(me)
    me.pa.ddPrelimAdjust();
%     me.dat.correctionTarget = me.dat.nextStepData;
    me.pa.edPrelimAdjust(me.dat.curStepData, me.dat.nextStepData);
end
