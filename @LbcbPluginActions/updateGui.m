function updateGui(me)
global gui
% Update handles structure
h = me.handles
g = gui
guidata(gcbo, me.handles);
end