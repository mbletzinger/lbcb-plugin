function test_suite = testWindowLimitsDao
initTestSuite;

function test_WindowLimitsDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
label = 'limits';
wldcfg = WindowLimitsDao(label, cfg);

result = wldcfg.dt.getDoubleVector(sprintf('%s.window1',wldcfg.label),zeros(12,1));
wld_window1 = zeros(12,1);
assertEqual(wld_window1,result)

value = ones(12,1);
wldcfg.dt.setDoubleVector(sprintf('%s.window1',wldcfg.label),value);
result = wldcfg.dt.getDoubleVector(sprintf('%s.window1',wldcfg.label),zeros(12,1));
wld_window1 = ones(12,1);
assertEqual(wld_window1,result)

result = wldcfg.dt.getDoubleVector(sprintf('%s.window2',wldcfg.label),zeros(12,1));
wld_window2 = zeros(12,1);
assertEqual(wld_window2,result)

value = ones(12,1);
wldcfg.dt.setDoubleVector(sprintf('%s.window2',wldcfg.label),value);
result = wldcfg.dt.getDoubleVector(sprintf('%s.window2',wldcfg.label),zeros(12,1));
wld_window2 = ones(12,1);
assertEqual(wld_window2,result)


result = wldcfg.dt.getDoubleVector(sprintf('%s.used1',wldcfg.label),zeros(12,1));
wld_used1 = zeros(12,1);
assertEqual(wld_used1,result)

value = ones(12,1);
wldcfg.dt.setDoubleVector(sprintf('%s.used1',wldcfg.label),value);
result = wldcfg.dt.getDoubleVector(sprintf('%s.used1',wldcfg.label),zeros(12,1));
wld_used1 = ones(12,1);
assertEqual(wld_used1,result)

result = wldcfg.dt.getDoubleVector(sprintf('%s.used2',wldcfg.label),zeros(12,1));
wld_used2 = zeros(12,1);
assertEqual(wld_used2,result)

value = ones(12,1);
wldcfg.dt.setDoubleVector(sprintf('%s.used2',wldcfg.label),value);
result = wldcfg.dt.getDoubleVector(sprintf('%s.used2',wldcfg.label),zeros(12,1));
wld_used2 = ones(12,1);
assertEqual(wld_used2,result)
