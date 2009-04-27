classdef  InputFile < handle
    properties
    targets = {};
    node = '';
    path = '';
    end
    methods
        function load(me,path)
             targets= load(path);	% 6 column data
            tmp = size(targets);
            if tmp(2) ~= 6
                errordlg('Input file should have six columns of data.');
                return
            end
            me.targets = targets;
            me.path = path;
        end
    end
end