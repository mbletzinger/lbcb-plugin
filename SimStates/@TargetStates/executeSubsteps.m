function executeSubsteps(me)
if me.stpEx.isDone() == false
    return;
end
me.currentAction.setState('SEND TARGET RESPONSE');
end
