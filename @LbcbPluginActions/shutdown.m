function shutdown(me)
me.processRunHold(0)
me.processConnectOm(0);
me.processConnectSimCor(0);
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
    if rem(cnt,100) == 0
        me.log.debug(dbstack, sprintf('Waiting for %s to shut down',link));
    end
end