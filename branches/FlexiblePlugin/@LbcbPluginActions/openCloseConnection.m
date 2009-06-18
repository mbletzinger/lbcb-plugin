function openCloseConnection(me, connection,closeIt)
switch connection
    case 'OperationManager'
        ncfg = NetworkConfigDao(me.cfg);
        ml = MdlLbcb(ncfg.omHost, ncfg.omPort, ncfg.timeout);
        SimulationState.setMdlLbcb(ml);
        me.oc.start(connection,closeIt);
        %                 case 'TriggerBroadcasting'
        %                 case 'SimCor'
    otherwise
        me.log.error(dbstack(),sprintf('%s not recognized',connection));
end
end
