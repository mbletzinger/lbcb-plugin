function setEDerived(me,idx,valI)
fcfg = FakeOmDao(me.cfg);
me.derivedVal.idx = valI;
value = me.derivedVal.getState();
fcfg.eDerived{idx} = value;
end