classdef  inputFile < handle
    properties
    targets = zeroes(100,6);
    step = 0;
    total = 0;
    status = stateEnum({ 'NOT LOADED','STOPPED','RUNNING','DONE'});
    end
    methods
        function reset(me)
            me.step = 0;
        end
        function start(me)
            if(me.status.isState('NOT LOADED'))
                return
            end
            me.step = 1;
            me.status.setState('RUNNING');
        end
        function next(me)
            me.step = me.step + 1;
            if me.step > me.total
                me.status.setState('DONE');
            end
        end
        function tgt = getTarget(me)
            tgt = me.targets(me.step,:);
        end
        function load(me,path)
            me.targets= load(path);	% 6 column data
            tmp = size(me.targets);
            if tmp(2) ~= 6
                errordlg('Input file should have six columns of data.');
                return
            end
            me.total = tmp(1);
            me.status.setState('STOPPED');
        end
    end
end