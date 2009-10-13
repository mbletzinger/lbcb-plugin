function updateStepsDisplay(me,simstep)
set(me.stepHandles{1},'String',sprintf('%d',simstep.step));
set(me.stepHandles{2},'String',sprintf('%d',simstep.subStep));

end