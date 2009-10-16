function updateStepsDisplay(me,simstep)
if isempty(me.stepHandles{1})
    me.log.info(dbstack,sprintf('Step %d:%d',simstep.step,simstep.subStep));
    return;
end
set(me.stepHandles{1},'String',sprintf('%d',simstep.step));
set(me.stepHandles{2},'String',sprintf('%d',simstep.subStep));

end