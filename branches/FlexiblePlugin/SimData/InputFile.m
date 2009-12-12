classdef  InputFile < Substeps
    properties
    filename = '';
    specfilename = '';
    commandDofs = [];
    log = Logger('InputFile');
    sdf = [];
    end
    methods
        function me = InputFile(sdf)
            me.sdf = sdf;
        end
        function done = load(me,path)
            me.endOfFile = 0;
            tgts= load(path);
            tmp = size(tgts);
            me.readSpecfile(path);
            s = sum(me.commandDofs);
            if tmp(2) ~= s
                errordlg(sprintf('Input file %s should have %d columns of data.',path,s));
                done = 0;
                return
            end
            me.loadSteps(tgts)
            done = 1;
        end
        function readSpecfile(me,path)
            me.commandDofs = zeros(1,24);
            [pathstr, name, ext, versn] = fileparts(path); %#ok<NASGU>
            specname = sprintf('%s_spec%s',name,ext);
            specpath = fullfile(pathstr,specname);
            if exist(specname,'file') == 2
                cmdDofs = load(specpath);
            else
                cmdDofs = [1 1 1 1 1 1];
            end
            me.commandDofs(1,1:length(cmdDofs)) = cmdDofs;
        end
        function loadSteps(me,tgts)
            [lgth dummy] = size(tgts); %#ok<NASGU>
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
%                    me.log.debug(dbstack,sprintf('d=%d i=%d',d,i)); 
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
%                me.log.debug(dbstack,sprintf('Created tgt1=%s',tgt1.toString()));
                if sum(me.commandDofs(12:24)) > 0
                    targets = { tgt1; tgt2 };
%                    me.log.debug(dbstack,sprintf('Created tgt2=%s',tgt2.toString()));
                else
                    targets = {tgt1};
                end
                me.steps{t} = me.sdf.target2StepData(targets,t,0);
%                me.log.debug(dbstack,sprintf('Created step=%s',me.steps{t}.toString()));
            end
            me.started = false;
        end
    end
end