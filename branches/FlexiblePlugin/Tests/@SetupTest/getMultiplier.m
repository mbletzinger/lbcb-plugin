function m = getMultiplier(me, d)
if d <=3
    m = 1;
    return;
end
if d > 3 && d <= 6
    m = .5;
    return;
end
if d > 6 && d <= 9
    m = 5;
    return;
end
m = 12;
end
