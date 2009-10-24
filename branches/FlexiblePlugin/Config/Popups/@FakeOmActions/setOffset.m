function setOffset(me,idx,strVal,isLbcb2)
value = str2double(strVal);
fcfg = FakeOmDao(me.cfg);
if isLbcb2
    fcfg.offset2(idx) = value;
else
    fcfg.offset1(idx) = value;
end
end