function setScale(me,idx,strVal,isLbcb2)
fcfg = FakeOmDao(me.cfg);
value = str2double(strVal);
if isLbcb2
    fcfg.scale2(idx) = value;
else
    fcfg.scale1(idx) = value;
end
end