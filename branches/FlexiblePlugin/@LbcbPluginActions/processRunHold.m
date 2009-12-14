function processRunHold(me,on)
if on
    me.hfact.gui.colorRunButton('ON');
    if me.currentExecute.isState('READY')
        me.startSimulation()
    end
    me.hfact.tgtEx.statusReady();
    start(me.simTimer);
else
    me.hfact.gui.colorRunButton('OFF');
    stop(me.simTimer);
end
end