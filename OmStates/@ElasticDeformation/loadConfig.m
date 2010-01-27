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
end