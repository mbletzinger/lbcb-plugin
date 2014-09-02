function test_suite = testLogLevelsDao
initTestSuite;

function test_LogLevelsDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
lldcfg = LogLevelsDao(cfg);

result = lldcfg.dt.getString('logger.cmdLevel','ERROR');
assertEqual('DEBUG',result)

value = 'DEBUG1';
lldcfg.dt.setString('logger.cmdLevel',value);
result = lldcfg.dt.getString('logger.cmdLevel','ERROR');
assertEqual('DEBUG1',result)

result = lldcfg.dt.getString('logger.msgLevel','ERROR');
assertEqual('INFO',result)

value = 'INFO1';
lldcfg.dt.setString('logger.msgLevel',value);
result = lldcfg.dt.getString('logger.msgLevel','ERROR');
assertEqual('INFO1',result)