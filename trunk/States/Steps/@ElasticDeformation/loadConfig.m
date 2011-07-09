function loadConfig(me)
ocfg = OmConfigDao(me.cdp.cfg);
[names se applied ] = me.cdp.getExtSensors();
lt = length(applied);
base = zeros(3,lt);
plat = zeros(3,lt);
for s = 1:lt
    base(:,s) = ocfg.base{s};
    plat(:,s) = ocfg.plat{s};
end
perts = ocfg.perturbationsL2;
sensorErrorTol = ocfg.sensorErrorTol;
lb = 'LBCB2';
if me.isLbcb1
    lb = 'LBCB1';
    perts = ocfg.perturbationsL1;
end
i = 1;

mbase = zeros(3,lt);
mplat = zeros(3,lt);
mpotTol = zeros(lt);
for s = 1:lt
    if strcmp(applied{s},lb)
      mbase(:,i) = base(:,s);
      mplat(:,i) = plat(:,s);
      mpotTol(i) = sensorErrorTol(s);
      i = i + 1;
    end
end
i = i -1;
me.base = mbase(:,1:i);
me.plat = mplat(:,1:i);
me.potTol = mpotTol(1:i);

mperts = zeros(6,1);
mact = zeros(6,1);
i = 1;
for d = 1:6
    if perts.dispDofs(d)
        mperts(i) = perts.disp(d);
        mact(i) = d;
        i = i + 1;
    end
end
i = i -1;
me.perturbations = mperts(1:i);
me.activeDofs = mact(1:i);

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
end