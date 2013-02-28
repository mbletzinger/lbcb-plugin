classdef TimeFifo < CellFifo
    methods
        function me = TimeFifo(max)
            me = me@CellFifo(max);
        end
        function str = toString(me)
            str = '';
            for i = 1:me.max
                if isempty(me.fifo{i})
                    str = sprintf('%s%i - EMPTY\n',str,i);
                else
                    str = sprintf('%s%s\n',str, me.element2String(i));
                end
            end
        end
        function str = element2String(me, idx)
            str = sprintf('%i - %s',idx,me.fifo{idx}.toString());
        end
        function tm = average(me)
            noT = 0;
            millis = 0;
            for i = 1: me.max
                if isempty(me.fifo{i})
                    break;
                end
                millisi = me.fifo{i}.millis;
                if millisi > 1200
                    break;
                end
                millis = millis + millisi;
                noT = noT + 1;
            end
            tm = TimeRep(millis/noT);
        end
    end
end