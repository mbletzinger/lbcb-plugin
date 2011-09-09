% generate a new LbcbStep based on the current step
% function calculate(me,ccps, pcps, tcps)
% me.loadCfg();
% me.loadConfig();
% scfg = StepCorrectionConfigDao(me.cdp.cfg);
% funcs = scfg.calculationFunctions;
% if isempty(funcs)
%     return;
% end
% if strcmp(funcs{1},'<NONE>')
%     return;
% end
% edCalc = str2func(funcs{1});
% edCalc(me,ccps, pcps, tcps);
% end

function curResponse = calculate(me, prevResponse, curReadings, initialPosition)

%------------------
% obtain all variables
%------------------
xpin = me.pinLocations;
xfix = me.fixedLocations;
%==
disp = curReadings - initialPosition;

%------------------
% Obtain idof
%------------------
idof = me.st.used;
%==
[mdof,ndof] = size(idof);
if mdof > ndof
    idof = idof';
end
idof = idof(1:6);



%------------------
% Check
%------------------
if size(xpin,2) == 3
    xpin = xpin';
end
if size(xfix,2) == 3
    xfix = xfix';
end
%==
if size(disp,2) ~= 1
    disp = disp';
end

%------------------
% Setting for optimization
%------------------
if isempty(me.optSetting) % OM config is NOT passed into here in the first step
    optm.maxfunevals = 1000;
    optm.maxiter = 100;
    optm.tolfun = 1e-8;
    optm.tolx = 1e-12;
    optm.jacob = 'on';
else
    if isempty(me.optSetting.maxfunevals)
        optm.maxfunevals = 1000;
    else
        optm.maxfunevals = me.optSetting.maxfunevals;
    end
    if isempty(me.optSetting.maxiter)
        optm.maxiter = 100;
    else
        optm.maxiter = me.optSetting.maxiter;
    end
    if isempty(me.optSetting.tolfun)
        optm.tolfun = 1e-8;
    else
        optm.tolfun = me.optSetting.tolfun;
    end
    if isempty(me.optSetting.tolx)
        optm.tolx = 1e-12;
    else
        optm.tolx = me.optSetting.tolx;
    end
    if isempty(me.optSetting.jacob)
        optm.jacob = 'on';
    else
        if me.optSetting.jacob
            optm.jacob = 'on';
        else
            optm.jacob = 'off';
        end
    end
end

%------------------
% perturbation
%------------------
% me.transPert = ocfg.transPert;
% me.rotPert = ocfg.rotPert;
if isempty(me.transPert) || (length(me.transPert)<3)
    temp1 = me.transPert(1)*ones(3,1);
else
    temp1 = ones(3,1);
end
if isempty(me.rotPert) || (length(me.rotPert)<3)
    temp2 = me.rotPert*ones(3,1);
else
    temp2 = 0.005*ones(3,1);
end
%==
optm.pert_total = [temp1;temp2];

%------------------
% Convert the sensor space to the Cartesian space
% description: this algorithm calculates the command based on the current
% position (command)
% this function still has some additional features which can be called in
% the future.
%------------------
temp = ElasticDeformation.disp2controlpoint(disp,xpin,xfix,[],prevResponse,3,optm,idof);
%==
me.log.debug(dbstack,sprintf('\n    /edreal/Dx=%11.7f/Dy=%11.7f/Dz=%11.7f/Rx=%11.7f/Ry=%11.7f/Rz=%11.7f',temp+prevResponse));
ind = find(me.st.used(1:6)==1);
curResponse = prevResponse;
curResponse(ind) = prevResponse(ind) + temp(ind);
% curResponse = prevResponse + temp;

%------------------
% end
%------------------
end