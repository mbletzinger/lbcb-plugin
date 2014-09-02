function test_suite = testFakeOmDao
initTestSuite;

function test_FakeOmDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
fodcfg = FakeOmDao(cfg);

result = fodcfg.dt.getStringVector('fake.om.derived1',fodcfg.derivedOptions(1:12));
fod_derived1 = {'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1', 'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1'};
assertEqual(fod_derived1,result)

value = {'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1', 'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1'}';
fodcfg.dt.setStringVector('fake.om.derived1',value);
result = fodcfg.dt.getStringVector('fake.om.derived1',fodcfg.derivedOptions(1:12));
fod_derived1 = {'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1', 'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1'}';
assertEqual(fod_derived1,result)

result = fodcfg.dt.getStringVector('fake.om.derived2',fodcfg.derivedOptions(1:12));
fod_derived2 = {'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1', 'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1'};
assertEqual(fod_derived2,result)

value = {'Fx L2',   'Fy L2',   'Fz L2',   'Mx L2',   'My L2',   'Mz L2', 'Dx L2', 'Dy L2', 'Dz L2', 'Rx L2',  'Ry L2',  'Rz L2'}';
fodcfg.dt.setStringVector('fake.om.derived2',value);
result = fodcfg.dt.getStringVector('fake.om.derived2',fodcfg.derivedOptions(1:12));
fod_derived2 = {'Fx L2',   'Fy L2',   'Fz L2',   'Mx L2',   'My L2',   'Mz L2', 'Dx L2', 'Dy L2', 'Dz L2', 'Rx L2',  'Ry L2',  'Rz L2'}';
assertEqual(fod_derived2,result)

result = fodcfg.dt.getDoubleVector('fake.om.scale1',ones(12,1));
fod_scale1 = ones(12,1);
assertEqual(fod_scale1,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.scale1',value);
result = fodcfg.dt.getDoubleVector('fake.om.scale1',ones(12,1));
fod_scale1 = 2*ones(12,1);
assertEqual(fod_scale1,result)

result = fodcfg.dt.getDoubleVector('fake.om.scale2',ones(12,1));
fod_scale2 = ones(12,1);
assertEqual(fod_scale2,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.scale2',value);
result = fodcfg.dt.getDoubleVector('fake.om.scale2',ones(12,1));
fod_scale2 = 2*ones(12,1);
assertEqual(fod_scale2,result)

result = fodcfg.dt.getDoubleVector('fake.om.offset1',ones(12,1));
fod_offset1 = ones(12,1);
assertEqual(fod_offset1,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.offset1',value);
result = fodcfg.dt.getDoubleVector('fake.om.offset1',ones(12,1));
fod_offset1 = 2*ones(12,1);
assertEqual(fod_offset1,result)

result = fodcfg.dt.getDoubleVector('fake.om.offset2',ones(12,1));
fod_offset2 = ones(12,1);
assertEqual(fod_offset2,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.offset2',value);
result = fodcfg.dt.getDoubleVector('fake.om.offset2',ones(12,1));
fod_offset2 = 2*ones(12,1);
assertEqual(fod_offset2,result)

result = fodcfg.dt.getStringVector('fake.om.eDerived',fodcfg.derivedOptions(1:12));
fod_eDerived = {'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1', 'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1'};
assertEqual(fod_eDerived,result)

value = {'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1', 'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1'}';
fodcfg.dt.setStringVector('fake.om.eDerived',value);
result = fodcfg.dt.getStringVector('fake.om.eDerived',fodcfg.derivedOptions(1:12));
fod_eDerived = {'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1', 'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1'}';
assertEqual(fod_eDerived,result)

result = fodcfg.dt.getDoubleVector('fake.om.eScale',ones(12,1));
fod_eScale = ones(12,1);
assertEqual(fod_eScale,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.eScale',value);
result = fodcfg.dt.getDoubleVector('fake.om.eScale',ones(12,1));
fod_eScale = 2*ones(12,1);
assertEqual(fod_eScale,result)

result = fodcfg.dt.getDoubleVector('fake.om.eOffset',ones(12,1));
fod_eOffset = ones(12,1);
assertEqual(fod_eOffset,result)

value = 2*ones(12,1);
fodcfg.dt.setDoubleVector('fake.om.eOffset',value);
result = fodcfg.dt.getDoubleVector('fake.om.eOffset',ones(12,1));
fod_eOffset = 2*ones(12,1);
assertEqual(fod_eOffset,result)

result = fodcfg.dt.getInt('fake.om.converge.steps',0);
assertEqual(0,result)

value = 1;
fodcfg.dt.setInt('fake.om.converge.steps',value);
result = fodcfg.dt.getInt('fake.om.converge.steps',0);
assertEqual(1,result)

% result = fodcfg.dt.getDouble('fake.om.converge.increment',ones(12,1));
% fod_increment = ones(12,1);
% assertEqual(fod_increment,result)
% 
% value = [2;2;2;2;2;2;2;2;2;2;2;2];
% fodcfg.dt.setDouble('fake.om.converge.increment',value);
% result = fodcfg.dt.getDouble('fake.om.converge.increment',ones(12,1));
% fod_increment = 2*ones(12,1);
% assertEqual(fod_increment,result)