function checkOff(obj,event,c) %#ok<*INUSD,*INUSL>
global mhndl;
switch c
    case 0
        set(mhndl.DataTable,'Checked','off');
    case 1
        set(mhndl.TotalFxVsLbcb1Dx,'Checked','off');
    case 2
        set(mhndl.TotalFxVsLbcb2Dx,'Checked','off');
    case 3
        %                    set(mhndl.DebugWindow,'Checked','off');
    case 4
        set(mhndl.TotalMyVsLbcb1Dx,'Checked','off');
    case 5
        set(mhndl.TotalMyVsLbcb2Dx,'Checked','off');
    case 6
        set(mhndl.MyVsLbcb1Dx,'Checked','off');
    case 7
        set(mhndl.MyVsLbcb2Dx,'Checked','off');
    case 8
        set(mhndl.RyVsLbcb1Dx,'Checked','off');
    case 9
        set(mhndl.RyVsLbcb2Dx,'Checked','off');
    case 10
        set(mhndl.FxVsLbcb1Dx,'Checked','off');
    case 11
        set(mhndl.FxVsLbcb2Dx,'Checked','off');
    case 12
        set(mhndl.DxStepL1,'Checked','off');
    case 13
        set(mhndl.DxStepL2,'Checked','off');
    case 14
        set(mhndl.RyStepL1,'Checked','off');
    case 15
        set(mhndl.RyStepL2,'Checked','off');
    case 16
        set(mhndl.DzStepL1,'Checked','off');
    case 17
        set(mhndl.DzStepL2,'Checked','off');
    otherwise
        me.log.error(dbstack, sprintf('Case %d not recognized',c));
end
DataDisplay.deleteDisplay(c);
end
