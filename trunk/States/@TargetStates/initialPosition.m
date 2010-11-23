function initialPosition(me)
if me.stpEx.isDone() == false
    return;
end
me.dat.curStepTgt = me.dat.curStepData;
[ disp force ] = me.dat.curStepData.respData();
me.dat.curStepTgt.lbcbCps{1}.command.disp = disp(1:6);
me.dat.curStepTgt.lbcbCps{1}.command.force = force(1:6);
if me.cdp.numLbcbs == 2
    me.dat.curStepTgt.lbcbCps{2}.command.disp = disp(7:12);
    me.dat.curStepTgt.lbcbCps{2}.command.force = force(7:12);
end
me.currentAction.setState('WAIT FOR TARGET');
if me.targetSource.isState('UI SIMCOR')
    me.tgtRsp.start();
end
    
end
