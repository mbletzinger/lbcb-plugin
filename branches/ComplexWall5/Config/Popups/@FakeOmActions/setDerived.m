function setDerived(me,idx,valI,isLbcb2)
fcfg = FakeOmDao(me.cfg);
me.derivedVal.idx = valI;
value = me.derivedVal.getState();
if isLbcb2
    fcfg.derived2{idx} = value;
else
    fcfg.derived1{idx} = value;
end
end