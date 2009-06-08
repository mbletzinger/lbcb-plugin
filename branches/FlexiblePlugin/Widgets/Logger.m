classdef Logger < handle
    properties
        filename = '';
    end
    methods
        function debug(me,stack,msg)
           me.process('DEBUG',stack,msg);
        end
        function info(me,stack,msg)
           me.process('INFO',stack,msg);
        end
        function warning(me,stack,msg)
           me.process('WARNING',stack,msg);
        end
        function error(me,stack,msg)
           me.process('ERROR',stack,msg);
        end
    end
    methods (Access = private)
        function process(me,level,stack,msg)
            str = sprintf('%s - %s: %s',level,me.sstring(stack),msg);
            disp(str);
        end
        function str = sstring(me, stack)
            str = sprintf('%s>%s,%d',stack(1).file,stack(1).name,stack(1).line);
        end
    end

end