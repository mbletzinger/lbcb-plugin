function test_suite = testConfigDaoProvider
initTestSuite;

function test_ConfigDaoProvider

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
me = ConfigDaoProvider(cfg);

