function setEOffset(me,idx,strVal)
value = str2double(strVal);
fcfg = FakeOmDao(me.cfg);
fcfg.eOffset(idx) = value;
end