function processVamping(me,on)
if on
    me.hfact.vmpChk.start(0);
else
    me.hfact.vmpChk.start(1);
end
isOn = get(me.vampTimer,'Running');
if strcmp(isOn,'off')
    start(me.vampTimer);
end
end