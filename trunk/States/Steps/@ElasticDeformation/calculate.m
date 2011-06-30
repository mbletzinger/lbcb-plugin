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

function curResponse = calculate(me,curCommand)

%------------------
% obtain all variables
%------------------
xpin = me.pinLocations;
xfix = me.fixedLocations;
%==
disp = curReadings - initialReadings;

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
% Make default values for optimization setting
% optSetting.maxfunevals : max. # of iterations for minimizing
%                          the objective function (default = 1000)
% optSetting.maxiter : max. # of iterations for optimizing the
%                      control point (default = 100)
% optSetting.tolfun : tolerance of the objective function
%                     (default = 1e-8)
% optSetting.tolx: tolerance of the control point
%                  (default = 1e-12)
% optSetting.jacob: switch for jacobian matrix, 'on' or 'off'
%                   (default = 'on')
%------------------
if isempty(me.optSetting.maxfunevals)
    maxfunevals = 1000;
else
    maxfunevals = me.optSetting.maxfunevals;
end
if isempty(me.optSetting.maxiter)
    maxiter = 100;
else
    maxiter = me.optSetting.maxiter;
end
if isempty(me.optSetting.tolfun)
    tolfun = 1e-8;
else
    tolfun = me.optSetting.tolfun;
end
if isempty(me.optSetting.tolx)
    tolx = 1e-12;
else
    tolx = me.optSetting.tolx;
end
if isempty(me.optSetting.jacob)
    jacob = 'on';
else
    jacob = me.optSetting.jacob;
end
%==
opt = optimset('MaxFunEvals',maxfunevals,'MaxIter',maxiter,...
               'TolFun',tolfun,'TolX',tolx,...
               'Jacobian',jacob,'Display','off','LevenbergMarquardt','on');

%------------------
% Convert the sensor space to the Cartesian space
% description: this algorithm calculates the command based on the current
% position (command)
% this function still has some additional features which can be called in
% the future.
%------------------
curResponse = curCommand + disp2controlpoint(disp,xpin,xfix,[],curCommand,3,opt);

%------------------
% end
%------------------
end