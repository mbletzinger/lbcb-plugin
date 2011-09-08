function test_suite = testCorrectionsSettingsDao
initTestSuite;

function test_CorrectionsSettingsDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
csdcfg = CorrectionsSettingsDao(cfg);

result = csdcfg.dt.getStringVector('correctionSettings.labels.cfg',[]);
cs_labels = {'kFactor';'FzTarget';'dxLbcb1';'dxLbcb2';'MyTol';'FzTol';'dFTar';'dFTol';'k_dF';'n';'dx2ry';'ddxGain';[];[];[];[];[];[];[];[]};
assertEqual(cs_labels,result)

value = {[];[];[];[];[];[];[];[];'kFactor';'FzTarget';'dxLbcb1';'dxLbcb2';'MyTol';'FzTol';'dFTar';'k_dF';'n';'dx2ry';'ddxGain'};
csdcfg.dt.setStringVector('correctionSettings.labels.cfg',value);
result = csdcfg.dt.getStringVector('correctionSettings.labels.cfg',[]);
cs_labels = {[];[];[];[];[];[];[];[];'kFactor';'FzTarget';'dxLbcb1';'dxLbcb2';'MyTol';'FzTol';'dFTar';'k_dF';'n';'dx2ry';'ddxGain'};
assertEqual(cs_labels,result)

result = csdcfg.dt.getDoubleVector('correctionSettings.values.cfg',[]);
cs_values = [196.8;50;0;72;500;50;0;5;10000;0;-0.00762;0.8;0;0;0;0;0;0;0;0];
assertEqual(cs_values,result)

value = [0;0;0;0;0;0;0;0;196.8;50;0;72;500;50;0;5;10000;0;-0.0076;0.8];
csdcfg.dt.setDoubleVector('correctionSettings.values.cfg',value);
result = csdcfg.dt.getDoubleVector('correctionSettings.values.cfg',[]);
cs_values = [0;0;0;0;0;0;0;0;196.8;50;0;72;500;50;0;5;10000;0;-0.0076;0.8];
assertEqual(cs_values,result)