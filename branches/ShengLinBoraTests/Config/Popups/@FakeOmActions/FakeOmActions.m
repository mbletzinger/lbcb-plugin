classdef FakeOmActions < handle
    properties
        handle = [];
        cfg = [];
        scaleHandles1 = cell(12,1);
        scaleHandles2 = cell(12,1);
        offsetHandles1 = cell(12,1);
        offsetHandles2 = cell(12,1);
        derivedHandles1 = cell(12,1);
        derivedHandles2 = cell(12,1);
        derivedVal = [];
        eDerivedHandles = cell(12,1);
        eNameHandles = cell(12,1);
        eScaleHandles = cell(12,1);
        eOffsetHandles = cell(12,1);
    end
    methods
        function me = FakeOmActions(handle)
            me.handle = handle;
        end
        initialize(me,cfg)
        setScale(me,idx,value,isLbcb2)
        setOffset(me,idx,value,isLbcb2)
        setDerived(me,idx,valIdx,isLbcb2)
        setEScale(me,idx,value)
        setEOffset(me,idx,value)
        setEDerived(me,idx,valIdx)
    end
end