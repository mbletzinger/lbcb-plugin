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

function curResponse = calculate(me, prevResponse, sensorReadings, initialReadings)

%------------------
% obtain all variables
%------------------
xpin = me.pinLocations;
xfix = me.fixedLocations;
%==
disp = sensorReadings - initialReadings;

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

%==
opt = optimset('MaxFunEvals',me.opSetting.maxfunevals,'MaxIter',me.optSetting.maxiter,...
               'TolFun',me.optSetting.tolfun,'TolX',me.optSetting.tolx,...
               'Jacobian',me.optSetting.jacob,'Display','off','LevenbergMarquardt','on');

%------------------
% Convert the sensor space to the Cartesian space
% description: this algorithm calculates the command based on the current
% position (command)
% this function still has some additional features which can be called in
% the future.
%------------------
curResponse = prevResponse + disp2controlpoint(disp,xpin,xfix,[],prevResponse,3,opt);

%------------------
% end
%------------------
end