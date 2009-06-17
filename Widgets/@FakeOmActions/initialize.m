function initialize(me,cfg)

me.cfg = cfg;

me.scaleHandles1{1} = me.handle.DxS1;
me.scaleHandles1{2} = me.handle.DyS1;
me.scaleHandles1{3} = me.handle.DzS1;
me.scaleHandles1{4} = me.handle.RxS1;
me.scaleHandles1{5} = me.handle.RyS1;
me.scaleHandles1{6} = me.handle.RzS1;
me.scaleHandles1{7} = me.handle.FxS1;
me.scaleHandles1{8} = me.handle.FyS1;
me.scaleHandles1{9} = me.handle.FzS1;
me.scaleHandles1{10} = me.handle.MxS1;
me.scaleHandles1{11} = me.handle.MyS1;
me.scaleHandles1{12} = me.handle.MzS1;

me.scaleHandles2{1} = me.handle.DxS2;
me.scaleHandles2{2} = me.handle.DyS2;
me.scaleHandles2{3} = me.handle.DzS2;
me.scaleHandles2{4} = me.handle.RxS2;
me.scaleHandles2{5} = me.handle.RyS2;
me.scaleHandles2{6} = me.handle.RzS2;
me.scaleHandles2{7} = me.handle.FxS2;
me.scaleHandles2{8} = me.handle.FyS2;
me.scaleHandles2{9} = me.handle.FzS2;
me.scaleHandles2{10} = me.handle.MxS2;
me.scaleHandles2{11} = me.handle.MyS2;
me.scaleHandles2{12} = me.handle.MzS2;

me.offsetHandles1{1} = me.handle.DxO1;
me.offsetHandles1{2} = me.handle.DyO1;
me.offsetHandles1{3} = me.handle.DzO1;
me.offsetHandles1{4} = me.handle.RxO1;
me.offsetHandles1{5} = me.handle.RyO1;
me.offsetHandles1{6} = me.handle.RzO1;
me.offsetHandles1{7} = me.handle.FxO1;
me.offsetHandles1{8} = me.handle.FyO1;
me.offsetHandles1{9} = me.handle.FzO1;
me.offsetHandles1{10} = me.handle.MxO1;
me.offsetHandles1{11} = me.handle.MyO1;
me.offsetHandles1{12} = me.handle.MzO1;

me.offsetHandles2{1} = me.handle.DxO2;
me.offsetHandles2{2} = me.handle.DyO2;
me.offsetHandles2{3} = me.handle.DzO2;
me.offsetHandles2{4} = me.handle.RxO2;
me.offsetHandles2{5} = me.handle.RyO2;
me.offsetHandles2{6} = me.handle.RzO2;
me.offsetHandles2{7} = me.handle.FxO2;
me.offsetHandles2{8} = me.handle.FyO2;
me.offsetHandles2{9} = me.handle.FzO2;
me.offsetHandles2{10} = me.handle.MxO2;
me.offsetHandles2{11} = me.handle.MyO2;
me.offsetHandles2{12} = me.handle.MzO2;

me.derivedHandles1{1} = me.handle.DxD1;
me.derivedHandles1{2} = me.handle.DyD1;
me.derivedHandles1{3} = me.handle.DzD1;
me.derivedHandles1{4} = me.handle.RxD1;
me.derivedHandles1{5} = me.handle.RyD1;
me.derivedHandles1{6} = me.handle.RzD1;
me.derivedHandles1{7} = me.handle.FxD1;
me.derivedHandles1{8} = me.handle.FyD1;
me.derivedHandles1{9} = me.handle.FzD1;
me.derivedHandles1{10} = me.handle.MxD1;
me.derivedHandles1{11} = me.handle.MyD1;
me.derivedHandles1{12} = me.handle.MzD1;

me.derivedHandles2{1} = me.handle.DxD2;
me.derivedHandles2{2} = me.handle.DyD2;
me.derivedHandles2{3} = me.handle.DzD2;
me.derivedHandles2{4} = me.handle.RxD2;
me.derivedHandles2{5} = me.handle.RyD2;
me.derivedHandles2{6} = me.handle.RzD2;
me.derivedHandles2{7} = me.handle.FxD2;
me.derivedHandles2{8} = me.handle.FyD2;
me.derivedHandles2{9} = me.handle.FzD2;
me.derivedHandles2{10} = me.handle.MxD2;
me.derivedHandles2{11} = me.handle.MyD2;
me.derivedHandles2{12} = me.handle.MzD2;

fcfg = FakeOmDao(cfg);
scale1 = fcfg.scale1;
scale2 = fcfg.scale2;
offset1 = fcfg.offset1;
offset2 = fcfg.offset2;
derived1 = fcfg.derived1;
derived2 = fcfg.derived2;
options = fcfg.derivedOptions;
me.derivedVal = StateEnum(options);

for d = 1:12
    set(me.derivedHandles1{d},'String',options);
    set(me.derivedHandles2{d},'String',options);
    
    set(me.scaleHandles1{d},'String', sprintf('%f',scale1(d)));
    set(me.scaleHandles2{d},'String', sprintf('%f',scale2(d)));
    set(me.offsetHandles1{d},'String', sprintf('%f',offset1(d)));
    set(me.offsetHandles2{d},'String', sprintf('%f',offset2(d)));
    if isempty(derived1) == 0
        me.derivedVal.setState(derived1{d});
    else
        me.derivedVal.idx = d;
    end
    set(me.derivedHandles1{d},'Value',me.derivedVal.idx);
    if isempty(derived2) == 0
        me.derivedVal.setState(derived2{d});
    else
        me.derivedVal.idx = d + 12;
    end
    set(me.derivedHandles2{d},'Value',me.derivedVal.idx);
end
end