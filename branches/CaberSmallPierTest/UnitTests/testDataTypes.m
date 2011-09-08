function test_suite = testDataTypes
initTestSuite;

function test_DataTypes

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
me = DataTypes(cfg);

% Don't know how to check the first function!

