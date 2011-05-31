classdef TextArchive < handle
    properties
    path = '';
    hpath
    headers={};
    end
    methods
        function me = TextArchive(name)
            me = me.createPath(name);
        end
        function writeText(me,text)
            fid = fopen(me.path,'a');
            fprintf(fid,'%s',text);
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
            pname = strcat(name,me.dateSuffix(),'.txt');
            me.path = fullfile(pth,pname);
            pname = strcat(name,'_hdr.txt');
            me.hpath = fullfile(pth,pname);
        end
    end
end