function yes = errorsExist(me,connection)
switch connection
    case 'OperationsManager'
        ml = SimulationState.getMdlLbcb();
        if isempty(ml)
            yes = 0;
            return;
        end
        yes = ml.state.isState('ERRORS EXIST');
        %                 case 'TriggerBroadcasting'
        %                 case 'SimCor'
    otherwise
        me.log.error(dbstack(),sprintf('%s not recognized',connection));
end
end