function updateGui(me)
global gui
% Update handles structure
h = me.handles;
g = gui;
if isempty(h) == 0
guidata(g, h);
end
end