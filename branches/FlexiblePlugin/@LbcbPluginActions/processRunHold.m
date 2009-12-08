function processRunHold(me,on)
if on
    me.hfact.gui.colorRunButton('ON');
    me.startSimulation()
    start(me.simTimer);
else
    me.hfact.gui.colorRunButton('OFF');
    stop(me.simTimer);
end
end