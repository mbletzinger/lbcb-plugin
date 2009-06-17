function execute(me)
a = me.currentAction.getState();
switch a
    case  'OPEN CONNECTION'
        ncfg = NetworkConfigDao(me.cfg);
        ml = MdlLbcb(ncfg.omHost, ncfg.omPort, ncfg.timeout);
        SimulationState.setMdlLbcb(ml);
    case 'CLOSE CONNECTION'
    case'NEXT TARGET'
    case 'PROPOSE EXECUTE'
    case 'GET CONTROL POINTS'
    case 'CHECK LIMITS'
    case 'READY'
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
end