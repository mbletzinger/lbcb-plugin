function genOmConfig(me)
ocfg = OmConfigDao(me.cfg);
sensorNames = cell(15,1);
apply2Lbcb = cell(15,1);
sensorNames(1:6,1) = {'Ext.Long.LBCB2' 'Ext.Tranv.TopLBCB2' 'Ext.Tranv.Bot.LBCB2',...
    'Ext.Long.LBCB1', 'Ext.Tranv.LeftLBCB1' 'Ext.Tranv.RightLBCB1'}';
apply2Lbcb(1:6,1) = {'LBCB2' 'LBCB2' 'LBCB2' 'LBCB1' 'LBCB1' 'LBCB1'}';
sensitivities = ones(15,1) * 0.99994;
ocfg.sensorNames = sensorNames;
ocfg.apply2Lbcb = apply2Lbcb;
ocfg.numLbcbs = 2;
ocfg.sensitivities = sensitivities;
perts = [.333 .333 0 .000222 0 0 .444 .444 0 .00011 0 0 ];
tgts = {Target Target };
for t = 1:6
    tgts{1}.setDispDof(t,perts(t));
    tgts{2}.setDispDof(t,perts(t + 6));
end
ocfg.perturbationsL1 = tgts{1};
ocfg.perturbationsL2 = tgts{2};
end
