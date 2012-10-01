function updateAlerts(me)
me.hfact.cl.setAlerts(me.alerts);
me.hfact.il.setAlerts(me.alerts);
if isempty(me.alerts.list)
    set(me.handles.AlertBox,'String','');
else
    set(me.handles.AlertBox,'String',me.alerts.list);
end
end