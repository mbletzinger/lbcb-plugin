function updateAlerts(me)
me.hfact.cl.setAlerts(me.alerts);
me.hfact.il.setAlerts(me.alerts);
set(me.handles.AlertBox,me.alerts.list,'String');
end