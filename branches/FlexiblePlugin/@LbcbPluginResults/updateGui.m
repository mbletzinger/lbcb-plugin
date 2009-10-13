function updateGui(me)
global gui
% Update handles structure
h = me.handles;
g = gui;
guidata(g, me.handles);
end