function setEScale(me,idx,strVal)
fcfg = FakeOmDao(me.cfg);
value = str2double(strVal);
fcfg.eScale(idx) = value;
end