classdef StepFifo < CellFifo
    methods
        function me = StepFifo(max)
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
            str = sprintf('%i - %s',idx,me.fifo{idx}.stepNum.toString());
        end
    end
end