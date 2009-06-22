classdef  InputFile < handle
    properties
    steps = {};
    filename = '';
    specfilename = '';
    sIdx = 1;
    commandDofs = [];
    endOfFile = 0;
    end
    methods
        function done = load(me,path)
            endOfFile = 0;
            done = 0;
            tgts= load(path);
            tmp = size(tgts);
            me.readSpecfile(path);
            s = sum(me.commandDofs);
            if tmp(2) ~= s
                errordlg(sprintf('Input file %s should have %d columns of data.',path,s));
                done = 0;
                return
            end
            lgth = length(tgts);
            me.steps = cell(lgth,1);
            for t = 1:lgth
                tgt1 = Target;
                tgt2 = Target;
                i = 0;
                for d = 1:24
                    if me.commandDofs(d) == 0
                        continue;
                    end
                    i = i+1;
                    if d < 7
                        tgt1.setDispDof(d,tgts(t,i));
                        continue;
                    end
                    if d < 13
                        tgt1.setForceDof(d - 6,tgts(t,i));
                        continue;
                    end
                    if d < 19
                        tgt2.setDispDof(d - 12,tgts(t,i));
                        continue;
                    end
                    tgt2.setForceDof(d - 18,tgts(t,i));
                end
                if sum(me.commandDofs(12:24)) > 0
                    targets = { tgt1, tgt2 };
                else
                    targets = {tgt1};
                end
                me.steps{t} = LbcbStep(SimulationSteps(t,0),targets);
            end
            done = 1;
        end
        function step = next(me)
            if me.sIdx > length(me.steps)
                step = [];
                return;
            end
            if me.sIdx > length(me.steps)
                me.endOfFile = 1;
            else
                step = me.steps{me.sIdx};
                me.sIdx = me.sIdx + 1;
            end
        end
        function readSpecfile(me,path)
            me.commandDofs = zeros(1,24);
            [pathstr, name, ext, versn] = fileparts(path);
            specname = sprintf('%s_spec%s',name,ext);
            specpath = fullfile(pathstr,specname);
            if exist(specname,'file') == 2
                cmdDofs = load(specpath);
            else
                cmdDofs = [1 1 1 1 1 1];
            end
            me.commandDofs(1,1:length(cmdDofs)) = cmdDofs;
        end
    end
end