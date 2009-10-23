classdef DataArchive < handle
    properties
    path = '';
    headers={};
    end
    methods
        function me = DataArchive(name)
            me = me.createPath(name);
        end
        function write(me,stepNumber,data,note)
            fid = fopen(me.path,'a');
            fprintf(fid,'%s	',stepNumber);
            for i=1:length (data)
                fprintf(fid,'%+12.7e	',data(i));
            end
            fprintf(fid,'%s	',note);
            fprintf(fid,'\r\n');
            fclose(fid);
        end
        function writeHeaders(me)
            fid = fopen(me.path,'w');
            for i=1:length (me.headers)
                fprintf(fid,'%s	',me.headers{i});
            end
            fprintf(fid,'\r\n');
            fclose(fid);
        end
        function size = filesize(me)
            s = dir(me.path);
            size = s.bytes;
        end
        function suffix = dateSuffix(me)
           suffix =  datestr(now,'_yyyy_mm_dd_HH_MM_SS');
        end
        function me = createPath(me,name)
            root = pwd;
            pth = fullfile(root,'Logs');
            if isdir( pth ) ==false
                mkdir(pth); 
            end
            name = strcat(name,me.dateSuffix(),'.txt');
            me.path = fullfile(pth,name);
        end
    end
end