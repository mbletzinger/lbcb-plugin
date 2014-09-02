function done = isDone(me)
done = 0;
a = me.currentAction.getState();
if me.stateChanged()
%     me.ddisp.dbgWin.setTargetState(me.currentAction.idx);
    me.gui.updateSimState(me.currentAction.idx)
end
switch a
    case 'INITIAL POSITION'
        me.initialPosition();
    case 'WAIT FOR TARGET'
        me.waitForTarget();
    case 'EXECUTE SUBSTEPS'
        me.executeSubsteps();
    case 'SEND TARGET RESPONSE'
        me.sendTargetResponses();
    case 'ABORT SIMULATION'
        done = 1;
    case 'DONE'
        done = 1;
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
end
end
