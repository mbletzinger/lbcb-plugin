function processTriggering(me,on)
action = 'START TRIGGERING';

if on
    nope = me.hfact.ssBrdcst.start(0);
else
    nope = me.hfact.ssBrdcst.start(1);
    action = 'STOP TRIGGERING';
end    
if nope
    return;
end
me.startTriggeringAction.setState(action);
isOn = get(me.ctriggerTimer,'Running');
if strcmp(isOn,'off')
    start(me.ctriggerTimer);
end
end