function processTriggering(me,on)
action = 'START TRIGGERING';

me.hfact.stpEx.doTriggering = on;
if on
    me.hfact.ssBrdcst.start(0);
else
    me.hfact.ssBrdcst.start(1);
    action = 'STOP TRIGGERING';
end    
me.startTriggeringAction.setState(action);
isOn = get(me.ctriggerTimer,'Running');
if strcmp(isOn,'off')
    start(me.ctriggerTimer);
end
end