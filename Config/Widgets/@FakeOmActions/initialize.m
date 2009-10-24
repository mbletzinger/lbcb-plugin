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

me.eNameHandles{1} = me.handle.ExtName1;
me.eNameHandles{2} = me.handle.ExtName2;
me.eNameHandles{3} = me.handle.ExtName3;
me.eNameHandles{4} = me.handle.ExtName4;
me.eNameHandles{5} = me.handle.ExtName5;
me.eNameHandles{6} = me.handle.ExtName6;
me.eNameHandles{7} = me.handle.ExtName7;
me.eNameHandles{8} = me.handle.ExtName8;
me.eNameHandles{9} = me.handle.ExtName9;
me.eNameHandles{10} = me.handle.ExtName10;
me.eNameHandles{11} = me.handle.ExtName11;
me.eNameHandles{12} = me.handle.ExtName12;
me.eNameHandles{13} = me.handle.ExtName13;
me.eNameHandles{14} = me.handle.ExtName14;
me.eNameHandles{15} = me.handle.ExtName15;

me.eScaleHandles{1} = me.handle.ExtS1;
me.eScaleHandles{2} = me.handle.ExtS2;
me.eScaleHandles{3} = me.handle.ExtS3;
me.eScaleHandles{4} = me.handle.ExtS4;
me.eScaleHandles{5} = me.handle.ExtS5;
me.eScaleHandles{6} = me.handle.ExtS6;
me.eScaleHandles{7} = me.handle.ExtS7;
me.eScaleHandles{8} = me.handle.ExtS8;
me.eScaleHandles{9} = me.handle.ExtS9;
me.eScaleHandles{10} = me.handle.ExtS10;
me.eScaleHandles{11} = me.handle.ExtS11;
me.eScaleHandles{12} = me.handle.ExtS12;
me.eScaleHandles{13} = me.handle.ExtS13;
me.eScaleHandles{14} = me.handle.ExtS14;
me.eScaleHandles{15} = me.handle.ExtS15;

me.eOffsetHandles{1} = me.handle.ExtO1;
me.eOffsetHandles{2} = me.handle.ExtO2;
me.eOffsetHandles{3} = me.handle.ExtO3;
me.eOffsetHandles{4} = me.handle.ExtO4;
me.eOffsetHandles{5} = me.handle.ExtO5;
me.eOffsetHandles{6} = me.handle.ExtO6;
me.eOffsetHandles{7} = me.handle.ExtO7;
me.eOffsetHandles{8} = me.handle.ExtO8;
me.eOffsetHandles{9} = me.handle.ExtO9;
me.eOffsetHandles{10} = me.handle.ExtO10;
me.eOffsetHandles{11} = me.handle.ExtO11;
me.eOffsetHandles{12} = me.handle.ExtO12;
me.eOffsetHandles{13} = me.handle.ExtO13;
me.eOffsetHandles{14} = me.handle.ExtO14;
me.eOffsetHandles{15} = me.handle.ExtO15;

me.eDerivedHandles{1} = me.handle.ExtA1;
me.eDerivedHandles{2} = me.handle.ExtA2;
me.eDerivedHandles{3} = me.handle.ExtA3;
me.eDerivedHandles{4} = me.handle.ExtA4;
me.eDerivedHandles{5} = me.handle.ExtA5;
me.eDerivedHandles{6} = me.handle.ExtA6;
me.eDerivedHandles{7} = me.handle.ExtA7;
me.eDerivedHandles{8} = me.handle.ExtA8;
me.eDerivedHandles{9} = me.handle.ExtA9;
me.eDerivedHandles{10} = me.handle.ExtA10;
me.eDerivedHandles{11} = me.handle.ExtA11;
me.eDerivedHandles{12} = me.handle.ExtA12;
me.eDerivedHandles{13} = me.handle.ExtA13;
me.eDerivedHandles{14} = me.handle.ExtA14;
me.eDerivedHandles{15} = me.handle.ExtA15;

eScale = fcfg.eScale;
eOffset = fcfg.eOffset;
eDerived = fcfg.eDerived;

for d = 1:15
    set(me.eDerivedHandles{d},'String',options);
    
    if isempty(eScale) == 0 && length(eScale) >= d
    set(me.eScaleHandles{d},'String', sprintf('%f',eScale(d)));
    end
    if isempty(eOffset) == 0 && length(eOffset) >= d
        set(me.eOffsetHandles{d},'String', sprintf('%f',eOffset(d)));
    end
    if isempty(eDerived) == 0 && length(eDerived) >= d
        me.derivedVal.setState(eDerived{d});
    else
        me.derivedVal.idx = d;
    end
    set(me.eDerivedHandles{d},'Value',me.derivedVal.idx);
end
    set(me.handle.ConvergenceSteps,'String',sprintf('%d',fcfg.convergeSteps));
    set(me.handle.ConvergenceIncrement,'String',sprintf('%f',fcfg.convergeInc));
end