function distributeExtSensorData(me,readings,se)
me.externalSensorsRaw = readings;
el1 = zeros(length(readings));
el1l = 1;
el2 = zeros(length(readings));
el2l = 1;
for s = 1:length(readings)
    r = readings(s) * se(s);
    if strcmp(a(s),'LBCB1')
        el1(el1l) = r;
    else
        el2(el2l) = r;
    end
end
me.lbcb{1}.externalSensors = el1(1:el1l - 1);
me.lbcb{2}.externalSensors = el2(1:el2l - 1);
end