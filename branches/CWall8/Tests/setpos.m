
function rect = setpos(object_handle)
% Use RBBOX to establish a position for a GUI component.
% object_handle is a handle to a uicomponent that uses
% any Units. Internally, figure Units are used.

disp(['=== Drag out a Position for object ' inputname(1)])
waitforbuttonpress  % So that rbbox does not return immediately
rect = rbbox;     % User drags out a rectangle, releases button
% Pressing a key aborts rbbox, so check for null width & height
if rect(3) ~= 0 && rect(4) ~= 0
    % Save and restore original units for object
    myunits = get(object_handle,'Units');
    set(object_handle,'Units',get(gcf,'Units'))
    set(object_handle,'Position',rect)
    set(object_handle,'Units',myunits)
else
    rect = [];
end
