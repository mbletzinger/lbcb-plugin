classdef TimeCalculator < handle
    properties
        start
        millis
        running
        paused
        ptime
        pinterval
    end
    methods
        function me = TimeCalculator()
            me.running = false;
            me.paused = false;
            me.millis = 0;
            me.pinterval = 0;
        end
        function time2Pause(me,p)
            if me.paused == p
                return;
            end
            me.paused = p;
            if(p)
                me.ptime = cputime;
            else
                me.pinterval = me.pinterval + cputime - me.ptime;
            end
        end
        function time2Start(me)
            me.start=cputime;
            me.running = true;
        end
        function tm = time2Stop(me)
            me.running = false;
            me.millis = cputime - me.start - me.pinterval;
            tm = me.get();
        end
        function tm = get(me)
            if(me.running)
                millis = cputime - me.start - me.pinterval; %#ok<*PROP>
            else
                millis = me.millis;
            end
            tm = TimeRep(millis);
        end
    end
end