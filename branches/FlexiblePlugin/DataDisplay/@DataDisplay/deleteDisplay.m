function deleteDisplay(display)
global ddMe;
switch display
    case 0
        ddMe.dataTable.undisplayMe();
    case 1
        ddMe.totalFxVsLbcbDxL1.undisplayMe();
    case 2
        ddMe.totalFxVsLbcbDxL2.undisplayMe();
    case 3
        ddMe.dbgWin.undisplayMe();
    case 4
        ddMe.totalMyVsLbcbDxL1.undisplayMe();
    case 5
        ddMe.totalMyVsLbcbDxL2.undisplayMe();
    case 6
        ddMe.MyVsDxL1.undisplayMe();
    case 7
        ddMe.MyVsDxL2.undisplayMe();
    case 8
        ddMe.RyVsDxL1.undisplayMe();
    case 9
        ddMe.RyVsDxL2.undisplayMe();
    case 10
        ddMe.FxVsDxL1.undisplayMe();
    case 11
        ddMe.FxVsDxL2.undisplayMe();
    case 12
        ddMe.DxStepL1.undisplayMe();
    case 13
        ddMe.DxStepL2.undisplayMe();
    case 14
        ddMe.RyStepL1.undisplayMe();
    case 15
        ddMe.RyStepL2.undisplayMe();
    case 16
        ddMe.DzStepL1.undisplayMe();
    case 17
        ddMe.DzStepL2.undisplayMe();
    otherwise
        me.log.error(dbstack, sprintf('Case %d not recognized',display));
end
