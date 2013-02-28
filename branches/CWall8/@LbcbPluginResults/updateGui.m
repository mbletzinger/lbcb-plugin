function updateGui(me)
% Update handles structure
h = me.handles;
g = h.LbcbPlugin;
if isempty(h) == 0 && me.shuttingDown == false
guidata(g, h);
end
end