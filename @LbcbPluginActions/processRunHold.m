function processRunHold(me,on)
if on
    me.hfact.gui.colorRunButton('ON');
    if me.currentSimExecute.isState('DONE')
        me.startSimulation()
    end
    me.hfact.tgtEx.statusReady();
    isOn = get(me.simTimer,'Running');
    if strcmp(isOn,'off')
        start(me.simTimer);
    end
else
    me.hfact.gui.colorRunButton('OFF');
    stop(me.simTimer);
end
end