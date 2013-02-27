classdef  InputFile < Substeps
    properties
        filename = '';
        specfilename = '';
        commandDofs = [];
        log = Logger('InputFile');
        sdf = [];
        cdp
        stats
    end
    methods
        function me = InputFile(sdf)
            me.sdf = sdf;
        end
        function done = load(me,path,strtStep)
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
            me.loadSteps(tgts,strtStep)
            done = 1;
        end
        function readSpecfile(me,path)
            me.commandDofs = zeros(1,24);
            [pathstr, name, ext] = fileparts(path); %#ok<NASGU>
            specname = sprintf('%s_spec%s',name,ext);
            specpath = fullfile(pathstr,specname);
            if exist(specpath,'file') == 2
                cmdDofs = load(specpath);
            else
                cmdDofs = [1 1 1 1 1 1];
            end
            me.commandDofs(1,1:length(cmdDofs)) = cmdDofs;
        end
        function loadSteps(me,tgts,strtStep)
            % Due to slowing down issue, an itermediate variable called
            % "intermVar" is defined and assigned to "me.steps" at the end
            % of the for loop.
            tic;
            [lgth dummy] = size(tgts); %#ok<NASGU>
            intermVar = cell(lgth,1);
            me.stats.reset();
            me.stats.totalSteps = lgth;
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
                me.log.debug(dbstack,sprintf('Created tgt1=%s',tgt1.toString()));
                if me.sdf.cdp.numLbcbs() > 1
                    targets = { tgt1; tgt2 };
                    me.log.debug(dbstack,sprintf('Created tgt2=%s',tgt2.toString()));
                else
                    targets = {tgt1};
                end
                intermVar{t}=me.sdf.target2StepData(targets,t + strtStep - 1,0);
            end
            intermVar{1}.stepNum.isFirstStep = true;
            me.steps=intermVar;
            me.started = false;
            me.log.info(dbstack,sprintf('Loaded %d steps',lgth));
            toc;
        end
    end
end