function clearAll(me)
lcfg = LimitsDao('command.limits',me.cfg);
lcfg.lower1 = zeros(12,1);
lcfg.upper1 = zeros(12,1);
lcfg.used1 = zeros(12,1);
lcfg.lower2 = zeros(12,1);
lcfg.upper2 = zeros(12,1);
lcfg.used2 = zeros(12,1);
icfg = WindowLimitsDao('increment.limits',me.cfg);
icfg.window1 = zeros(12,1);
icfg.used1 = zeros(12,1);
icfg.window2 = zeros(12,1);
icfg.used2 = zeros(12,1);
scfg = WindowLimitsDao('command.tolerances',me.cfg);
scfg.window1 = zeros(12,1);
scfg.used1 = zeros(12,1);
scfg.window2 = zeros(12,1);
scfg.used2 = zeros(12,1);
end
