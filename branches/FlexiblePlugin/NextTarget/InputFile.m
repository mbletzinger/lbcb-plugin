classdef  InputFile < handle
    properties
    steps = {};
    filename1 = '';
    filename2 = '';
    sIdx = 1;
    end
    methods
        function load(me,path1, path2)
            tgts1= load(path1);	% 12 column data
            tmp = size(tgts1);
            if tmp(2) ~= 12
                errordlg(sprintf('Input file %s should have six columns of data.',path1));
                return
            end
            me.filename1 = path1;
            if isempty(path2) == 0
                tgts2= load(path2);	% 12 column data
                tmp = size(tgts2);
                if tmp(2) ~= 12
                    errordlg(sprintf('Input file %s should have six columns of data.',path2));
                    return
                end
                me.filename2 = path2;
            end
            lgth = length(tgts1);
            me.steps = cell(lgth,1);
            for t = 1:lgth
                tgt1 = Target;
                tgt1.disp = tgts1(t,1:6);
                tgt1.force = tgts1(t,7:12);
                targets = { tgt1};
                if isempty(tgts2) == 0
                    tgt2 = Target;
                    tgt2.disp = tgts2(t,1:6);
                    tgt2.force = tgts2(t,7:12);
                    targets = { tgt1, tgt2 };
                end
                me.steps{1} = LbcbStep(SimulationStep(t,0),targets);
            end
        end
        function step = next(me)
            step = me.steps{me.sIdx};
            me.sIdx = me.sIdx + 1;
        end
    end
end