function updateGui(me)
% Update handles structure
h = me.handles;
g = h.LbcbPlugin;
if isempty(h) == 0
guidata(g, h);
end
end