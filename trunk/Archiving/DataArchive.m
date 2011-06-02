classdef DataArchive < TextArchive
    properties
        headers
    end
    methods
        function me = DataArchive(name)
            me = me@TextArchive(name);
            me.headers = {};
        end
        function write(me,stepNumber,data)
            fid = fopen(me.path,'a');
            str = sprintf(fid,'%s	',stepNumber);
            for i=1:length (data)
                str = sprintf(fid,'%s%+12.7e	',str,data(i));
            end
            fclose(fid);
        end
        function writeHeaders(me)
            fid = fopen(me.hpath,'w');
            for i=1:length (me.headers)
                fprintf(fid,'%s	',me.headers{i});
            end
            fprintf(fid,'\r\n');
            fclose(fid);
        end
    end
end