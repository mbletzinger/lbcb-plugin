classdef  InputFile < handle
    properties
    targets = {};
    node = '';
    path = '';
    end
    methods
        function load(me,path)
             tgts= load(path);	% 6 column data
            tmp = size(tgts);
            if tmp(2) ~= 6
                errordlg('Input file should have six columns of data.');
                return
            end
            me.targets = tgts;
            me.path = path;
        end
    end
end