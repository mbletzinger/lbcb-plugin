function loadConfig(me,cdp,isLbcb1)
ocfg = OmConfigDao(cdp.cfg);
[names se applied ] = cdp.getExtSensors();
lt = length(applied);
base = [ ocfg.baseX(1:lt)'; ocfg.baseY(1:lt)'; ocfg.baseZ(1:lt)' ];
plat = [ ocfg.platX(1:lt)'; ocfg.platY(1:lt)'; ocfg.platZ(1:lt)' ];
perts = ocfg.perturbationsL2;
sensorErrorTol = ocfg.sensorErrorTol;
lb = 'LBCB2';
if isLbcb1
    lb = 'LBCB1';
    perts = ocfg.perturbationsL1;
end
i = 1;

mbase = zeros(lt,3);
mplat = zeros(lt,3);
mpotTol = zeros(lt);
for s = 1:lt
    if strcmp(applied{s},lb)
      mbase(i,:) = base(:,s); %[base(s) base(s+15) base(s+30)];  % Really quick fix
      mplat(i,:) = plat(:,s);%[plat(s) plat(s+15) plat(s+30)];  % Really quick fix
      mpotTol(i) = sensorErrorTol(s);
      i = i + 1;
    end
end
i = i -1;
me.base = mbase(1:i,:);
me.plat = mplat(1:i,:);
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