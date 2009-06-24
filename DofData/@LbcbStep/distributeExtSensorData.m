function distributeExtSensorData(me,readings)
me.externalSensorRaw = readings;
el1 = zeroes(length(n));
el1l = 1;
el2 = zeroes(length(n));
el2l = 1;
for s = 1:length(n)
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