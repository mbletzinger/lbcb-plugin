classdef  inputFile < handle
    properties
    targets = targetSequence();
    end
    methods
        function load(me,path)
             targets= load(path);	% 6 column data
            tmp = size(targets);
            if tmp(2) ~= 6
                errordlg('Input file should have six columns of data.');
                return
            end
            me.targets.setTargets(targets);
        end
    end
end