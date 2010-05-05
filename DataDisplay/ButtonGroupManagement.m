classdef ButtonGroupManagement < handle
    properties
        grpHandle
        childHandles % Sorted in the order of the StateEnum
        offColor
    end
    methods
        function me = ButtonGroupManagement(hndl)
            me.grpHandle = hndl;
            me.childHandles = {};
            me.offColor = [0 0 0];
        end
        function init(me)
            me.offColor = get(me.childHandles{1},'BackgroundColor');
        end
        function setState(me,sidx)
            if isempty(me.grpHandle)
                return
            end
            for i = 1 : length(me.childHandles)
                h = me.childHandles{i};
                if i == sidx
                    set(h,'BackgroundColor','cyan');
                    set(h,'FontWeight','bold');
                    set(h,'Value',true);
                else
                    set(h,'BackgroundColor',me.offColor);
                    set(h,'FontWeight','light');
                    set(h,'Value',false);
                end
            end
        end
    end
end