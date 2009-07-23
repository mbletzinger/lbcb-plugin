function shutdown(me)
connections = me.oc.connectionType.states;
for c = 1: length(connections)
    opened = me.oc.connectionStatus(c);
    if opened == 0
        continue;
    end
    me.oc.start(connections{c},me.cfg);
    while me.oc.isDone() == 0
    end
end
end