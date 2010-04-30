classdef ButtonGroupManagement
    properties
        grpHandle
        childHandles % Sorted in the order of the StateEnum
    end
    methods
        function me = ButtonGroupManagement(hndl)
            me.grpHandle = hndl;
        end
        function setState(me,sidx)
            myh = me.chldHandles{sidx};
            for i = 1 : length(me.childHandles)
                h = me.childHandles{i};
                if i == sidx
                    set(h,'BackgroundColor','cyan');
                    set(h,'FontWeight','bold');
                    set(h,'Value',True);
                else
                    set(h,'BackgroundColor','yellow');
                    set(h,'FontWeight','light');
                    set(h,'Value',True);
                end
            end
        end
    end
end