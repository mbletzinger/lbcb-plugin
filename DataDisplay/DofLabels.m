classdef DofLabels < handle
    properties
        labels
    end
    methods
        function me = DofLabels()
            me.labels = org.nees.uiuc.simcor.matlab.HashTable();
            list = { 'Dx', 'Dy', 'Dz','Rx', 'Ry', 'Rz',...
                'Fx', 'Fy', 'Fz','Mx', 'My', 'Mz'};
            for l = 1:length(list)
                me.put(list{l},l);
            end
        end
        function val = get(me,lbl)
            val = me.labels.get(lbl);
        end
        function put(me,lbl,val)
            me.labels.put(lbl,val);
        end
        function yes = exists(me,key)
            yes = me.labels.exists(key);
        end
    end
end