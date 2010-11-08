function updateStepsDisplay(me,simstep)
if isempty(me.stepHandles{1})
    me.log.info(dbstack,sprintf('Step %d:%d',simstep.step,simstep.subStep));
    return;
end
set(me.stepHandles{1},'String',sprintf('%d',simstep.step));
set(me.stepHandles{2},'String',sprintf('%d',simstep.subStep));
set(me.stepHandles{3},'String',sprintf('%d',simstep.correctionStep));
if isempty(me.commandCurrentValueHandles1) == false
    me.updateGui();
end
end