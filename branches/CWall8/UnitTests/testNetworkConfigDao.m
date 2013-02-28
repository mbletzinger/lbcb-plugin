function test_suite = testNetworkConfigDao
initTestSuite;

function test_NetworkConfigDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
ncfg = NetworkConfigDao(cfg);

result = ncfg.dt.getString('network.omHost','localhost');
assertEqual('128.174.15.195',result)

value = '128.174.15.205';
ncfg.dt.setString('network.omHost',value);
result = ncfg.dt.getString('network.omHost','localhost');
assertEqual('128.174.15.205',result)

result = ncfg.dt.getInt('network.omPort',1000);
assertEqual(6342,result)

value = 5342;
ncfg.dt.setInt('network.omPort',value);
result = ncfg.dt.getInt('network.omPort',1000);
assertEqual(5342,result)

result = ncfg.dt.getInt('network.triggerPort',1000);
assertEqual(6446,result)

value = 5555;
ncfg.dt.setInt('network.triggerPort',value);
result = ncfg.dt.getInt('network.triggerPort',1000);
assertEqual(5555,result)

result = ncfg.dt.getInt('network.simcorPort',1000);
assertEqual(6445,result)

value = 5554;
ncfg.dt.setInt('network.simcorPort',value);
result = ncfg.dt.getInt('network.simcorPort',1000);
assertEqual(5554,result)

result = ncfg.dt.getInt('network.connectionTimeout',3000);
assertEqual(1200000,result)

value = 2400000;
ncfg.dt.setInt('network.connectionTimeout',value);
result = ncfg.dt.getInt('network.connectionTimeout',3000);
assertEqual(2400000,result)

result = ncfg.dt.getInt('network.msgTimeout',3000);
assertEqual(600000,result)

value = 1200000;
ncfg.dt.setInt('network.msgTimeout',value);
result = ncfg.dt.getInt('network.msgTimeout',3000);
assertEqual(1200000,result)

result = ncfg.dt.getInt('network.execute.msgTimeout',3000);
assertEqual(2400000,result)

value = 4800000;
ncfg.dt.setInt('network.execute.msgTimeout',value);
result = ncfg.dt.getInt('network.execute.msgTimeout',3000);
assertEqual(4800000,result)

result = ncfg.dt.getString('network.address','MDL-00-01');
assertEqual('MDL-00-01',result)

value = 'MDL-00-02';
ncfg.dt.setString('network.address',value);
result = ncfg.dt.getString('network.address','MDL-00-01');
assertEqual('MDL-00-02',result)

result = ncfg.dt.getString('network.system.description','LBCB Plugin');
assertEqual('LBCB Plugin',result)

value = 'LBCB2 Plugin';
ncfg.dt.setString('network.system.description',value);
result = ncfg.dt.getString('network.system.description','LBCB Plugin');
assertEqual('LBCB2 Plugin',result)

result = ncfg.dt.getInt('network.vampInterval',30);
assertEqual(18,result)

value = 36;
ncfg.dt.setInt('network.vampInterval',value);
result = ncfg.dt.getInt('network.vampInterval',30);
assertEqual(36,result)