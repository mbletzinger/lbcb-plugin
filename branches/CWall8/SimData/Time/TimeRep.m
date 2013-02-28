classdef TimeRep < handle
    properties
        millis
    end
    methods
        function me = TimeRep(millis)
            me.millis = millis;
        end
        function str = toString(me)
            hours=floor(me.millis/3600);
            mins=floor((me.millis-hours*3600)/60);
            secs=round(me.millis-hours*3600-mins*60);
            
            str = '';
            if(hours >= 1)
                str = sprintf('%d:',hours);
            end
            if(mins >= 1)
                str = sprintf('%s%02d:',str,mins);
            end
            str = sprintf('%s%02d',str,secs);
        end
    end
end