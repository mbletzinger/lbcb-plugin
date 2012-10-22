function curResponse = calculateTest(me, correctionTarget,stepNum)
curResponse = zeros(6,1);
corStep = stepNum.correctionStep;
if rem(stepNum.step,2) > 0
    sign = -1;
else
    sign = 1;
end
if corStep == 3
    for d = 1:6
        curResponse(d) = correctionTarget(d) + sign * (me.st.window(d) - 0.0001);
    end
    return;
end

interval = 0.000001 * (3 - corStep);

for d = 1:6
    if me.st.used == false
        curResponse(d) = correctionTarget(d);
        continue;
    end
    curResponse(d) = correctionTarget(d) + sign * (me.st.window(d) + interval);
end
end