classdef CorrectionButtonGroupManagement < handle
    properties
        grpHandle
        childHandles % Sorted in the order of the StateEnum
        offColor
    end
    methods
        function me = CorrectionButtonGroupManagement(hndl)
            me.grpHandle = hndl;
            me.childHandles = {};
            me.offColor = [0 0 0];
        end
        function init(me)
            me.offColor = get(me.childHandles{1},'BackgroundColor');
        end
        function setState(me,nc,ed,dd, ddl)
            me.off(1);
            me.off(2);
            me.on(3);
            me.labelDD(0);
            
            if nc == true
                return;
            end
            
            if ed
                me.on(1);
                me.off(3);
            end
            
            if dd
                me.on(2);
                me.labelDD(ddl);
                me.off(3);
            end
            return;
        end
        
        function on(me, i)
            h = me.childHandles{i};
            set(h,'BackgroundColor','cyan');
            set(h,'FontWeight','bold');
            set(h,'Value',true);
            
        end
        function off(me, i)
            h = me.childHandles{i};
            set(h,'BackgroundColor',me.offColor);
            set(h,'FontWeight','light');
            set(h,'Value',false);
            
        end
        function labelDD(me,d)
            h = me.childHandles{2};
            lbl = sprintf('Derived L%d',d);
            set(h,'String',lbl);
        end
    end
end