function distributeExtSensorData(me,readings)
[n se a] = me.cdp.getExtSensors();
me.externalSensorsRaw = readings;
el1 = zeros(length(se));
el1l = 1;
el2 = zeros(length(se));
el2l = 1;
for s = 1:length(se)
    r = readings(s) * se(s);
    if strcmp(a{s},'LBCB1')
        el1(el1l) = r;
        el1l = el1l + 1;
    else
        el2(el2l) = r;
        el2l = el2l + 1;
    end
end
me.lbcbCps{1}.externalSensors = el1(1:el1l - 1);
if length(me.lbcbCps) > 1
    me.lbcbCps{2}.externalSensors = el2(1:el2l - 1);
end
end