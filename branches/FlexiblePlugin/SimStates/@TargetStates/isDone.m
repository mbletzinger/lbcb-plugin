function done = isDone(me)
done = 0;
me.log.debug(dbstack,sprintf('Executing %s',me.currentAction.getState()));
switch me.currentAction.getState()
    case 'WAIT FOR TARGET'
        me.waitForTarget();
    case 'GET TARGET'
        me.getTarget();
    case 'EXECUTE SUBSTEPS'
        me.executeSubsteps();
    case 'SEND TARGET RESPONSE'
        me.sendTargetResponses();
    case 'DONE'
        done = 1;
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
end
