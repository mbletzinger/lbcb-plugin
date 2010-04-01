function processVamping(me,on)
if on
    me.vampTimer = timer('Period',0.05, 'TasksToExecute',1000000,'ExecutionMode','fixedSpacing','Name','SimulationTimer');
    me.vampTimer.TimerFcn = { 'LbcbPluginActions.executeSim', me };
    me.hfact.gui.colorButton('VAMPING','ON');
else
    me.hfact.gui.colorButton('VAMPING','OFF');
    stop(me.vamTimer);
end
me.hfact.gui.colorVampingButton(on);
end