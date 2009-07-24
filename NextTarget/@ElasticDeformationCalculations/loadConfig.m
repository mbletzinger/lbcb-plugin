function loadConfig(me,cfg,isLbcb1)
ocfg = OmConfigDao(cfg);
applied = ocfg.apply2Lbcb;
base = [ ocfg.baseX; ocfg.baseY; ocfg.baseZ ]';
plat = [ ocfg.platX; ocfg.platY; ocfg.platZ ]';
sensorErrorTol = ocfg.sensorErrorTol;
lb = 'LBCB2';
if isLbcb1
    lb = 'LBCB1';
end
i = 1;

mbase = zeros(length(applied),3);
mplat = zeros(length(applied),3);
mpotTol = zeros(length(applied));
for s = 1:length(applied)
    if strcmp(a(s),lb)
      mbase(:,i) = base(s);  
      mplat(:,i) = plat(s);  
      mpotTol(i) = sensorErrorTol(s);
      i = i + 1;
    end
end
me.base = mbase(1:i,:);
me.plat = mplat(1:i,:);
me.potTol = mpotTol(1:i);
end