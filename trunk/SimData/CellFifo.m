classdef CellFifo < handle
    properties
        max
        fifo
        log = Logger('CellFifo');
    end
    methods
        function me = CellFifo(max)
            me.max = max;
            me.fifo = cell(1,max);
        end
        function push(me,element)
            me.fifo(2:me.max) = me.fifo(1:me.max -1);
            me.fifo{1} = element;
        end
        function element = pop(me)
            element = me.fifo{1};
            me.fifo(1:me.max - 1) = me.fifo(2:me.max);
            me.fifo{me.max} = [];
        end
        function element = get(me,index)
            if index > me.max
                me.log.debug(dbstack,sprintf('Index %i is larger than %i',index, me.max));
                element = [];
                return
            end
            element = me.fifo{index};
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