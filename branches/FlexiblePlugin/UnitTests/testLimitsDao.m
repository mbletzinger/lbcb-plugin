function test_suite = testLimitsDao
initTestSuite;

function test_LimitsDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
label = 'limits';
ldcfg = LimitsDao(label, cfg);

result = ldcfg.dt.getDoubleVector(sprintf('%s.upper1',ldcfg.label),zeros(12,1));
ld_upper1 = zeros(12,1);
assertEqual(ld_upper1,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.upper1',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.upper1',ldcfg.label),zeros(12,1));
ld_upper1 = ones(12,1);
assertEqual(ld_upper1,result)

result = ldcfg.dt.getDoubleVector(sprintf('%s.upper2',ldcfg.label),zeros(12,1));
ld_upper2 = zeros(12,1);
assertEqual(ld_upper2,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.upper2',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.upper2',ldcfg.label),zeros(12,1));
ld_upper2 = ones(12,1);
assertEqual(ld_upper2,result)


result = ldcfg.dt.getDoubleVector(sprintf('%s.lower1',ldcfg.label),zeros(12,1));
ld_lower1 = zeros(12,1);
assertEqual(ld_lower1,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.lower1',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.lower1',ldcfg.label),zeros(12,1));
ld_lower1 = ones(12,1);
assertEqual(ld_lower1,result)

result = ldcfg.dt.getDoubleVector(sprintf('%s.lower2',ldcfg.label),zeros(12,1));
ld_lower2 = zeros(12,1);
assertEqual(ld_lower2,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.lower2',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.lower2',ldcfg.label),zeros(12,1));
ld_lower2 = ones(12,1);
assertEqual(ld_lower2,result)


result = ldcfg.dt.getDoubleVector(sprintf('%s.used1',ldcfg.label),zeros(12,1));
ld_used1 = zeros(12,1);
assertEqual(ld_used1,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.used1',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.used1',ldcfg.label),zeros(12,1));
ld_used1 = ones(12,1);
assertEqual(ld_used1,result)

result = ldcfg.dt.getDoubleVector(sprintf('%s.used2',ldcfg.label),zeros(12,1));
ld_used2 = zeros(12,1);
assertEqual(ld_used2,result)

value = ones(12,1);
ldcfg.dt.setDoubleVector(sprintf('%s.used2',ldcfg.label),value);
result = ldcfg.dt.getDoubleVector(sprintf('%s.used2',ldcfg.label),zeros(12,1));
ld_used2 = ones(12,1);
assertEqual(ld_used2,result)
