function loadConfig(me,cfg,isLbcb1)
ocfg = OmConfigDao(cfg);
applied = ocfg.apply2Lbcb;
names = ocfg.sensorNames;
base = [ ocfg.baseX; ocfg.baseY; ocfg.baseZ ]';
plat = [ ocfg.platX; ocfg.platY; ocfg.platZ ]';
perts = ocfg.perturbationsL2;
sensorErrorTol = ocfg.sensorErrorTol;
lb = 'LBCB2';
if isLbcb1
    lb = 'LBCB1';
    perts = ocfg.perturbationsL1;
end
i = 1;

mbase = zeros(length(applied),3);
mplat = zeros(length(applied),3);
mpotTol = zeros(length(applied));
for s = 1:length(applied)
    if isempty(names{s})
        continue;
    end
    if strcmp(applied{s},lb)
      mbase(:,i) = base(s);  
      mplat(:,i) = plat(s);  
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