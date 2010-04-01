function shutdown(me)
me.processRunHold(false)
me.processConnectOm(false);
me.processConnectSimCor(false);
me.processTriggering(false);
cnt = 0;
someOn = false;
while someOn
    isOn = get(me.simTimer,'Running');
    if strcmp(isOn,'on')
        someOn = true;
        link = 'Simulation';
    end
    isOn = get(me.comTimer,'Running');
    if strcmp(isOn,'on')
        someOn = true;
        link = 'OM Link';
    end
    isOn = get(me.csimcorTimer,'Running');
    if strcmp(isOn,'on')
        someOn = true;
        link = 'UI-SimCor Link';
    end
    isOn = get(me.ctriggerTimer,'Running');
    if strcmp(isOn,'on')
        someOn = true;
        link = 'Trigger Server';
    end
    if rem(cnt,100) == 0
        me.log.debug(dbstack, sprintf('Waiting for %s to shut down',link));
    end
end