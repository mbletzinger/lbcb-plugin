classdef FunctionLists < handle
    properties
        root;
        list;
    end
    methods
        function me = FunctionLists(userdir)
            me.root = pwd;
            me.scanFiles(userdir);
        end
        function scanFiles(me, subdir)
            pth = fullfile(me.root,'UserFunctions',subdir,'*.m');
            lst = dir(pth);
            me.list = cell(length(lst),1);
            for l = 1: length(lst)
               [ p n e ] = fileparts(lst(l).name);
               me.list{l} = n;
            end
        end
        function idx = getIndex(me,func)
           for idx = 1 : length(me.list)
               if strcmp(func,me.list{idx})
                   return;
               end
           end
           idx = -1;
        end
    end
end