function done = isDone(me)
done = 0;
a = me.currentAction.getState();
if me.currentAction.idx ~= me.prevAction
    me.log.debug(dbstack,sprintf('Executing action %s',a));
    me.prevAction = me.currentAction.idx;
    me.ddisp.dbgWin.setTargetState(me.currentAction.idx);
end
switch a
    case 'INITIAL POSITION'
        me.initialPosition();
    case 'WAIT FOR TARGET'
        me.waitForTarget();
    case 'PROCESS TARGET'
        me.processTarget();
    case 'GET TARGET'
        me.getTarget();
    case 'EXECUTE SUBSTEPS'
        me.executeSubsteps();
    case 'SEND TARGET RESPONSE'
        me.sendTargetResponses();
    case 'DONE'
        done = 1;
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
end
end
