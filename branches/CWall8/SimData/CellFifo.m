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
        function clear(me)
            me.fifo = cell(1,me.max);
        end
    end
end