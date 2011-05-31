classdef DataArchive < TextArchive
    properties
    path = '';
    hpath
    headers={};
    end
    methods
        function me = DataArchive(name)
            me = me.createPath(name);
        end
        function write(me,stepNumber,data,note)
            str = printf(fid,'%s	',stepNumber);
            for i=1:length (data)
                str = printf(fid,'%s%+12.7e	',str,data(i));
            end
            str = printf(fid,'%s%s\r\n',str,note);
            me.writeText(str);
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