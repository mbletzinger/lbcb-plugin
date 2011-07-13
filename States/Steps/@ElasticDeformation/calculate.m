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

function curResponse = calculate(me, prevResponse)

%------------------
% obtain all variables
%------------------
xpin = me.pinLocations;
xfix = me.fixedLocations;
%==
disp = me.curReadings - me.initialReadings;

%------------------
% Obtain idof
%------------------
idof = me.st.used;
%==
[mdof,ndof] = size(idof);
if mdof > ndof
    idof = idof';
end


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
if isempty(me.opSetting.maxfunevals)
    optm.maxfunevals = 1000;
else
    optm.maxfunevals = me.opSetting.maxfunevals;
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
    optm.jacob = me.optSetting.jacob;
end

%------------------
% perturbation
%------------------
% me.transPert = ocfg.transPert;
% me.rotPert = ocfg.rotPert;
if isempty(me.transPert) || (length(me.transPert)<3)
    temp1 = ones(3,1);
else
    temp1 = me.transPert;
end
if isempty(me.rotPert) || (length(me.rotPert)<3)
    temp2 = 0.005*ones(3,1);
else
    temp2 = me.rotPert;
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
% prevResponse is 1 by 6
%==
temp = prevResponse + ElasticDeformation.disp2controlpoint(disp,xpin,xfix,[],prevResponse,3,optm,idof_update);
%==
% curResponse = temp(idof); 
curResponse = temp;

%------------------
% end
%------------------
end